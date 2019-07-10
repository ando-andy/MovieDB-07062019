//
//  MovieDetailNavigator.swift
//
//  Created by kazutaka.ando on 6/27/19.
//

protocol MovieDetailNavigatorType {
    func toCastDetail(cast: Cast)
    func backward()
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
}
