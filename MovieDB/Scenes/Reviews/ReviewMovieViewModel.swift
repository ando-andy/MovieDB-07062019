//
//  ReviewMovieViewModel.swift
//  MovieDB
//
//  Created by kazutaka.ando on 2019/07/11.
//  Copyright © 2019 Kazando. All rights reserved.
//

struct ReviewViewModel {
    let review: Review
    
    var id: String {
        return review.id
    }
    
    var author: String {
        return review.author
    }
    
    var content: String {
        return review.content
    }
}
