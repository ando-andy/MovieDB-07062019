//
//  MovieDetailUseCaseMock.swift
//
//  Created by kazutaka.ando on 6/27/19.

//

@testable import MovieDB
import RxSwift

final class MovieDetailUseCaseMock: MovieDetailUseCaseType {
    
    // MARK: - getMovieDetail
    var getMovieDetailCalled = false
    
    var getMovieDetailReturnValue: Observable<Movie> = {
        let item = Movie().with {
            $0.id = 1
            $0.castList = [Cast()]
        }
        return Observable.just(item)
    }()
    
    func getMovieDetail(movieId: Int) -> Observable<Movie> {
        getMovieDetailCalled = true
        return getMovieDetailReturnValue
    }
}
