//
//  MQMoviePreviewCollectionViewCell.swift
//  TheMovieQuest
//
//  Created by Uri Koren on 04/05/2024.
//

import UIKit

class MQMoviePreviewCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var imageContainerView: UIView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    
    private let imageLoaderManager = MQImageLoaderManager()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageContainerView.layer.cornerRadius = 15
        imageContainerView.backgroundColor = .clear
        
        imageContainerView.addBlurEffect()

        imageView.layer.cornerRadius = 15
    }
    
    func configure(with result: MQMovieDetailResult) {
        movieTitleLabel.text = result.originalTitle
                
        imageLoaderManager.loadImage(from: result.imageUrl) { [weak self] (image) in
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async {
                if let image = image {
                    self.imageView.image = image
                    
                } else {
                    self.imageView.image = UIImage(systemName: "photo.artframe")

                    print("Failed to load image to \(result.title) movie")
                }
            }
        }
    }
}
