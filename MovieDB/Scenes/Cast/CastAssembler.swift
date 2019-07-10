//
//  CastAssembler.swift
//
//  Created by kazutaka.ando on 7/9/19.
//

import UIKit

protocol CastAssembler {
    func resolve(navigationController: UINavigationController,
                 cast: Cast) -> CastViewController
    func resolve(navigationController: UINavigationController,
                 cast: Cast) -> CastViewModel
    func resolve(navigationController: UINavigationController) -> CastNavigatorType
    func resolve() -> CastUseCaseType
}

extension CastAssembler {
    func resolve(navigationController: UINavigationController,
                 cast: Cast) -> CastViewController {
        let vc = CastViewController.instantiate()
        let vm: CastViewModel = resolve(navigationController: navigationController,
                                        cast: cast)
        vc.bindViewModel(to: vm)
        return vc
    }

    func resolve(navigationController: UINavigationController, cast: Cast) -> CastViewModel {
        return CastViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve(),
            cast: cast
        )
    }
}

extension CastAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> CastNavigatorType {
        return CastNavigator(assembler: self,
                             navigationController: navigationController)
    }

    func resolve() -> CastUseCaseType {
        return CastUseCase(castRepository: resolve())
    }
}
