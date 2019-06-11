
@testable import MovieDB
import XCTest
import RxSwift
//import RxBlocking

final class MainViewModelTests: XCTestCase {
    private var viewModel: MainViewModel!
    private var navigator: MainNavigatorMock!
    private var useCase: MainUseCaseMock!
    
    private var input: MainViewModel.Input!
    private var output: MainViewModel.Output!

    private var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        navigator = MainNavigatorMock()
        useCase = MainUseCaseMock()
        viewModel = MainViewModel(navigator: navigator, useCase: useCase)

        input = MainViewModel.Input()
        output = viewModel.transform(input)

        disposeBag = DisposeBag()
    }
}
