//
//  Created by kazutaka.ando on 6/11/19.
//  Copyright © 2019 kazando All rights reserved.
//

struct MoviesViewModel {
    let navigator: MoviesNavigatorType
    let useCase: MoviesUseCaseType
}

// MARK: - ViewModelType
extension MoviesViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let selectedCategoryTrigger: Driver<IndexPath>
        let searchMovieTrigger: Driver<Void>
        let selectedBannerTrigger: Driver<IndexPath>
        let selectedMovieTrigger: Driver<Movie>
    }
    
    struct Output {
        let movieCategoryList: Driver<[CategoryType]>
        let movieBannerList: Driver<[Movie]>
        let selectedCategory: Driver<Void>
        let searchMovie: Driver<Void>
        let selectedBanner: Driver<Void>
        let selectedMovie: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let popularMovieList = input.loadTrigger
            .flatMapLatest { _ -> Driver<PagingInfo<Movie>> in
                self.useCase.getMoviesList(.popular([]))
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            }
            .map { $0.items }
            .startWith([])
        
        let nowPlayingMovieList = input.loadTrigger
            .flatMapLatest { _ -> Driver<PagingInfo<Movie>> in
                self.useCase.getMoviesList(.nowPlaying([]))
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            }
            .map { $0.items }
            .startWith([])
        
        let upcomingMovieList = input.loadTrigger
            .flatMapLatest { _ -> Driver<PagingInfo<Movie>> in
                self.useCase.getMoviesList(.upcoming([]))
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            }
            .map { $0.items }
            .startWith([])
        
        let topRatedMovieList = input.loadTrigger
            .flatMapLatest { _ -> Driver<PagingInfo<Movie>> in
                self.useCase.getMoviesList(.topRated([]))
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            }
            .map { $0.items }
            .startWith([])
        
        let movieBannerList = popularMovieList.asObservable()
            .flatMap({ (movies) -> Observable<[Movie]> in
                return Observable.just(Array(movies.prefix(4)))
            })
            .asDriverOnErrorJustComplete()
        
        let movieCategoryList = Driver
            .combineLatest(popularMovieList, nowPlayingMovieList, upcomingMovieList, topRatedMovieList)
            .map { params -> [CategoryType] in
                let categoryList: [CategoryType] = [.popular(params.0),
                                                    .nowPlaying(params.1),
                                                    .upcoming(params.2),
                                                    .topRated(params.3)]
                return categoryList
            }
        
        let selectedCategory = input.selectedCategoryTrigger
            .withLatestFrom(movieCategoryList) {
                return ($0, $1)
            }
            .map { (indexPath, movieCategories) in
                return movieCategories[indexPath.row]
            }
            .do(onNext: { (category) in
                self.navigator.toMoviesCategory(category: category)
            })
            .mapToVoid()
        
        let selectedBanner = input.selectedBannerTrigger
            .withLatestFrom(movieBannerList) {
                return $1[$0.row]
            }
            .do(onNext: { (movie) in
                self.navigator.toMovieDetail(movie: movie)
                })
            .mapToVoid()
        
        let selectedMovie = input.selectedMovieTrigger
            .do(onNext: { (movie) in
                self.navigator.toMovieDetail(movie: movie)
            })
            .mapToVoid()
        
        let searchMovie = input.searchMovieTrigger
            .do(onNext: { (category) in
                self.navigator.toSearchMovies()
            })
            .mapToVoid()
        
        return Output(
            movieCategoryList: movieCategoryList,
            movieBannerList: movieBannerList,
            selectedCategory: selectedCategory,
            searchMovie: searchMovie,
            selectedBanner: selectedBanner,
            selectedMovie: selectedMovie
        )
    }
}
