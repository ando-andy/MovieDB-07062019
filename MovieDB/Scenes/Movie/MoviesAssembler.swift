import UIKit

protocol MoviesAssembler {
    func resolve(navigationController: UINavigationController) -> MoviesViewController
    func resolve(navigationController: UINavigationController) -> MoviesViewModel
    func resolve(navigationController: UINavigationController) -> MoviesNavigatorType
    func resolve() -> MoviesUseCaseType
}

extension MoviesAssembler {
    func resolve(navigationController: UINavigationController) -> MoviesViewController {
        let vc = MoviesViewController.instantiate()
        let movieTabBarItem = UITabBarItem(title: "Movie",
                                           image: UIImage(named: "tabbar_movie"),
                                           tag: 0)
        vc.tabBarItem = movieTabBarItem
        let vm: MoviesViewModel = resolve(navigationController: navigationController)
        vc.bindViewModel(to: vm)
        return vc
    }

    func resolve(navigationController: UINavigationController) -> MoviesViewModel {
        return MoviesViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve()
        )
    }
}

extension MoviesAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> MoviesNavigatorType {
        return MoviesNavigator(assembler: self, navigationController: navigationController)
    }

    func resolve() -> MoviesUseCaseType {
        return MoviesUseCase(moviesRepository: resolve())
    }
}
