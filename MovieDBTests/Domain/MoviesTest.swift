//
//  MoviesTest.swift
//  MovieDBTests
//
//  Created by kazutaka.ando on 2019/06/11.
//  Copyright © 2019 Kazando. All rights reserved.
//

import XCTest
@testable import MovieDB

final class MovieTests: XCTestCase {
    
    func test_mapping() {
        let json: [String: Any] = [
            "id": 1,
            "title": "Joker",
            "overview": "Batman",
            "vote_count": 10
        ]
        let movie = Movie(JSON: json)
        
        XCTAssertNotNil(movie)
        XCTAssertEqual(movie?.id, json["id"] as? Int)
        XCTAssertEqual(movie?.title, json["title"] as? String)
        XCTAssertEqual(movie?.overview, json["overview"] as? String)
        XCTAssertEqual(movie?.voteCount, json["vote_count"] as? Int)
    }
}
