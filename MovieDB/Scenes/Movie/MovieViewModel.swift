
struct MovieViewModel {
    let navigator: MovieNavigatorType
    let useCase: MovieUseCaseType
}

// MARK: - ViewModelType
extension MovieViewModel: ViewModelType {
    struct Input {

    }

    struct Output {

    }

    func transform(_ input: Input) -> Output {
        return Output()
    }
}
