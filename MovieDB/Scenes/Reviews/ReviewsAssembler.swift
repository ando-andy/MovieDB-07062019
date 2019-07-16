//
//  ReviewsAssembler.swift
//
//  Created by kazutaka.ando on 7/11/19.
//

import UIKit

protocol ReviewsAssembler {
    func resolve(navigationController: UINavigationController,
                 movie: Movie) -> ReviewsViewController
    func resolve(navigationController: UINavigationController,
                 movie: Movie) -> ReviewsViewModel
    func resolve(navigationController: UINavigationController) -> ReviewsNavigatorType
    func resolve() -> ReviewsUseCaseType
}

extension ReviewsAssembler {
    func resolve(navigationController: UINavigationController,
                 movie: Movie) -> ReviewsViewController {
        let vc = ReviewsViewController.instantiate()
        let vm: ReviewsViewModel = resolve(navigationController: navigationController,
                                           movie: movie)
        vc.bindViewModel(to: vm)
        return vc
    }

    func resolve(navigationController: UINavigationController,
                 movie: Movie) -> ReviewsViewModel {
        return ReviewsViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve(),
            movie: movie)
    }
}

extension ReviewsAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> ReviewsNavigatorType {
        return ReviewsNavigator(assembler: self, navigationController: navigationController)
    }

    func resolve() -> ReviewsUseCaseType {
        return ReviewsUseCase(reviewRepository: resolve())
    }
}
