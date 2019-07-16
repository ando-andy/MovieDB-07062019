//
//  Review.swift
//  MovieDB
//
//  Created by kazutaka.ando on 2019/07/11.
//  Copyright © 2019 Kazando. All rights reserved.
//https://developers.themoviedb.org/3/reviews/get-review-details

import ObjectMapper

struct Review {
    var id: String
    var author: String
    var content: String
}

extension Review {
    init() {
        self.init(
            id: "",
            author: "",
            content: ""
        )
    }
}

extension Review: Then, HasID, Hashable {}

extension Review: Mappable {
    
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        author <- map["author"]
        content <- map["content"]
    }
}
