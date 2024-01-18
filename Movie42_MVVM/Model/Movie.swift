//
//  Movie.swift
//  Movie42_MVVM
//
//  Created by Bae on 1/16/24.
//

import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Float
    let posterPath: String
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Float
    let voteCount: Int
        
    // posterURL을 posterPath 기반으로 생성하는 계산된 속성
    var posterURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
}
