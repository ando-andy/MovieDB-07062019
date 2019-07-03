//
//  MovieDetailViewModel.swift
//
//  Created by kazutaka.ando on 6/27/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
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
        let backwardTrigger: Driver<Void>
    }

    struct Output {
        let movieDetail: Driver<Movie>
        let backward: Driver<Void>
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
        
        let backward = input.backwardTrigger
            .do(onNext: {
                self.navigator.backward()
            })

        return Output(movieDetail: movieDetail,
                      backward: backward)
    }
}
