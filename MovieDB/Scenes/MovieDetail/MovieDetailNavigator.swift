//
//  MovieDetailNavigator.swift
//
//  Created by kazutaka.ando on 6/27/19.
//

protocol MovieDetailNavigatorType {
    func toCastDetail(cast: Cast)
    func backward()
    func toReviews(movie: Movie)
}

struct MovieDetailNavigator: MovieDetailNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController

    func toCastDetail(cast: Cast) {
        let vc: CastViewController = assembler.resolve(navigationController: navigationController,
                                                       cast: cast)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func backward() {
        navigationController.popViewController(animated: true)
    }
    
    func toReviews(movie: Movie) {
        let vc: ReviewsViewController = assembler.resolve(navigationController: navigationController,
                                                          movie: movie)
        navigationController.pushViewController(vc, animated: true)
    }
}
