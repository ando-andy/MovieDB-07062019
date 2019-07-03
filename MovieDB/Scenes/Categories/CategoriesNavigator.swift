//
//  CategoriesNavigator.swift
//
//  Created by kazutaka.ando on 6/11/19.
//  Copyright © 2019 kazando All rights reserved.
//

protocol CategoriesNavigatorType {
    func toMovieDetail(movie: Movie)
}

struct CategoriesNavigator: CategoriesNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toMovieDetail(movie: Movie) {
        let vc: MovieDetailViewController = assembler.resolve(navigationController: navigationController,
                                                              movie: movie)
        navigationController.pushViewController(vc, animated: true)
    }
}
