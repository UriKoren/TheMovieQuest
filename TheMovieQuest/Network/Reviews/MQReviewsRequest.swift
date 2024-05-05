//
//  MQReviewsRequest.swift
//  TheMovieQuest
//
//  Created by Uri Koren on 04/05/2024.
//

import Foundation

protocol MQReviewsRequestDelegate: AnyObject {
    func reviewsRequest(request: MQReviewsRequest, arrivedWith results: [MQReviewResult])
    func reviewsRequest(request: MQReviewsRequest, failedWithError error: MQError)
}

class MQReviewsRequest: MQBaseNetworkManager<MQReviewsData> {

    weak var delegate: MQReviewsRequestDelegate?
    
    init(with movieId: String) {
        super.init()
        
        endpointURL = "3/movie/\(movieId))/reviews"
        queryItems = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1")
        ]
        
    }
    
    func sendRequest() {
        
        sendRequest() { result in
            switch result {
            case .success(let data):

                DispatchQueue.main.async {
                    self.delegate?.reviewsRequest(request: self, arrivedWith: data.results)
                }
                
            case .failure(let error):
                
                DispatchQueue.main.async {
                    self.delegate?.reviewsRequest(request: self, failedWithError: error)
                }
                
                print("Error fetching images: \(error)")
            }
        }
    }
}
