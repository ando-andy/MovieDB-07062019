//
//  Gender.swift
//  MovieDB
//
//  Created by kazutaka.ando on 2019/07/09.
//  Copyright © 2019 Kazando. All rights reserved.
//

enum Gender: Int {
    case none = 0
    case female = 1
    case male = 2
    
    var title: String {
        switch self {
        case .female:
            return "Female"
        case .male:
            return "Male"
        default:
            return "None"
        }
    }
}
