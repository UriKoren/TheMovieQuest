//
//  MQBaseViewController.swift
//  TheMovieQuest
//
//  Created by Uri Koren on 04/05/2024.
//

import UIKit

class MQBaseViewController: UIViewController {
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView?

    func startActivityIndicatorAnimation() {
        activityIndicator?.startAnimating()
    }
    
    func stopActivityIndicatorAnimation() {
        activityIndicator?.stopAnimating()
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}
