//
//  SearchUseCase.swift
//
//  Created by kazutaka.ando on 6/26/19.
//

protocol SearchUseCaseType {
    func searchMovie(_ key: String) -> Observable<PagingInfo<Movie>>
    func loadMoreSearchMovie(key: String, page: Int) -> Observable<PagingInfo<Movie>>
}

struct SearchUseCase: SearchUseCaseType {
    let movieRepository: MoviesRepositoryType
    
    func searchMovie(_ key: String) -> Observable<PagingInfo<Movie>> {
        return loadMoreSearchMovie(key: key, page: 1)
    }

    func loadMoreSearchMovie(key: String, page: Int) -> Observable<PagingInfo<Movie>> {
        return movieRepository.getSearchMovies(key: key, page: page)
    }
}
