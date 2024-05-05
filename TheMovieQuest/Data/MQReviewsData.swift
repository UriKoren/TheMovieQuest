//
//  MQReviewsData.swift
//  TheMovieQuest
//
//  Created by Uri Koren on 04/05/2024.
//

import Foundation

struct MQReviewsData: Codable {
    let page: Int
    let results: [MQReviewResult]
}

struct MQReviewResult: Codable {
    let author: String
    let content: String
}
