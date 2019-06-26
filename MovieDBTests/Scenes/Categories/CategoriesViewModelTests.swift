//
//  CategoriesViewModelTests.swift
//
//  Created by kazutaka.ando on 6/11/19.
//  Copyright © 2019 kazando All rights reserved.
//

@testable import MovieDB
import XCTest
import RxSwift
import RxBlocking

final class CategoriesViewModelTests: XCTestCase {
    private var viewModel: CategoriesViewModel!
    private var navigator: CategoriesNavigatorMock!
    private var useCase: CategoriesUseCaseMock!
    
    private var input: CategoriesViewModel.Input!
    private var output: CategoriesViewModel.Output!
    
    private var disposeBag: DisposeBag!
    
    private var loadTrigger = PublishSubject<Void>()
    private var reloadTrigger = PublishSubject<Void>()
    private var loadMoreTrigger = PublishSubject<Void>()
    private var selectMovieTrigger = PublishSubject<IndexPath>()
    
    override func setUp() {
        super.setUp()
        useCase = CategoriesUseCaseMock()
        navigator = CategoriesNavigatorMock()
        viewModel = CategoriesViewModel(useCase: useCase,
                                        navigator: navigator,
                                        category: CategoryType.popular([Movie()]))
        
        input = CategoriesViewModel.Input(
            loadTrigger: loadTrigger.asDriverOnErrorJustComplete(),
            reloadTrigger: reloadTrigger.asDriverOnErrorJustComplete(),
            loadMoreTrigger: loadMoreTrigger.asDriverOnErrorJustComplete(),
            selectMovieTrigger: selectMovieTrigger.asDriverOnErrorJustComplete()
        )
        
        output = viewModel.transform(input)
        
        disposeBag = DisposeBag()
        
        output.error.drive().disposed(by: disposeBag)
        output.loading.drive().disposed(by: disposeBag)
        output.refreshing.drive().disposed(by: disposeBag)
        output.loadingMore.drive().disposed(by: disposeBag)
        output.fetchItems.drive().disposed(by: disposeBag)
        output.movieList.drive().disposed(by: disposeBag)
        output.selectedMovie.drive().disposed(by: disposeBag)
        output.isEmptyData.drive().disposed(by: disposeBag)
    }
    
    func test_loadTriggerInvoked_getMovieList() {
        loadTrigger.onNext(())
        let movieList = try? output.movieList.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.getMoviesListCalled)
        XCTAssertEqual(movieList?.count, 1)
    }
    
    func test_loadTriggerInvoked_getMovieList_failedShowError() {
        let getMovieListReturnValue = PublishSubject<PagingInfo<Movie>>()
        useCase.getMovieListReturnValue = getMovieListReturnValue
        
        loadTrigger.onNext(())
        getMovieListReturnValue.onError(TestError())
        let error = try? output.error.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.getMoviesListCalled)
        XCTAssert(error is TestError)
    }
    
    func test_reloadTriggerInvoked_getMovieList() {
        loadTrigger.onNext(())
        reloadTrigger.onNext(())
        let movieList = try? output.movieList.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.getMoviesListCalled)
        XCTAssertEqual(movieList?.count, 1)
    }
    
    func test_reloadTriggerInvoked_getMovieList_failedShowError() {
        let getMovieListReturnValue = PublishSubject<PagingInfo<Movie>>()
        useCase.getMovieListReturnValue = getMovieListReturnValue
        
        loadTrigger.onNext(())
        reloadTrigger.onNext(())
        getMovieListReturnValue.onError(TestError())
        let error = try? output.error.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.getMoviesListCalled)
        XCTAssert(error is TestError)
    }
    
    func test_reloadTriggerInvoked_notGetMovieListIfStillLoading() {
        // arrange
        let getMovieListReturnValue = PublishSubject<PagingInfo<Movie>>()
        useCase.getMovieListReturnValue = getMovieListReturnValue
        
        // act
        loadTrigger.onNext(())
        useCase.getMoviesListCalled = false
        reloadTrigger.onNext(())
        
        // assert
        XCTAssertFalse(useCase.getMoviesListCalled)
    }
    
    func test_reloadTriggerInvoked_notGetMovieListIfStillReloading() {
        // arrange
        let getMovieListReturnValue = PublishSubject<PagingInfo<Movie>>()
        useCase.getMovieListReturnValue = getMovieListReturnValue
        
        // act
        reloadTrigger.onNext(())
        useCase.getMoviesListCalled = false
        reloadTrigger.onNext(())
        
        // assert
        XCTAssertFalse(useCase.getMoviesListCalled)
    }
    
    func test_loadMoreTriggerInvoked_loadMoreMovieList() {
        loadTrigger.onNext(())
        loadMoreTrigger.onNext(())
        let movieList = try? output.movieList.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.loadMoreMoveListCalled)
        XCTAssertEqual(movieList?.count, 2)
    }
    
    func test_loadMoreTriggerInvoked_loadMoreMovieList_failedShowError() {
        let loadMoreMovieListReturnValue = PublishSubject<PagingInfo<Movie>>()
        useCase.loadMoreMovieListReturnValue = loadMoreMovieListReturnValue
        
        loadTrigger.onNext(())
        loadMoreTrigger.onNext(())
        loadMoreMovieListReturnValue.onError(TestError())
        let error = try? output.error.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.loadMoreMoveListCalled)
        XCTAssert(error is TestError)
    }
    
    func test_loadMoreTriggerInvoked_notLoadMoreMovieListIfStillLoading() {
        let getMovieListReturnValue = PublishSubject<PagingInfo<Movie>>()
        useCase.getMovieListReturnValue = getMovieListReturnValue
        
        loadTrigger.onNext(())
        useCase.getMoviesListCalled = false
        loadMoreTrigger.onNext(())
        
        XCTAssertFalse(useCase.loadMoreMoveListCalled)
    }
    
    func test_loadMoreTriggerInvoked_notLoadMoreMovieListIfStillReloading() {
        let getMovieListReturnValue = PublishSubject<PagingInfo<Movie>>()
        useCase.getMovieListReturnValue = getMovieListReturnValue
        
        reloadTrigger.onNext(())
        useCase.getMoviesListCalled = false
        loadMoreTrigger.onNext(())
        
        XCTAssertFalse(useCase.loadMoreMoveListCalled)
    }
    
    func test_loadMoreTriggerInvoked_notLoadMoreDocumentTypesStillLoadingMore() {
        let loadMoreMovieListReturnValue = PublishSubject<PagingInfo<Movie>>()
        useCase.loadMoreMovieListReturnValue = loadMoreMovieListReturnValue
        
        loadMoreTrigger.onNext(())
        useCase.loadMoreMoveListCalled = false
        loadMoreTrigger.onNext(())
        
        XCTAssertFalse(useCase.loadMoreMoveListCalled)
    }
    
    func test_selectMovieTriggerInvoked_toMovieDetail() {
        loadTrigger.onNext(())
        selectMovieTrigger.onNext(IndexPath(row: 0, section: 0))
        //XCTAssert(navigator.toMovieDetailCalled)
    }
}
