//
//  MovieScreen.swift
//  Movie42_MVVM
//
//  Created by Bae on 1/18/24.
//

import Foundation

class MovieViewModel {
    let movies: [MovieInfo] = [
    MovieInfo(title: "아이언맨", openDate: "2008.04.30", theater: 430, poster: "ironman.png"),
    MovieInfo(title: "1234", openDate: "1234", theater: 211, poster: "213.png")
     ]
    
    var listCount : Int {
        return movies.count
    }
    
    func getTheMovie(at idx:Int) -> MovieInfo {
        return movies[idx]
    }
}
