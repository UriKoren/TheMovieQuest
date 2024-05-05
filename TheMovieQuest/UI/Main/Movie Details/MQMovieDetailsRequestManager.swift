//
//  MQMovieDetailsRequestManager.swift
//  TheMovieQuest
//
//  Created by Uri Koren on 04/05/2024.
//

import Foundation

protocol MQMovieDetailsRequestManagerDelegate: AnyObject {
    func movieDetailsRequestManager(request: MQReviewsRequest, arrivedWith results: [MQReviewResult])
    func movieDetailsRequestManager(request: MQReviewsRequest, failedWithError error: MQError)
}

class MQMovieDetailsRequestManager {
        
    weak var delegate: MQMovieDetailsRequestManagerDelegate?

    private(set) var reviewsResults: [MQReviewResult] = []

    func sendRequest(with id: String) {
        let movieInfoRequest = MQReviewsRequest(with: id)
        movieInfoRequest.delegate = self
        movieInfoRequest.sendRequest()
    }
}

extension MQMovieDetailsRequestManager : MQReviewsRequestDelegate {
    
    func reviewsRequest(request: MQReviewsRequest, arrivedWith results: [MQReviewResult]) {
        self.reviewsResults = results
        
        delegate?.movieDetailsRequestManager(request: request, arrivedWith: results)
    }
    
    func reviewsRequest(request: MQReviewsRequest, failedWithError error: MQError) {
        delegate?.movieDetailsRequestManager(request: request, failedWithError: error)
    }
}


