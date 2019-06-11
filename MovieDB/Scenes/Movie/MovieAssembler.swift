
import UIKit

protocol MovieAssembler {
    func resolve(navigationController: UINavigationController) -> MovieViewController
    func resolve(navigationController: UINavigationController) -> MovieViewModel
    func resolve(navigationController: UINavigationController) -> MovieNavigatorType
    func resolve() -> MovieUseCaseType
}

extension MovieAssembler {
    func resolve(navigationController: UINavigationController) -> MovieViewController {
        let vc = MovieViewController.instantiate()
        let vm: MovieViewModel = resolve(navigationController: navigationController)
        vc.bindViewModel(to: vm)
        return vc
    }

    func resolve(navigationController: UINavigationController) -> MovieViewModel {
        return MovieViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve()
        )
    }
}

extension MovieAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> MovieNavigatorType {
        return MovieNavigator(assembler: self, navigationController: navigationController)
    }

    func resolve() -> MovieUseCaseType {
        return MovieUseCase()
    }
}
