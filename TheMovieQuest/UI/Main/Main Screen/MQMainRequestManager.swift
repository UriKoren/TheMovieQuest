//
//  MQMainRequestManager.swift
//  TheMovieQuest
//
//  Created by Uri Koren on 04/05/2024.
//

import Foundation

protocol MQMainRequestManagerDelegate: AnyObject {
    func requestManagerSearched(request: MQMovieInfoRequest, arrivedWith results: [MQMovieDetailResult])
    func requestManagerSearched(request: MQMovieInfoRequest, failedWithError error: MQError)
    
    func requestManagerSuggestions(request: MQSuggestionMoviesRequest, arrivedWith results: [MQMovieDetailResult])
    func requestManagerSuggestions(request: MQSuggestionMoviesRequest, failedWithError error: MQError)
}

class MQMainRequestManager {
        
    weak var delegate: MQMainRequestManagerDelegate?

    private(set) var suggestionMoviewResult: [MQMovieDetailResult] = []
    private(set) var searchedMoviewResult: [MQMovieDetailResult] = []

    func sendRequest(with searchText: String) {
        let movieInfoRequest = MQMovieInfoRequest(with: searchText)
        movieInfoRequest.delegate = self
        movieInfoRequest.sendRequest()
    }
    
    func sendRequests(for movieNames: [String]) {
        let movieInfoRequest = MQSuggestionMoviesRequest()
        movieInfoRequest.delegate = self
        movieInfoRequest.sendRequest(with: movieNames)
    }
}

extension MQMainRequestManager : MQMovieInfoRequestDelegate {
    
    func movieInfoRequest(request: MQMovieInfoRequest, arrivedWith results: [MQMovieDetailResult]) {
        searchedMoviewResult = results
        delegate?.requestManagerSearched(request: request, arrivedWith: results)
    }
    
    func movieInfoRequest(request: MQMovieInfoRequest, failedWithError error: MQError) {
        searchedMoviewResult = []
        delegate?.requestManagerSearched(request: request, failedWithError: error)
    }
}

extension MQMainRequestManager : MQSuggestionMoviesRequestDelegate {
    
    func suggestionMoviesRequest(request: MQSuggestionMoviesRequest, arrivedWith results: [MQMovieDetailResult]) {
        
        suggestionMoviewResult = results
        
        delegate?.requestManagerSuggestions(request: request, arrivedWith: results)
    }
    
    func suggestionMoviesRequest(request: MQSuggestionMoviesRequest, failedWithError error: MQError) {
        suggestionMoviewResult = []

        delegate?.requestManagerSuggestions(request: request, failedWithError: error)
    }
}
