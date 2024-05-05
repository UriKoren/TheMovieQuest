//
//  UIView+AddBlurEffect.swift
//  TheMovieQuest
//
//  Created by Uri Koren on 05/05/2024.
//

import UIKit

extension UIView {
    func addBlurEffect() {
        
        // Create blur effect and blur view
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        // Configure blur view
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.layer.cornerRadius = 15
        blurView.clipsToBounds = true
        
        // Add blur view as a subview
        self.insertSubview(blurView, at: 0)
        
        // Set constraints to make the blur view cover the entire parent view
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: self.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blurView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            blurView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
