
@testable import MovieDB
import XCTest
import RxSwift
//import RxBlocking

final class MovieViewModelTests: XCTestCase {
    private var viewModel: MovieViewModel!
    private var navigator: MovieNavigatorMock!
    private var useCase: MovieUseCaseMock!
    
    private var input: MovieViewModel.Input!
    private var output: MovieViewModel.Output!

    private var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        navigator = MovieNavigatorMock()
        useCase = MovieUseCaseMock()
        viewModel = MovieViewModel(navigator: navigator, useCase: useCase)

        input = MovieViewModel.Input()
        output = viewModel.transform(input)

        disposeBag = DisposeBag()
    }
}
