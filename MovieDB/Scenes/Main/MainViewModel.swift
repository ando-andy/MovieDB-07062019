
import Foundation

struct MainViewModel {
    let navigator: MainNavigatorType
    let useCase: MainUseCaseType
}

// MARK: - ViewModelType
extension MainViewModel: ViewModelType {
    struct Input {

    }

    struct Output {

    }

    func transform(_ input: Input) -> Output {
        return Output()
    }
}
