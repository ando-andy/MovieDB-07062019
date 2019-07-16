//
//  API+Review.swift
//  MovieDB
//
//  Created by kazutaka.ando on 2019/07/12.
//  Copyright © 2019 Kazando. All rights reserved.
//

import ObjectMapper

extension API {
    func getListReview(_ input: GetReviewListInput) -> Observable<GetReviewListOutput> {
        return request(input)
    }
}

extension API {
    final class GetReviewListInput: APIInput {
        init(id: Int, page: Int) {
            let params: JSONDictionary = [
                "api_key": Keys.APIKey,
                "page": page
            ]
            super.init(urlString: API.Urls.getMovieList + String(format: "%ld/reviews", id),
                       parameters: params,
                       requestType: .get,
                       requireAccessToken: true)
        }
    }
    
    final class GetReviewListOutput: APIOutput {
        private(set) var reviews: [Review]?
        
        override func mapping(map: Map) {
            super.mapping(map: map)
            reviews <- map["results"]
        }
    }
}
