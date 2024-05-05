//
//  MQReviewCollectionViewCell.swift
//  TheMovieQuest
//
//  Created by Uri Koren on 04/05/2024.
//

import UIKit

class MQReviewCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var reviewContrinerView: UIView!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var reviewContentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        reviewContrinerView.layer.cornerRadius = 15        
    }

    func configure(with result: MQReviewResult) {
        authorLabel.text = "Author: \(result.author)"
        reviewContentLabel.text = result.content

    }
}
