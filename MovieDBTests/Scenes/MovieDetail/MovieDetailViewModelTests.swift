//
//  MovieDetailViewModelTests.swift
//
//  Created by kazutaka.ando on 6/27/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

@testable import MovieDB
import XCTest
import RxSwift
import RxBlocking

final class MovieDetailViewModelTests: XCTestCase {
    private var viewModel: MovieDetailViewModel!
    private var navigator: MovieDetailNavigatorMock!
    private var useCase: MovieDetailUseCaseMock!
    
    private var input: MovieDetailViewModel.Input!
    private var output: MovieDetailViewModel.Output!
    
    private var disposeBag: DisposeBag!
    
    private let loadTrigger = PublishSubject<Void>()
    private let backwardTrigger = PublishSubject<Void>()
    
    override func setUp() {
        super.setUp()
        navigator = MovieDetailNavigatorMock()
        useCase = MovieDetailUseCaseMock()
        viewModel = MovieDetailViewModel(navigator: navigator,
                                         useCase: useCase,
                                         movie: Movie()
        )
        disposeBag = DisposeBag()
        input = MovieDetailViewModel.Input(
            loadTrigger: loadTrigger.asDriverOnErrorJustComplete(),
            backwardTrigger: backwardTrigger.asDriverOnErrorJustComplete()
        )
        
        output = viewModel.transform(input)
        output.movieDetail.drive().disposed(by: disposeBag)
        output.backward.drive().disposed(by: disposeBag)
    }
    
    func test_loadTriggerInvoked_getMovieDetail() {
        loadTrigger.onNext(())
        let movieDetail = try? output.movieDetail.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.getMovieDetailCalled)
        XCTAssertNotNil(movieDetail)
    }
    
    func test_backwardTrigger_backScreen() {
        loadTrigger.onNext(())
        backwardTrigger.onNext(())
        XCTAssert(navigator.backwardCalled)
    }
}
