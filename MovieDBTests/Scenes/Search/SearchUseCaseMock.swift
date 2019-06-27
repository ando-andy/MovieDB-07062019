//
//  SearchUseCaseMock.swift
//
//  Created by kazutaka.ando on 6/26/19.
//

@testable import MovieDB
import RxSwift

final class SearchUseCaseMock: SearchUseCaseType {

    var searchMoiveCalled = false
    var loadMoreSearchMoviewCalled = false

    // MARK: - searchMovie
    
    var searchMovieReturnValue: Observable<PagingInfo<Movie>> = {
        let items = [
            Movie().with { $0.id = 1 }
        ]
        let page = PagingInfo<Movie>(page: 1, items: items)
        return Observable.just(page)
    }()
    
    func searchMovie(_ key: String) -> Observable<PagingInfo<Movie>> {
        searchMoiveCalled = true
        return searchMovieReturnValue
    }
    
    // MARK: - loadMoreSearchMovie
    
    var loadMoreSearchMovieReturnValue: Observable<PagingInfo<Movie>> = {
        let items = [
            Movie().with { $0.id = 2 }
        ]
        let page = PagingInfo<Movie>(page: 2, items: items)
        return Observable.just(page)
    }()
    
    func loadMoreSearchMovie(key: String, page: Int) -> Observable<PagingInfo<Movie>> {
        loadMoreSearchMoviewCalled = true
        return loadMoreSearchMovieReturnValue
    }
}

