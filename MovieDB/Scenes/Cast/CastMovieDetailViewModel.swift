//
//  CastMovieDetailViewModel.swift
//  MovieDB
//
//  Created by kazutaka.ando on 2019/07/09.
//  Copyright © 2019 Kazando. All rights reserved.
//

import UIKit

struct CastMovieDetailViewModel {
    let cast: Cast
    
    var id: Int {
        return cast.id
    }
    
    var name: String {
        return cast.name
    }
    
    var castId: Int {
        return cast.castId
    }
    
    var profileImageURL: URL? {
        return URL(string: API.Urls.baseURLImage + cast.profilePath)
    }
    
    var gender: Gender {
        return cast.gender
    }
    
    var biography: String {
        return cast.biography
    }
    
    var placeOfBirth: String {
        return cast.placeOfBirth
    }
    
    var birthdayString: String {
        return cast.birthday.toString(dateFormat: DateFormatter.Format.date.rawValue)
    }
    
    var knowFor: String {
        return cast.knowFor
    }
}
