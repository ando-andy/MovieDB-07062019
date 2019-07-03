//
//  MovieViewModel.swift
//  MovieDB
//
//  Created by kazutaka.ando on 2019/06/19.
//  Copyright © 2019 Kazando. All rights reserved.
//

import UIKit

struct MovieViewModel {
    let movie: Movie
    
    var name: String {
        return movie.title
    }
    
    var overview: String {
        return movie.overview
    }
    
    var voteCount: Int {
        return movie.voteCount
    }
    
    var voteAverage: Double {
        return movie.voteAverage
    }
    
    var posterImageURL: URL? {
        return URL(string: API.Urls.baseURLImage + movie.posterPath)
    }
    
    var backdropImageURL: URL? {
        return URL(string: API.Urls.baseURLImage + movie.backdropPath)
    }
    
    var runtime: Int {
        return movie.runtime
    }
}
