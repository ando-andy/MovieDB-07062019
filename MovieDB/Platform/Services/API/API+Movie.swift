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

    func getSearchMovieList(_ input: GetSearchMovieListInput) -> Observable<GetSearchMovieListOutput> {
        return request(input)
    }
    
    func getMovieDetail(_ input: GetMovieDetailInput) -> Observable<Movie> {
        return request(input)
    }

}

// MARK: - GetRepoList
extension API {
    final class GetMovieListInput: APIInput {
        init(category: CategoryType, page: Int) {
            let params: JSONDictionary = [
                "api_key": Keys.APIKey,
                //created in Support dir and added to gitignore
                "page": page
            ]
            super.init(urlString: API.Urls.getMovieList + category.urlString,
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

// MARK: - GetRepoList
    final class GetSearchMovieListInput: APIInput {
        init(keySearch: String, page: Int) {
            let params: JSONDictionary = [
                "api_key": Keys.APIKey,
                //created in Support dir and added to gitignore
                "query": keySearch,
                "page": page
            ]
            super.init(urlString: API.Urls.getSearchList,
                       parameters: params,
                       requestType: .get,
                       requireAccessToken: true)
        }
    }
    
    final class GetSearchMovieListOutput: APIOutput {
        private(set) var movies: [Movie]?
        
        override func mapping(map: Map) {
            super.mapping(map: map)
            movies <- map["results"]
        }
    }
    
    final class GetMovieDetailInput: APIInput {
        init(id: Int) {
            let params: JSONDictionary = [
                "api_key": Keys.APIKey,
                "append_to_response": "videos,credits"
            ]
            super.init(urlString: API.Urls.getMovieList + String(id),
                       parameters: params,
                       requestType: .get,
                       requireAccessToken: true)
        }
    }
}
