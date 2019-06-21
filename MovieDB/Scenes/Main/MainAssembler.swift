import UIKit

protocol MainAssembler {
    func resolve() -> MainViewController
}

extension MainAssembler {
}

extension AppAssembler where Self: DefaultAssembler {
    func resolve() -> MainViewController {
        let moviesNavigationController = UINavigationController()
        let movieVC: MoviesViewController = resolve(navigationController: moviesNavigationController)
        moviesNavigationController.viewControllers.append(movieVC)
    
        let favoriteNavigationController = UINavigationController()
        let favoriteVC: FavoriteViewController = resolve(navigationController: favoriteNavigationController)
        favoriteNavigationController.viewControllers.append(favoriteVC)
        
        let mainVC = MainViewController()
        mainVC.viewControllers = [moviesNavigationController, favoriteNavigationController]
        return mainVC
    }
}
