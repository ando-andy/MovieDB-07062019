//
//  APIUrls.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 5/29/19.
//
extension API {
    enum Urls {
        static let baseURL = "https://api.themoviedb.org/3"
        static let baseURLImage = "http://image.tmdb.org/t/p"
        
        static let getMovieList = baseURL + "/movie/"
    }
}
