@testable import MovieDB

final class MoviesNavigatorMock: MoviesNavigatorType {
    var toMoviesCategory = false
    
    func toMoviesCategory(category: CategoryType) {
        toMoviesCategory = true
    }
    
    func toSearchMovies() {
    }
    
    func toMoviesDetail() {
    }
}
