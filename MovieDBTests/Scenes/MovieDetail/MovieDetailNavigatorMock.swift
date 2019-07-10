//
//  MovieDetailNavigatorMock.swift
//
//  Created by kazutaka.ando on 6/27/19.

//

@testable import MovieDB

final class MovieDetailNavigatorMock: MovieDetailNavigatorType {

    var toCastDetailCalled = false
    var backwardCalled = false
    
    // MARK: - CastDetail
    func toCastDetail(cast: Cast) {
        toCastDetailCalled = true
    }
    // MARK: - backWard
    func backward() {
        backwardCalled = true
    }
}
