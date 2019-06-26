//
//  CategoriesViewModel.swift
//
//  Created by kazutaka.ando on 6/11/19.
//  Copyright © 2019 kazando All rights reserved.
//

struct CategoriesViewModel {
    let useCase: CategoriesUseCaseType
    let navigator: CategoriesNavigatorType
    let category: CategoryType
}

extension CategoriesViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let reloadTrigger: Driver<Void>
        let loadMoreTrigger: Driver<Void>
        let selectMovieTrigger: Driver<IndexPath>
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
//        let loadTrigger = input.loadTrigger
//            .map { _ in self.category }
//        let reloadTrigger = input.reloadTrigger
//            .withLatestFrom(loadTrigger)
//        let loadMoreTrigger = input.loadMoreTrigger
//            .withLatestFrom(loadTrigger)
        
        let configOutput = configPagination(
            loadTrigger: input.loadTrigger,
            reloadTrigger: input.reloadTrigger,
            getItems: {
                self.useCase.getMoviesList(self.category)
            },
            loadMoreTrigger: input.loadMoreTrigger,
            loadMoreItems: { page in
                self.useCase.loadMoreMoviesList(category: self.category, page: page)
            })
        
        let (page, fetchItems, loadError, loading, refreshing, loadingMore) = configOutput
        
        let movieList = page
            .map { $0.items.map { $0 } }
            .asDriverOnErrorJustComplete()
        
        let selectedMovie = input.selectMovieTrigger
            .withLatestFrom(movieList) {
                return $1[$0.row]
            }
            .do(onNext: { (movie) in
                // ToDO
            })
            .mapToVoid()
        
        let isEmptyData = checkIfDataIsEmpty(fetchItemsTrigger: fetchItems,
                                             loadTrigger: Driver.merge(loading, refreshing),
                                             items: movieList)
        return Output(
            error: loadError,
            loading: loading,
            refreshing: refreshing,
            loadingMore: loadingMore,
            fetchItems: fetchItems,
            movieList: movieList,
            selectedMovie: selectedMovie,
            isEmptyData: isEmptyData)
    }
}
