//
//  Movie.swift
//  MovieDB
//
//  Created by kazutaka.ando on 2019/06/11.
//  Copyright © 2019 Kazando. All rights reserved.
//https://developers.themoviedb.org/3/movies/get-movie-details

import ObjectMapper

struct Movie {
    var id: Int
    var title: String
    var overview: String
    var posterPath: String
    var voteCount: Int
    var voteAverage: Double
    var backdropPath: String
    var runtime: Int
}

extension Movie {
    init() {
        self.init(
            id: 0,
            title: "",
            overview: "",
            posterPath: "",
            voteCount: 0,
            voteAverage: 0.0,
            backdropPath: "",
            runtime: 0
        )
    }
}

extension Movie: Then, HasID, Hashable { }

extension Movie: Mappable {
    
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        overview <- map["overview"]
        posterPath <- map["poster_path"]
        voteCount <- map["vote_count"]
        backdropPath <- map["backdrop_path"]
        runtime <- map["runtime"]
        voteAverage <- map["vote_average"]
    }
}
