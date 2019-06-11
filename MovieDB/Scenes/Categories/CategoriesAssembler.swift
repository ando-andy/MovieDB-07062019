//
//  CategoriesAssembler.swift
//
//  Created by kazutaka.ando on 6/11/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import UIKit

protocol CategoriesAssembler {
    func resolve(navigationController: UINavigationController) -> CategoriesViewController
    func resolve(navigationController: UINavigationController) -> CategoriesViewModel
    func resolve(navigationController: UINavigationController) -> CategoriesNavigatorType
    func resolve() -> CategoriesUseCaseType
}

extension CategoriesAssembler {
    func resolve(navigationController: UINavigationController) -> CategoriesViewController {
        let vc = CategoriesViewController.instantiate()
        let vm: CategoriesViewModel = resolve(navigationController: navigationController)
        vc.bindViewModel(to: vm)
        return vc
    }

    func resolve(navigationController: UINavigationController) -> CategoriesViewModel {
        return CategoriesViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve()
        )
    }
}

extension CategoriesAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> CategoriesNavigatorType {
        return CategoriesNavigator(assembler: self, navigationController: navigationController)
    }

    func resolve() -> CategoriesUseCaseType {
        return CategoriesUseCase()
    }
}
