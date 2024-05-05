//
//  MQMovieInfoRequest.swift
//  TheMovieQuest
//
//  Created by Uri Koren on 04/05/2024.
//

import Foundation

protocol MQMovieInfoRequestDelegate: AnyObject {
    func movieInfoRequest(request: MQMovieInfoRequest, arrivedWith results: [MQMovieDetailResult])
    func movieInfoRequest(request: MQMovieInfoRequest, failedWithError error: MQError)
}

class MQMovieInfoRequest: MQBaseNetworkManager<MQMovieData> {

    weak var delegate: MQMovieInfoRequestDelegate?
    
    init(with searchText: String) {
        super.init()
        
        endpointURL = "3/search/movie"
        queryItems = [
            URLQueryItem(name: "query", value: searchText)
        ]
        
    }
    
    func sendRequest() {
        sendRequest() { result in
            switch result {
            case .success(let data):

                DispatchQueue.main.async {
                    self.delegate?.movieInfoRequest(request: self, arrivedWith: data.results)
                }
                
            case .failure(let error):
                
                DispatchQueue.main.async {
                    self.delegate?.movieInfoRequest(request: self, failedWithError: error)
                }
                
                print("Error fetching images: \(error)")
            }
        }
    }
}
