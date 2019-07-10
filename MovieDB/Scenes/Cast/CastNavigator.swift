//
//  CastNavigator.swift
//
//  Created by kazutaka.ando on 7/9/19.

//

protocol CastNavigatorType {
    func toMovieDetail(movie: Movie)
    func backward()
}

struct CastNavigator: CastNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController

    func toMovieDetail(movie: Movie) {
        let vc: MovieDetailViewController = assembler.resolve(navigationController: navigationController,
                                                              movie: movie)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func backward() {
        navigationController.popViewController(animated: true)
    }
}
