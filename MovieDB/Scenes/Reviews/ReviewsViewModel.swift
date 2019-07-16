//
//  ReviewsViewModel.swift
//
//  Created by kazutaka.ando on 7/11/19.
//

struct ReviewsViewModel {
    let navigator: ReviewsNavigatorType
    let useCase: ReviewsUseCaseType
    let movie: Movie
}

// MARK: - ViewModelType
extension ReviewsViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let reloadTrigger: Driver<Void>
        let loadMoreTrigger: Driver<Void>
    }
    
    struct Output {
        let error: Driver<Error>
        let loading: Driver<Bool>
        let refreshing: Driver<Bool>
        let loadingMore: Driver<Bool>
        let fetchItems: Driver<Void>
        let reviewList: Driver<[Review]>
        let isEmptyData: Driver<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        
        let loadMoreOutput = configPagination(
            loadTrigger: input.loadTrigger,
            getItems: {self.useCase.getReviewList(self.movie.id)
        },
            reloadTrigger: input.reloadTrigger,
            reloadItems: {
                self.useCase.getReviewList(self.movie.id)
        },
            loadMoreTrigger: input.loadMoreTrigger,
            loadMoreItems: { page in
                self.useCase.loadMoreReviewList(id: self.movie.id, page: page)
        }
        )
        
        let (page, fetchItems, loadError, loading, refreshing, loadingMore) = loadMoreOutput
        
        let reviewList = page
            .map { $0.items.map { $0 } }
            .asDriverOnErrorJustComplete()
        
        let isEmptyData = checkIfDataIsEmpty(fetchItemsTrigger: fetchItems,
                                             loadTrigger: Driver.merge(loading, refreshing),
                                             items: reviewList)
        return Output(
            error: loadError,
            loading: loading,
            refreshing: refreshing,
            loadingMore: loadingMore,
            fetchItems: fetchItems,
            reviewList: reviewList,
            isEmptyData: isEmptyData
        )
    }
}
