//
//  MQMovieDetailsViewController.swift
//  TheMovieQuest
//
//  Created by Uri Koren on 04/05/2024.
//

import UIKit

class MQMovieDetailsViewController: MQBaseViewController {
        
    @IBOutlet private weak var backgroundView: UIView!
    @IBOutlet private weak var moviePreviewImageView: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    
    @IBOutlet private weak var reviewsTitleLabel: UILabel!
    @IBOutlet private weak var reviewsCollectionView: UICollectionView!
    
    private let requestManager = MQMovieDetailsRequestManager()
    private let imageLoaderManager = MQImageLoaderManager()
    
    private var result: MQMovieDetailResult?
        
    /// Presents `MQMovieDetailsViewController` from a presenting view controller with a specified movie result.
    class func present(presentingVC: UIViewController, result: MQMovieDetailResult)  {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let vc = storyboard.instantiateViewController(withIdentifier: "MQMovieDetailsViewController") as? MQMovieDetailsViewController {
            
            vc.result = result
            
            presentingVC.present(vc, animated: true, completion: nil)
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        sendReviewsRequest()
    }
    
    private func configureUI() {
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        backgroundView.layer.cornerRadius = 15
        
        configureImageView()
        configureDetailsLabels()
        configureReviewsCollectionView()
    }
    
    //Load movie preview image using image loader manager
    private func configureImageView() {
        imageLoaderManager.loadImage(from: result?.imageUrl) { [weak self] (image) in
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async {
                if let image = image {
                    
                    self.moviePreviewImageView.image = image
                    
                } else {
                    // Set a placeholder image if loading fails
                    self.moviePreviewImageView.image = UIImage(systemName: "photo.artframe")
                    
                    print("Failed to load image to \(self.result?.title ?? "") movie")
                }
            }
        }
    }
    
    private func configureDetailsLabels() {
        // Configure movie title label
        if let title = result?.title {
            movieTitleLabel.text = "Title: \(title)"
        }
        else {
            movieTitleLabel.isHidden = true
        }
        
        // Configure overview label
        if let overview = result?.overview {
            overviewLabel.text = "Overview: \(overview)"
        }
        else {
            overviewLabel.isHidden = true
        }
        
        // Configure release date label
        if let releaseDate = result?.releaseDate {
            releaseDateLabel.text = "Release Date: \(releaseDate)"
        }
        else {
            releaseDateLabel.isHidden = true
        }
    }
    
    private func configureReviewsCollectionView() {
        // Set title for reviews section
        reviewsTitleLabel.text = "Reviews"
        reviewsTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        // Configure collection view appearance and data source
        reviewsCollectionView.backgroundColor = .clear
        reviewsCollectionView.registerCellForReuse(cellType: MQReviewCollectionViewCell.self)
        reviewsCollectionView.dataSource = self
        reviewsCollectionView.delegate = self
    }
    
    private func shareImage() {
        guard let image = moviePreviewImageView.image else {
            return
        }
        
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = view  // For iPad support
        
        // Present the activity view controller
        present(activityViewController, animated: true, completion: nil)
    }
    
    // MARK: - IBActions

    @IBAction func didTapShareButton(_ sender: Any) {

        shareImage()
    }
    
    @IBAction func didTapCloseButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension MQMovieDetailsViewController : MQMovieDetailsRequestManagerDelegate {
    
    private func sendReviewsRequest() {
        startActivityIndicatorAnimation()
        
        requestManager.delegate = self
        requestManager.sendRequest(with: "\(result?.id ?? 0)")
    }
    
    func movieDetailsRequestManager(request: MQReviewsRequest, arrivedWith results: [MQReviewResult]) {
        stopActivityIndicatorAnimation()
        
        reviewsCollectionView.reloadData()
    }
    
    func movieDetailsRequestManager(request: MQReviewsRequest, failedWithError error: MQError) {
        stopActivityIndicatorAnimation()

        showAlert(message: error.localizedDescription)
    }
}

extension MQMovieDetailsViewController : UICollectionViewDataSource {
    
    /// Limit items displayed to a maximum of 3 or available reviews count
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(3, requestManager.reviewsResults.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MQReviewCollectionViewCell", for: indexPath) as? MQReviewCollectionViewCell else {
            
            return UICollectionViewCell()
        }
        
        let result = requestManager.reviewsResults[indexPath.item]
        
        cell.configure(with: result)   
        return cell
    }
}

extension MQMovieDetailsViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 90, height: 180)
    }
}

