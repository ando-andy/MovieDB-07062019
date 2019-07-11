//
//  CastViewModel.swift
//
//  Created by kazutaka.ando on 7/9/19.
//

struct CastViewModel {
    let navigator: CastNavigatorType
    let useCase: CastUseCaseType
    let cast: Cast
}

// MARK: - ViewModelType
extension CastViewModel: ViewModelType {
    
    struct Input {
        let loadTrigger: Driver<Void>
        let backwardTrigger: Driver<Void>
        let selectMovieTrigger: Driver<IndexPath>
    }

    struct Output {
        let castList: Driver<Cast>
        let movieList: Driver<[Movie]>
        let backward: Driver<Void>
        let selectedMovie: Driver<Void>
    }

    func transform(_ input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let castList = input.loadTrigger
            .flatMapLatest { _ -> Driver<Cast> in
                self.useCase.getCastList(id: self.cast.id)
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            }
        
        let movieList = input.loadTrigger
            .flatMapLatest { _ -> Driver<PagingInfo<Movie>> in
                self.useCase.getMovieListByCast(id: self.cast.id)
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            }
            .map { $0.items }
            .startWith([])
        
        let backward = input.backwardTrigger
            .do(onNext: {
                self.navigator.backward()
            })
        
        let selectedMovie = input.selectMovieTrigger
            .withLatestFrom(movieList) {
                return $1[$0.row]
            }
            .do(onNext: { (movie) in
                self.navigator.toMovieDetail(movie: movie)
            })
            .mapToVoid()
        
        return Output(castList: castList,
                      movieList: movieList,
                      backward: backward,
                      selectedMovie: selectedMovie)
    }
}
