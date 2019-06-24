@testable import MovieDB
import XCTest
import RxSwift
//import RxBlocking

final class MovieViewModelTests: XCTestCase {
    private var viewModel: MoviesViewModel!
    private var navigator: MoviesNavigatorMock!
    private var useCase: MovieUseCaseMock!
    
    private var input: MoviesViewModel.Input!
    private var output: MoviesViewModel.Output!

    private var disposeBag: DisposeBag!
    
    private let loadTrigger = PublishSubject<Void>()
    private let selectedCategoryTrigger = PublishSubject<IndexPath>()
    private let searchMovieTrigger = PublishSubject<Void>()
    
    override func setUp() {
        super.setUp()
        navigator = MoviesNavigatorMock()
        useCase = MovieUseCaseMock()
        viewModel = MoviesViewModel(navigator: navigator, useCase: useCase)

        input = MoviesViewModel.Input(loadTrigger: loadTrigger.asDriverOnErrorJustComplete(),
                                      selectedCategoryTrigger: selectedCategoryTrigger.asDriverOnErrorJustComplete(),
                                      searchMovieTrigger: searchMovieTrigger.asDriverOnErrorJustComplete())
        output = viewModel.transform(input)

        disposeBag = DisposeBag()
    }
}
