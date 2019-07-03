//
//  SearchNavigatorMock.swift
//
//  Created by kazutaka.ando on 6/26/19.
//

@testable import MovieDB

final class SearchNavigatorMock: SearchNavigatorType {

    var toMovieDetailCalled = false

    func toMovieDetail(movie: Movie) {
        toMovieDetailCalled = true
    }
}
