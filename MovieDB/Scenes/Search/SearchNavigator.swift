//
//  SearchNavigator.swift
//
//  Created by kazutaka.ando on 6/26/19.
//

protocol SearchNavigatorType {
    func toMovieDetail(movie: Movie)
}

struct SearchNavigator: SearchNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toMovieDetail(movie: Movie) {
        let vc: MovieDetailViewController = assembler.resolve(navigationController: navigationController,
                                                              movie: movie)
        navigationController.pushViewController(vc, animated: true)
    }

}
