//
//  MovieDetailUseCaseMock.swift
//
//  Created by kazutaka.ando on 6/27/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

@testable import MovieDB
import RxSwift

final class MovieDetailUseCaseMock: MovieDetailUseCaseType {
    
    //MARK: getMovieDetail
    var getMovieDetailCalled = false
    
    var getMovieDetailReturnValue: Observable<Movie> = {
        let item = Movie().with {
            $0.id = 1
            //TODO
        }
        return Observable.just(item)
    }()
    
    func getMovieDetail(movieId: Int) -> Observable<Movie> {
        getMovieDetailCalled = true
        return getMovieDetailReturnValue
    }
}
