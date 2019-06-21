//
//  MovieCategoryType.swift
//  MovieDB
//
//  Created by kazutaka.ando on 2019/06/11.
//  Copyright © 2019 Kazando. All rights reserved.
//  https://www.themoviedb.org/documentation/api
//  https://developers.themoviedb.org/3/credits/get-credit-details

enum CategoryType {

    case popular ([Movie])
    case nowPlaying ([Movie])
    case upcoming ([Movie])
    case topRated ([Movie])
    
    var urlString: String {
        switch self {
        case .popular(_):
            return "popular"
        case .nowPlaying(_):
            return "now_playing"
        case .upcoming(_):
            return "upcoming"
        case .topRated(_):
            return "top_rated"
        }
    }
    
    var categoryTitle: String {
        switch self {
        case .popular(_):
            return "Popular"
        case .nowPlaying(_):
            return "Now playing"
        case .upcoming(_):
            return "Upcoming"
        case .topRated(_):
            return "Top rate"
        }
    }
    
    var movies: [Movie] {
        switch self {
        case .popular(let popularMovies):
            return popularMovies
        case .nowPlaying(let nowPlayingMovies):
            return nowPlayingMovies
        case .upcoming(let upcomingMovies):
            return upcomingMovies
        case .topRated(let topRatedMovies):
            return topRatedMovies
        }
    }
}
