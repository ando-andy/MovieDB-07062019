//
//  CastNavigatorMock.swift
//
//  Created by kazutaka.ando on 7/9/19.

//

@testable import MovieDB

final class CastNavigatorMock: CastNavigatorType {

    var toMovieDetailCalled = false
    var backwardCalled = false
    
    // MARK: - MovieDetail
    func toMovieDetail(movie: Movie) {
        toMovieDetailCalled = true
    }
    // MARK: - backWard
    func backward() {
        backwardCalled = true
    }
}
