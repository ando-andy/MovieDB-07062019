//
//  RepositoriesAssembler.swift
//  MovieDB
//
//  Created by kazutaka.ando on 2019/06/19.
//  Copyright © 2019 Kazando. All rights reserved.
//

protocol RepositoriesAssembler {
    func resolve() -> MoviesRepositoryType
    func resolve() -> MovieDetailRepositoryType
    func resolve() -> CastRepositoryType
}

extension RepositoriesAssembler where Self: DefaultAssembler {
    func resolve() -> MoviesRepositoryType {
        return MoviesRepository()
    }
    
    func resolve() -> MovieDetailRepositoryType {
        return MovieDetailRepository()
    }
    
    func resolve() -> CastRepositoryType {
        return CastRepository()
    }
}
