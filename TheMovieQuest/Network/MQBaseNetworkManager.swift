//
//  MQBaseNetworkManager.swift
//  TheMovieQuest
//
//  Created by Uri Koren on 05/05/2024.
//

import Foundation


/// This class is designed to be inherited by subclasses where `T` represents the type of data expected in the response.
/// Subclasses should provide specific endpoint URLs and query items tailored to their respective API endpoints.
/// The `sendRequest` method handles the common networking logic including URL construction, data task execution,
/// error handling, and JSON decoding, ensuring consistent behavior across different API requests.
class MQBaseNetworkManager<T: Decodable> {
    private let baseURL = "https://api.themoviedb.org/"
    private let apiKey = "c6ecc486d4bfb63face4c8894442bd8e"
    
    var endpointURL = ""
    var queryItems: [URLQueryItem]?
    
    func sendRequest(completion: @escaping (Result<T, MQError>) -> Void) {
        var urlComponents = URLComponents(string: "\(baseURL)\(endpointURL)")
        
        urlComponents?.queryItems = queryItems
        urlComponents?.queryItems?.append(URLQueryItem(name: "api_key", value: apiKey))
        
        // Ensure the URL is valid before proceeding with the network request
        guard let url = urlComponents?.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        // Initiate a data task using URLSession to fetch data from the constructed URL
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                let errorMessage = error.localizedDescription
                completion(.failure(.networkError(errorMessage)))
                return
            }
            
            // Ensure data is received from the network response
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            // Attempt to decode the received JSON data into the specified type `T`
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
