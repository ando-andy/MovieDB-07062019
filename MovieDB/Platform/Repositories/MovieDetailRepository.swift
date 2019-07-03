//
//  MovieDetailRepository.swift
//  MovieDB
//
//  Created by kazutaka.ando on 2019/07/01.
//  Copyright © 2019 Kazando. All rights reserved.
//

protocol MovieDetailRepositoryType {
    func getMovieDetail(id: Int) -> Observable<Movie>
}

final class MovieDetailRepository: MovieDetailRepositoryType {
    
    func getMovieDetail(id: Int) -> Observable<Movie> {
        let input = API.GetMovieDetailInput(id: id)
        return API.shared.getMovieDetail(input)
    }
}
