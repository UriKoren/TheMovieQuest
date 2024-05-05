//
//  MQSuggestionMoviesRequest.swift
//  TheMovieQuest
//
//  Created by Uri Koren on 04/05/2024.
//
import Foundation

protocol MQSuggestionMoviesRequestDelegate: AnyObject {
    func suggestionMoviesRequest(request: MQSuggestionMoviesRequest, arrivedWith results: [MQMovieDetailResult])
    func suggestionMoviesRequest(request: MQSuggestionMoviesRequest, failedWithError error: MQError)
}

class MQSuggestionMoviesRequest: MQBaseNetworkManager<MQMovieData> {

    weak var delegate: MQSuggestionMoviesRequestDelegate?
    
    override init() {
        super.init()
        
        endpointURL = "3/search/movie"
        
    }
    
    /**
     Sends multiple network requests concurrently to fetch movie details for a list of suggested movies.

     This method asynchronously sends requests for each movie name in the `suggestionMovies` array. 
     Upon completion of all requests, it notifies the delegate with either the aggregated movie details if all requests succeed or an error indicating partial or complete failure.
    */
    func sendRequest(with suggestionMovies: [String]) {
        
        var completedResults: [MQMovieDetailResult?] = Array(
            repeating: nil,
            count: suggestionMovies.count
        )
        
        var errorOccurred = false
        
        // Dispatch group to wait for all requests to finish
        let dispatchGroup = DispatchGroup()
        
        for (index, movieName) in suggestionMovies.enumerated() {
            dispatchGroup.enter()
            
            let suggestionMovie = suggestionMovies[index]
            queryItems = [URLQueryItem(name: "query", value: suggestionMovie)]
            
            sendRequest() { result in
                defer {
                    dispatchGroup.leave()
                }
                
                switch result {
                case .success(let data):
                    
                    completedResults[index] = data.results.first // Store the first result for simplicity
                    
                case .failure(let error):
                    
                    print("Error fetching movie data for '\(movieName)': \(error)")
                    errorOccurred = true
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            if errorOccurred {
                self.delegate?.suggestionMoviesRequest(request: self, failedWithError: .networkError("One or more requests failed"))
                
            } else {
                // Check if all requests completed successfully
                if completedResults.allSatisfy({ $0 != nil }) {
                    let aggregatedResults = completedResults.compactMap { $0 }
                                        
                    self.delegate?.suggestionMoviesRequest(request: self, arrivedWith: aggregatedResults)
                    
                } else {
                    self.delegate?.suggestionMoviesRequest(request: self, failedWithError: .networkError("One or more requests did not return data"))
                }
            }
        }
    }
}
