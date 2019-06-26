//
//  CategoriesNavigatorMock.swift
//
//  Created by kazutaka.ando on 6/11/19.
//  Copyright © 2019 kazando All rights reserved.
//

@testable import MovieDB

final class CategoriesNavigatorMock: CategoriesNavigatorType {
    
    var toMovieDetailCalled = false

    func toMovieDetail() {
        toMovieDetailCalled = true
    }
}
