@testable import MovieDB
import RxSwift

final class MovieUseCaseMock: MoviesUseCaseType {

    // MARK: - getMoviesList
    var getMovieListCalled = false
    
    var getMovieListReturnValue: Observable<PagingInfo<Movie>> = {
        let items = [
            Movie().with { $0.id = 1 }
        ]
        let page = PagingInfo<Movie>(page: 1, items: items)
        return Observable.just(page)
    }()
    
    func getMoviesList(_ category: CategoryType) -> Observable<PagingInfo<Movie>> {
        getMovieListCalled = true
        return getMovieListReturnValue
    }
}
