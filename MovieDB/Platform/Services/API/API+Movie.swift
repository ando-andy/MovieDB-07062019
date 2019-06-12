//
//  API+Movie.swift
//  MovieDB
//
//  Created by kazutaka.ando on 2019/06/11.
//  Copyright © 2019 Kazando. All rights reserved.
//


import ObjectMapper

extension API {
    func getMovieList(_ input: GetMovieListInput) -> Observable<GetMovieListOutput> {
        return request(input)
    }
}

// MARK: - GetRepoList
extension API {
    final class GetMovieListInput: APIInput {
        init(category: MovieCategoryType, page: Int) {
            let params: JSONDictionary = [
                "api_key": Keys.APIKey,
                //created on APIKey in Support dir and added to gitignore
                "page": page
            ]
            super.init(urlString: API.Urls.getMovieList + category.rawValue,
                       parameters: params,
                       requestType: .get,
                       requireAccessToken: true)
        }
    }
    
    final class GetMovieListOutput: APIOutput {
        private(set) var movies: [Movie]?
        
        override func mapping(map: Map) {
            super.mapping(map: map)
            movies <- map["results"]
        }
    }
}
