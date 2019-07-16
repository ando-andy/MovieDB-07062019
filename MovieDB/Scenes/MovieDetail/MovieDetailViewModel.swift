//
//  MovieDetailViewModel.swift
//
//  Created by kazutaka.ando on 6/27/19.
//

struct MovieDetailViewModel {
    let navigator: MovieDetailNavigatorType
    let useCase: MovieDetailUseCaseType
    let movie: Movie
}

// MARK: - ViewModelType
extension MovieDetailViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let showCastDetailTrigger: Driver<IndexPath>
        let backwardTrigger: Driver<Void>
        let showReviewTrigger: Driver<Void>
    }

    struct Output {
        let movieDetail: Driver<Movie>
        let castList: Driver<[Cast]>
        let backward: Driver<Void>
        let showCastDetail: Driver<Void>
        let showReviews: Driver<Void>
    }

    func transform(_ input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let movieDetail = input.loadTrigger
            .flatMapLatest { _ -> Driver<Movie> in
                self.useCase.getMovieDetail(movieId: self.movie.id)
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            }
        
        let castList = movieDetail
            .map { $0.castList }
        
        let showCastDetail = input.showCastDetailTrigger
            .withLatestFrom(castList) {
                return $1[$0.row]
            }
            .do(onNext: { (cast) in
                self.navigator.toCastDetail(cast: cast)
            })
            .mapToVoid()
        
        let showReviews = input.showReviewTrigger
            .do(onNext: {
                self.navigator.toReviews(movie: self.movie)
            })
        
        let backward = input.backwardTrigger
            .do(onNext: {
                self.navigator.backward()
            })

        return Output(movieDetail: movieDetail,
                      castList: castList,
                      backward: backward,
                      showCastDetail: showCastDetail,
                      showReviews: showReviews)
    }
}
