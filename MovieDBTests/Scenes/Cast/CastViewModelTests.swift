//
//  CastViewModelTests.swift
//
//  Created by kazutaka.ando on 7/9/19.

//

@testable import MovieDB
import XCTest
import RxSwift
import RxBlocking

final class CastViewModelTests: XCTestCase {
    private var viewModel: CastViewModel!
    private var navigator: CastNavigatorMock!
    private var useCase: CastUseCaseMock!
    
    private var input: CastViewModel.Input!
    private var output: CastViewModel.Output!

    private var disposeBag: DisposeBag!
    
    private let loadTrigger = PublishSubject<Void>()
    private let backScreenTrigger = PublishSubject<Void>()
    private let selectMovieTrigger = PublishSubject<IndexPath>()
    
    override func setUp() {
        super.setUp()
        navigator = CastNavigatorMock()
        useCase = CastUseCaseMock()
        viewModel = CastViewModel(navigator: navigator,
                                  useCase: useCase,
                                  cast: Cast())
        
        disposeBag = DisposeBag()
        input = CastViewModel.Input(
            loadTrigger: loadTrigger.asDriverOnErrorJustComplete(),
            backwardTrigger: backScreenTrigger.asDriverOnErrorJustComplete(),
            selectMovieTrigger: selectMovieTrigger.asDriverOnErrorJustComplete()
        )
        output = viewModel.transform(input)
        output.castList.drive().disposed(by: disposeBag)
        output.movieList.drive().disposed(by: disposeBag)
        output.backward.drive().disposed(by: disposeBag)
        output.selectedMovie.drive().disposed(by: disposeBag)
    }
    
    func test_loadTriggerInvoked_getCastDetail() {
        loadTrigger.onNext(())
        let castDetail = try? output.castList.toBlocking(timeout: 1).first()
        let movieList = try? output.movieList.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.getCastDetailCalled)
        XCTAssert(useCase.getMovieListByCastCalled)
        XCTAssertNotNil(castDetail)
        XCTAssertEqual(movieList?.count, 1)
    }
    
    func test_backScreenTriggerInvoked_backScreen() {
        loadTrigger.onNext(())
        backScreenTrigger.onNext(())
        XCTAssert(navigator.backwardCalled)
    }
    
    func test_selectMovieTriggerInvoked_toMovieDetail() {
        loadTrigger.onNext(())
        selectMovieTrigger.onNext(IndexPath(row: 0, section: 0))
        XCTAssert(navigator.toMovieDetailCalled)
    }
}
