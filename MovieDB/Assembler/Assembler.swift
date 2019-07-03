//
//  Assembler.swift
//  MovieDB
//
//  Created by kazutaka.ando on 2019/06/10.
//  Copyright © 2019 Kazando. All rights reserved.
//

protocol Assembler: class,
    CategoriesAssembler,
    FavoriteAssembler,
    MoviesAssembler,
    MainAssembler,
    MovieDetailAssembler,
    RepositoriesAssembler,
    SearchAssembler,
    AppAssembler {
    
}

final class DefaultAssembler: Assembler {
    
}
