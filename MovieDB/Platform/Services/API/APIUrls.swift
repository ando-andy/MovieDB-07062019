//
//  APIUrls.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 5/29/19.
//
extension API {
    enum Urls {
        static let baseURL = "https://api.themoviedb.org/3"
        static let baseURLImage = "https://image.tmdb.org/t/p/original"
        
        static let getMovieList = baseURL + "/movie/"
        static let getSearchList = baseURL + "/search/movie"
        static let getCastList = baseURL + "/person/"
        static let getMovieListByCast = baseURL + "/discover/movie"
    }
}
