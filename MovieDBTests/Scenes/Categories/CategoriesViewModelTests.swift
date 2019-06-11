//
//  CategoriesViewModelTests.swift
//
//  Created by kazutaka.ando on 6/11/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

@testable import MovieDB
import XCTest
import RxSwift
//import RxBlocking

final class CategoriesViewModelTests: XCTestCase {
    private var viewModel: CategoriesViewModel!
    private var navigator: CategoriesNavigatorMock!
    private var useCase: CategoriesUseCaseMock!
    
    private var input: CategoriesViewModel.Input!
    private var output: CategoriesViewModel.Output!

    private var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        navigator = CategoriesNavigatorMock()
        useCase = CategoriesUseCaseMock()
        viewModel = CategoriesViewModel(navigator: navigator, useCase: useCase)

        input = CategoriesViewModel.Input()
        output = viewModel.transform(input)

        disposeBag = DisposeBag()
    }
}
