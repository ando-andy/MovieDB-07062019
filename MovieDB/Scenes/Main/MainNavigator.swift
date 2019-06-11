
protocol MainNavigatorType {
    func toMain()
    
}

struct MainNavigator: MainNavigatorType {
    unowned let assembler: Assembler
    unowned let window: UIWindow
    
    func toMain() {
        let movieNavigationController = UINavigationController()
        movieNavigationController.tabBarItem = UITabBarItem(
            title: "Movie", //localize later
            image: UIImage(named: "tabbar_movie"),
            selectedImage: UIImage(named: "tabbar_movie")
        )
        
        let categoriesNavigationController = UINavigationController()
        categoriesNavigationController.tabBarItem = UITabBarItem(
            title: "Categories", //localize later
            image: UIImage(named: "tabbar_categories"),
            selectedImage: UIImage(named: "tabbar_categories")
        )

        let favoriteNavigationController = UINavigationController()
        favoriteNavigationController.tabBarItem = UITabBarItem(
            title: "Favorite", //localize later
            image: UIImage(named: "tabbar_favorite"),
            selectedImage: UIImage(named: "tabbar_favorite")
        )
        
        let mainViewController: MainViewController = assembler.resolve(window: window)
        mainViewController.viewControllers = [
            movieNavigationController,
            categoriesNavigationController,
            favoriteNavigationController
        ]
        window.rootViewController = mainViewController
        
        let movieViewController: MovieViewController = assembler.resolve(navigationController: movieNavigationController)
        movieNavigationController.pushViewController(movieViewController, animated: true)
    }
}
