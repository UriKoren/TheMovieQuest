//
//  MQError.swift
//  TheMovieQuest
//
//  Created by Uri Koren on 04/05/2024.
//

import Foundation

/// Enum representing custom errors for network requests.
/// Possible cases include `invalidURL`, `noData`, `decodingError`, and `networkError` with an associated message.
enum MQError: Error {
    case invalidURL
    case noData
    case decodingError
    case networkError(String)
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        case .decodingError:
            return "Error decoding data"
        case .networkError(let string):
            return "Network error: \(string)"
        }
    }
}
