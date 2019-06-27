@testable import MovieDB

final class MoviesNavigatorMock: MoviesNavigatorType {
    var toMoviesCategory = false
    var toSearchMovie = false
    
    func toMoviesCategory(category: CategoryType) {
        toMoviesCategory = true
    }
    
    func toSearchMovies() {
        toSearchMovie = false
    }
    
    func toMoviesDetail() {
    }
}
