protocol MoviesUseCaseType {
    func getMoviesList(_ category: CategoryType) -> Observable<PagingInfo<Movie>>
}

struct MoviesUseCase: MoviesUseCaseType {
    let moviesRepository: MoviesRepositoryType

    func getMoviesList(_ category: CategoryType) -> Observable<PagingInfo<Movie>> {
        return moviesRepository.getMoviesList(category: category, page: 1)
    }
}
