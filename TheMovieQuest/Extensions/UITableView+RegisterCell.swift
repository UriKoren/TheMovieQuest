//
//  UITableView+RegisterCell.swift
//  TheMovieQuest
//
//  Created by Uri Koren on 05/05/2024.
//

import UIKit

extension UITableView {
    
    ///// Convenient method to register a UITableViewCell subclass for reuse with its associated nib.
    func registerCellForReuse(cellType: UITableViewCell.Type) {
        let identifier: String = String(describing: cellType)
        self.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
}
