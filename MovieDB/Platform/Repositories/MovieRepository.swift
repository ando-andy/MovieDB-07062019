//
//  MovieRepository.swift
//  MovieDB
//
//  Created by kazutaka.ando on 2019/06/11.
//  Copyright © 2019 Kazando. All rights reserved.
//

import UIKit

protocol MoviesRepositoryType {
    func getMoviesList(category: CategoryType, page: Int) -> Observable<PagingInfo<Movie>>
    
    func getSearchMovies(key: String, page: Int) -> Observable<PagingInfo<Movie>>
}

final class MoviesRepository: MoviesRepositoryType {
    func getMoviesList(category: CategoryType, page: Int) -> Observable<PagingInfo<Movie>> {
        let input = API.GetMovieListInput(category: category, page: page)
        return API.shared.getMovieList(input)
            .map { output in
                guard let movies = output.movies else {
                    throw APIInvalidResponseError()
                }
                return PagingInfo<Movie>(page: page, items: movies)
            }
    }
    
    func getSearchMovies(key: String, page: Int) -> Observable<PagingInfo<Movie>> {
        let input = API.GetSearchMovieListInput(keySearch: key, page: page)
        return API.shared.getSearchMovieList(input)
            .map { output in
                guard let movies = output.movies else {
                    throw APIInvalidResponseError()
                }
                return PagingInfo<Movie>(page: page, items: movies)
            }
    }
}
