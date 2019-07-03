//
//  MovieDetailUseCase.swift
//
//  Created by kazutaka.ando on 6/27/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

protocol MovieDetailUseCaseType {
    func getMovieDetail(movieId: Int) -> Observable<Movie>
}

struct MovieDetailUseCase: MovieDetailUseCaseType {
    let movieDetailRepository: MovieDetailRepositoryType
    
    func getMovieDetail(movieId: Int) -> Observable<Movie> {
        return movieDetailRepository.getMovieDetail(id: movieId)
    }
}
