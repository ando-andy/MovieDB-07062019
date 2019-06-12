
@testable import MovieDB
import XCTest
import RxSwift
//import RxBlocking

final class AppViewModelTests: XCTestCase {
    private var viewModel: AppViewModel!
    private var navigator: AppNavigatorMock!
    private var useCase: AppUseCaseMock!
    
    private var input: AppViewModel.Input!
    private var output: AppViewModel.Output!

    private var disposeBag: DisposeBag!
    
    private let loadTrigger = PublishSubject<Void>()

    override func setUp() {
        super.setUp()
        navigator = AppNavigatorMock()
        useCase = AppUseCaseMock()
        viewModel = AppViewModel(navigator: navigator, useCase: useCase)

        input = AppViewModel.Input(
            loadTrigger: loadTrigger.asDriverOnErrorJustComplete()
        )

        output = viewModel.transform(input)

        disposeBag = DisposeBag()
        
        output.toMain.drive().disposed(by: disposeBag)

    }
    
    func test_loadTrigger_() {
        // act
        loadTrigger.onNext(())
        
        // assert
        XCTAssert(navigator.toMainCalled)
    }

}
