//
//  CategoriesViewModel.swift
//
//  Created by kazutaka.ando on 6/11/19.
//  Copyright © 2019 kazando All rights reserved.
//

struct CategoriesViewModel {
    let navigator: CategoriesNavigatorType
    let useCase: CategoriesUseCaseType
    let category: CategoryType
}

// MARK: - ViewModelType
extension CategoriesViewModel: ViewModelType {
    struct Input {

    }

    struct Output {

    }

    func transform(_ input: Input) -> Output {
        return Output()
    }
}
