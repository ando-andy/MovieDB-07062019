//
//  CastUseCaseMock.swift
//
//  Created by kazutaka.ando on 7/9/19.

//

@testable import MovieDB
import RxSwift

final class CastUseCaseMock: CastUseCaseType {

    // MARK: - getCastDetail
    var getCastDetailCalled = false
    
    var getCastDetailReturnValue: Observable<Cast> = {
        let item = Cast().with {
            $0.id = 1
        }
        return Observable.just(item)
    }()
    
    func getCastList(id: Int) -> Observable<Cast> {
        getCastDetailCalled = true
        return getCastDetailReturnValue
    }
    
    // MARK: - getMovieListByCast
    var getMovieListByCastCalled = false
    
    var getMovieListByCastReturnValue: Observable<PagingInfo<Movie>> = {
        let items = [
            Movie().with { $0.id = 1 }
        ]
        let page = PagingInfo<Movie>(page: 1, items: items)
        return Observable.just(page)
    }()
    
    func getMovieListByCast(id: Int) -> Observable<PagingInfo<Movie>> {
        getMovieListByCastCalled = true
        return getMovieListByCastReturnValue
    }
    
    // MARK: - loadMoreMovieListByCast
    var loadMoreMovieListByCastCalled = false
    
    var loadMoreMovieListByCastReturnValue: Observable<PagingInfo<Movie>> = {
        let items = [
            Movie().with { $0.id = 2 }
        ]
        let page = PagingInfo<Movie>(page: 2, items: items)
        return Observable.just(page)
    }()
    
    func loadMoreMovieListByCast(id: Int, page: Int) -> Observable<PagingInfo<Movie>> {
        loadMoreMovieListByCastCalled = true
        return loadMoreMovieListByCastReturnValue
    }
}
