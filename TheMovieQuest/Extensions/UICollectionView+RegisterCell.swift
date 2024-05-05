//
//  UICollectionView+RegisterCell.swift
//  TheMovieQuest
//
//  Created by Uri Koren on 04/05/2024.
//

import UIKit

extension UICollectionView {
    
    ///// Convenient method to register a UICollectionView subclass for reuse with its associated nib.
    func registerCellForReuse(cellType: UICollectionViewCell.Type) {
        let identifier: String = String(describing: cellType)
        self.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
}


