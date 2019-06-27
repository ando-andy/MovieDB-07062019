//
//  SearchViewModelTests.swift
//
//  Created by kazutaka.ando on 6/26/19.
//

@testable import MovieDB
import XCTest
import RxSwift
import RxBlocking

final class SearchViewModelTests: XCTestCase {
    private var viewModel: SearchViewModel!
    private var navigator: SearchNavigatorMock!
    private var useCase: SearchUseCaseMock!
    
    private var input: SearchViewModel.Input!
    private var output: SearchViewModel.Output!

    private var disposeBag: DisposeBag!

    private var loadTrigger = PublishSubject<Void>()
    private var reloadTrigger = PublishSubject<Void>()
    private var loadMoreTrigger = PublishSubject<Void>()
    private var selectMovieTrigger = PublishSubject<IndexPath>()
    private var textTrigger = PublishSubject<String>()
    
    override func setUp() {
        super.setUp()
        navigator = SearchNavigatorMock()
        useCase = SearchUseCaseMock()
        viewModel = SearchViewModel(navigator: navigator, useCase: useCase)

        input = SearchViewModel.Input(loadTrigger: loadTrigger.asDriverOnErrorJustComplete(),
                                      reloadTrigger: reloadTrigger.asDriverOnErrorJustComplete(),
                                      loadMoreTrigger: loadMoreTrigger.asDriverOnErrorJustComplete(),
                                      selectMovieTrigger: selectMovieTrigger.asDriverOnErrorJustComplete(),
                                      textTrigger: textTrigger.asDriverOnErrorJustComplete())
        
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
    
    func test_loadTriggerInvoked_searchMovie() {
        loadTrigger.onNext(())
        textTrigger.onNext(" ")
        let movieList = try? output.movieList.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.searchMoiveCalled)
        XCTAssertEqual(movieList?.count, 1)
    }
    
    func test_loadTriggerInvoked_failedShowError() {
        let searchMovieReturnValue = PublishSubject<PagingInfo<Movie>>()
        useCase.searchMovieReturnValue = searchMovieReturnValue
        
        loadTrigger.onNext(())
        textTrigger.onNext(" ")

        searchMovieReturnValue.onError(TestError())
        let error = try? output.error.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.searchMoiveCalled)
        XCTAssert(error is TestError)
    }
    
    func test_reloadTriggerInvoked_searchMovie() {
        loadTrigger.onNext(())
        textTrigger.onNext(" ")
        reloadTrigger.onNext(())
        let movieList = try? output.movieList.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.searchMoiveCalled)
        XCTAssertEqual(movieList?.count, 1)
    }
    
    func test_reloadTriggerInvoked_searchMovie_failedShowError() {
        let searchMovieReturnValue = PublishSubject<PagingInfo<Movie>>()
        useCase.searchMovieReturnValue = searchMovieReturnValue
        
        loadTrigger.onNext(())
        reloadTrigger.onNext(())
        textTrigger.onNext(" ")
        searchMovieReturnValue.onError(TestError())
        let error = try? output.error.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.searchMoiveCalled)
        XCTAssert(error is TestError)
    }
    
    func test_reloadTriggerInvoked_notSearchMovieIfStillLoading() {
        let loadMoreSearchMovieReturnValue = PublishSubject<PagingInfo<Movie>>()
        useCase.loadMoreSearchMovieReturnValue = loadMoreSearchMovieReturnValue
        
        loadTrigger.onNext(())
        textTrigger.onNext(" ")

        useCase.searchMoiveCalled = false
        reloadTrigger.onNext(())
                
        XCTAssert(useCase.searchMoiveCalled)
    }
    
    func test_reloadMovieTriggerInvoked_notSearchMovieStillReloading() {
        let searchMovieReturnValue = PublishSubject<PagingInfo<Movie>>()
        useCase.searchMovieReturnValue = searchMovieReturnValue
        
        loadTrigger.onNext(())
        reloadTrigger.onNext(())
        useCase.searchMoiveCalled = false
        reloadTrigger.onNext(())
        
        XCTAssertFalse(useCase.searchMoiveCalled)
    }
    
    func test_loadMoreTriggerInvoked_loadMoreSearchMovie() {
        loadTrigger.onNext(())
        textTrigger.onNext(" ")
        loadMoreTrigger.onNext(())

        let movieList = try? output.movieList.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.loadMoreSearchMoviewCalled)
        XCTAssertEqual(movieList?.count, 2)
    }
    
    func test_loadMoreTriggerInvoked_loadMoreSearchMovie_failedShowError() {
        let loadMoreSearchMovieReturnValue = PublishSubject<PagingInfo<Movie>>()
        useCase.loadMoreSearchMovieReturnValue = loadMoreSearchMovieReturnValue
        
        loadTrigger.onNext(())
        textTrigger.onNext(" ")
        loadMoreTrigger.onNext(())
        loadMoreSearchMovieReturnValue.onError(TestError())
        let error = try? output.error.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.loadMoreSearchMoviewCalled)
        XCTAssert(error is TestError)
    }
    
    func test_loadMoreTriggerInvoked_notLoadMoreSearchMovieIfStillLoading() {
        let searchMovieReturnValue = PublishSubject<PagingInfo<Movie>>()
        useCase.searchMovieReturnValue = searchMovieReturnValue
        
        loadTrigger.onNext(())
        useCase.searchMoiveCalled = false
        loadMoreTrigger.onNext(())
        
        XCTAssertFalse(useCase.searchMoiveCalled)
    }
    
    func test_loadMoreTriggerInvoked_notLoadMoreMovieListIfStillReloading() {
        let searchMovieReturnValue = PublishSubject<PagingInfo<Movie>>()
        useCase.searchMovieReturnValue = searchMovieReturnValue
        
        reloadTrigger.onNext(())
        useCase.searchMoiveCalled = false
        loadMoreTrigger.onNext(())
        
        XCTAssertFalse(useCase.loadMoreSearchMoviewCalled)
    }
    
    func test_loadMoreTriggerInvoked_notLoadMoreDocumentTypesStillLoadingMore() {
        let loadMoreSearchMovieReturnValue = PublishSubject<PagingInfo<Movie>>()
        useCase.loadMoreSearchMovieReturnValue = loadMoreSearchMovieReturnValue
        
        loadMoreTrigger.onNext(())
        useCase.loadMoreSearchMoviewCalled = false
        loadMoreTrigger.onNext(())
        
        XCTAssertFalse(useCase.loadMoreSearchMoviewCalled)
    }
    
//    func test_selectMovieTriggerInvoked_toMovieDetail() {
//        loadTrigger.onNext(())
//        selectMovieTrigger.onNext(IndexPath(row: 0, section: 0))
//        XCTAssert(navigator.toMovieDetailCalled)
//    }
}
