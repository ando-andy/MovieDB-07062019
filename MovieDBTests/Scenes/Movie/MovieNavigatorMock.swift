@testable import MovieDB

final class MoviesNavigatorMock: MoviesNavigatorType {
    var toMoviesCategoryCalled = false
    var toSearchMovieCalled = false
    var toMovieDetailCalled = false
    
    func toMoviesCategory(category: CategoryType) {
        toMoviesCategoryCalled = true
    }
    
    func toSearchMovies() {
        toSearchMovieCalled = true
    }
    
    func toMovieDetail(movie: Movie) {
        toMovieDetailCalled = true
    }
}
