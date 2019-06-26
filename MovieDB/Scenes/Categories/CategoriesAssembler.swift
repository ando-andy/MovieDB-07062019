//
//  CategoriesAssembler.swift
//
//  Created by kazutaka.ando on 6/11/19.
//  Copyright © 2019 kazando All rights reserved.
//

import UIKit

protocol CategoriesAssembler {
    func resolve(navigationController: UINavigationController,
                 category: CategoryType) -> CategoriesViewController
    func resolve(navigationController: UINavigationController,
                 category: CategoryType) -> CategoriesViewModel
    func resolve(navigationController: UINavigationController) -> CategoriesNavigatorType
    func resolve() -> CategoriesUseCaseType
}

extension CategoriesAssembler {
    func resolve(navigationController: UINavigationController,
                 category: CategoryType) -> CategoriesViewController {
        let vc = CategoriesViewController.instantiate()
        let vm: CategoriesViewModel = resolve(navigationController: navigationController,
                                              category: category)
        vc.bindViewModel(to: vm)
        return vc
    }

    func resolve(navigationController: UINavigationController,
                 category: CategoryType) -> CategoriesViewModel {
        return CategoriesViewModel(
            useCase: resolve(),
            navigator: resolve(navigationController: navigationController),
            category: category
        )
    }
}

extension CategoriesAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> CategoriesNavigatorType {
        return CategoriesNavigator(assembler: self,
                                   navigationController: navigationController)
    }

    func resolve() -> CategoriesUseCaseType {
        return CategoriesUseCase(movieRepository: resolve())
    }
}
