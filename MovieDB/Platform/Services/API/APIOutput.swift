//
//  APIOutput.swift
//  MovieDB
//
//  Created by kazutaka.ando on 2019/06/11.
//  Copyright © 2019 Kazando. All rights reserved.
//

import ObjectMapper

class APIOutput: APIOutputBase {
    var message: String?
    
    override func mapping(map: Map) {
        message <- map["message"]
    }
}
