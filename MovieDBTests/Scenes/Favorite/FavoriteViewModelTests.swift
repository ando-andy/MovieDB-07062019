//
//  FavoriteViewModelTests.swift
//
//  Created by kazutaka.ando on 6/11/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

@testable import MovieDB
import XCTest
import RxSwift
//import RxBlocking

final class FavoriteViewModelTests: XCTestCase {
    private var viewModel: FavoriteViewModel!
    private var navigator: FavoriteNavigatorMock!
    private var useCase: FavoriteUseCaseMock!
    
    private var input: FavoriteViewModel.Input!
    private var output: FavoriteViewModel.Output!

    private var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        navigator = FavoriteNavigatorMock()
        useCase = FavoriteUseCaseMock()
        viewModel = FavoriteViewModel(navigator: navigator, useCase: useCase)

        input = FavoriteViewModel.Input()
        output = viewModel.transform(input)

        disposeBag = DisposeBag()
    }
}
