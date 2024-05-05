//
//  MQSearchedMovieTableViewCell.swift
//  TheMovieQuest
//
//  Created by Uri Koren on 04/05/2024.
//

import UIKit

class MQSearchedMovieTableViewCell: UITableViewCell {
    @IBOutlet private weak var movieContainerView: UIView!
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieOverview: UILabel!
    
    private let imageLoaderManager = MQImageLoaderManager()

    override func awakeFromNib() {
        super.awakeFromNib()      
        
        movieContainerView.backgroundColor = .clear
        movieContainerView.layer.cornerRadius = 15
        movieContainerView.addBlurEffect()
        
        movieImageView.layer.cornerRadius = 15
    }

    func configure(with result: MQMovieDetailResult) {
        movieTitleLabel.text = "Name: \(result.originalTitle)"
        movieOverview.text = "Overview: \( result.overview)"
        
        imageLoaderManager.loadImage(from: result.imageUrl) { [weak self] (image) in
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async {
                if let image = image {
                    
                    self.movieImageView.image = image
                    
                } else {
                    self.movieImageView.image = UIImage(systemName: "photo.artframe")
                    
                    print("Failed to load image to \(result.title) movie")
                }
            }
        }
    }
}
