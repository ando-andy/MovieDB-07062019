//
//  MovieDetailNavigatorMock.swift
//
//  Created by kazutaka.ando on 6/27/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

@testable import MovieDB

final class MovieDetailNavigatorMock: MovieDetailNavigatorType {
    
    var backwardCalled = false
    
    // MARK: - CastDetail
    func toCastDetail() {
        //TODO
    }
    
    // MARK: - backWard
    func backward() {
        backwardCalled = true
    }
}
