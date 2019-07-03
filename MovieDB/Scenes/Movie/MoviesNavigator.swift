protocol MoviesNavigatorType {
    func toMoviesCategory(category: CategoryType)
    func toSearchMovies()
    func toMovieDetail(movie: Movie)
}

struct MoviesNavigator: MoviesNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController

    func toMoviesCategory(category: CategoryType) {
        let vc: CategoriesViewController = assembler.resolve(
            navigationController: navigationController,
            category: category
        )
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toSearchMovies() {
        let vc: SearchViewController = assembler.resolve(navigationController: navigationController)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toMovieDetail(movie: Movie) {
        let vc: MovieDetailViewController = assembler.resolve(navigationController: navigationController,
                                                              movie: movie)
        navigationController.pushViewController(vc, animated: true)
    }
}
