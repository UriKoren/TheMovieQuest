//
//  MQMainViewController.swift
//  TheMovieQuest
//
//  Created by Uri Koren on 04/05/2024.
//

import UIKit

class MQMainViewController: MQBaseViewController {
    
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var suggestionMoviesTitleLabel: UILabel!
    @IBOutlet private weak var suggestionMoviesCollectionView: UICollectionView!
    @IBOutlet private weak var searchResultsTableView: UITableView!
    
    private let suggestionMoviesNames = ["The Dark Knight", "Titanic", "Forrest Gump", "Cast Away", "shrek"]
    
    private let requestManager = MQMainRequestManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        sendSuggestionMoviesRequest()
    }

    private func configureUI() {
        suggestionMoviesTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        searchTextField.layer.cornerRadius = 15
        searchTextField.layer.borderWidth = 2
        searchTextField.layer.borderColor = UIColor.white.cgColor
        searchTextField.textColor = .white
        searchTextField.backgroundColor = .clear
        searchTextField.delegate = self
                
        suggestionMoviesCollectionView.backgroundColor = .clear
        suggestionMoviesCollectionView.registerCellForReuse(cellType: MQMoviePreviewCollectionViewCell.self)
        suggestionMoviesCollectionView.dataSource = self
        suggestionMoviesCollectionView.delegate = self
        
        searchResultsTableView.backgroundColor = .clear
        searchResultsTableView.registerCellForReuse(cellType: MQSearchedMovieTableViewCell.self)
        searchResultsTableView.dataSource = self
        searchResultsTableView.delegate = self
    }

    @IBAction func didTapSearchButton(_ sender: Any) {
        sendSearchMoviesInfoRequest()
    }
}

extension MQMainViewController : MQMainRequestManagerDelegate {
    
    private func sendSuggestionMoviesRequest() {
        startActivityIndicatorAnimation()
        
        requestManager.delegate = self
        requestManager.sendRequests(for: suggestionMoviesNames)
    }
    
    private func sendSearchMoviesInfoRequest() {
        startActivityIndicatorAnimation()

        requestManager.delegate = self
        requestManager.sendRequest(with: searchTextField.text ?? "")
    }
    
    func requestManagerSuggestions(request: MQSuggestionMoviesRequest, arrivedWith results: [MQMovieDetailResult]) {
        stopActivityIndicatorAnimation()
        
        suggestionMoviesCollectionView.reloadData()
    }
    
    func requestManagerSuggestions(request: MQSuggestionMoviesRequest, failedWithError error: MQError) {
        stopActivityIndicatorAnimation()
        
        showAlert(message: error.localizedDescription)
    }
    
    func requestManagerSearched(request: MQMovieInfoRequest, arrivedWith results: [MQMovieDetailResult]) {
        stopActivityIndicatorAnimation()

        searchResultsTableView.reloadData()
    }
    
    func requestManagerSearched(request: MQMovieInfoRequest, failedWithError error: MQError) {
        stopActivityIndicatorAnimation()

        showAlert(message: error.localizedDescription)
    }
}

extension MQMainViewController : UITextFieldDelegate {
    
    ///Restricts input to alphanumeric characters (a-z, A-Z, 0-9) and limits text length to 50 characters in a text field.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Ensure the new string contains only alphanumeric characters
        let allowedCharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
        let replacementStringCharacterSet = CharacterSet(charactersIn: string)
        let isAlphanumeric = replacementStringCharacterSet.isSubset(of: allowedCharacterSet)
        
        // Ensure the text length does not exceed 50 characters
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        let isValidLength = newText.count <= 50
        
        return isAlphanumeric && isValidLength
    }
}

extension MQMainViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return requestManager.suggestionMoviewResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MQMoviePreviewCollectionViewCell", for: indexPath) as? MQMoviePreviewCollectionViewCell else {
            
            return UICollectionViewCell()
        }
        
        let result = requestManager.suggestionMoviewResult[indexPath.item]
        
        cell.configure(with: result)
        return cell
    }
}

extension MQMainViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let result = requestManager.suggestionMoviewResult[indexPath.item]
        
        MQMovieDetailsViewController.present(presentingVC: self, result: result)
    }
}

extension MQMainViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 200, height: 200)
    }
}

extension MQMainViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requestManager.searchedMoviewResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MQSearchedMovieTableViewCell", for: indexPath) as? MQSearchedMovieTableViewCell else {
            return UITableViewCell()
        }
        
        let result = requestManager.searchedMoviewResult[indexPath.item]
        
        cell.configure(with: result)
        return cell
    }
}

extension MQMainViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let result = requestManager.searchedMoviewResult[indexPath.item]
        
        MQMovieDetailsViewController.present(presentingVC: self, result: result)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 30))
        headerView.backgroundColor = .systemOrange
        
        let label = UILabel(frame: headerView.bounds.insetBy(dx: 16, dy: 0))
        label.text = "Search Results"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        headerView.addSubview(label)
        
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30 
    }
    
}
