//
//  SearchViewModel.swift
//
//  Created by kazutaka.ando on 6/26/19.
//

struct SearchViewModel {
    let navigator: SearchNavigatorType
    let useCase: SearchUseCaseType
}

// MARK: - ViewModelType
extension SearchViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let reloadTrigger: Driver<Void>
        let loadMoreTrigger: Driver<Void>
        let selectMovieTrigger: Driver<IndexPath>
        let textTrigger: Driver<String>
    }

    struct Output {
        let error: Driver<Error>
        let loading: Driver<Bool>
        let refreshing: Driver<Bool>
        let loadingMore: Driver<Bool>
        let fetchItems: Driver<Void>
        let movieList: Driver<[Movie]>
        let selectedMovie: Driver<Void>
        let isEmptyData: Driver<Bool>
    }

    func transform(_ input: Input) -> Output {
        
        let textSearch = input.textTrigger
            .filter { !$0.isEmpty }
        
        let loadMoreOutput = configPagination(
            loadTrigger: Driver.combineLatest(input.loadTrigger, textSearch) { $1 },
            getItems: self.useCase.searchMovie,
            reloadTrigger: input.reloadTrigger.withLatestFrom(textSearch),
            reloadItems: self.useCase.searchMovie,
            loadMoreTrigger: input.loadMoreTrigger.withLatestFrom(textSearch),
            loadMoreItems: self.useCase.loadMoreSearchMovie,
            mapper: { $0 }
        )
        
        let (page, fetchItems, loadError, loading, refreshing, loadingMore) = loadMoreOutput
        
        let movieList = page
            .map { $0.items.map { $0 } }
            .asDriverOnErrorJustComplete()
        
        let selectedMovie = input.selectMovieTrigger
            .withLatestFrom(movieList) {
                return $1[$0.row]
            }
            .do(onNext: { (movie) in
                self.navigator.toMovieDetail(movie: movie)
            })
            .mapToVoid()
        
        let isEmptyData = checkIfDataIsEmpty(fetchItemsTrigger: fetchItems,
                                             loadTrigger: Driver.merge(loading, refreshing),
                                             items: movieList)
        
        return Output(error: loadError,
                      loading: loading,
                      refreshing: refreshing,
                      loadingMore: loadingMore,
                      fetchItems: fetchItems,
                      movieList: movieList,
                      selectedMovie: selectedMovie,
                      isEmptyData: isEmptyData)
    }
}
