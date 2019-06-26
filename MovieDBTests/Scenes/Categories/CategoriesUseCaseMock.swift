//
//  CategoriesUseCaseMock.swift
//
//  Created by kazutaka.ando on 6/11/19.
//  Copyright © 2019 kazando All rights reserved.
//

@testable import MovieDB
import RxSwift

final class CategoriesUseCaseMock: CategoriesUseCaseType {

    var getMoviesListCalled = false
    var loadMoreMoveListCalled = false
    
    var getMovieListReturnValue: Observable<PagingInfo<Movie>> = {
        let items = [
            Movie().with { $0.id = 1 }
        ]
        let page = PagingInfo<Movie>(page: 1, items: items)
        return Observable.just(page)
    }()
    
    func getMoviesList(_ category: CategoryType) -> Observable<PagingInfo<Movie>> {
        getMoviesListCalled = true
        return getMovieListReturnValue
    }
    
    var loadMoreMovieListReturnValue: Observable<PagingInfo<Movie>> = {
        let movies = [
            Movie().with { $0.id = 2 }
        ]
        let page = PagingInfo<Movie>(page: 2, items: movies)
        return Observable.just(page)
    }()
    
    func loadMoreMoviesList(category: CategoryType, page: Int) -> Observable<PagingInfo<Movie>> {
        loadMoreMoveListCalled = true
        return loadMoreMovieListReturnValue
    }
    
}
