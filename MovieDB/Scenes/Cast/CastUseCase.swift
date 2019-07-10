//
//  CastUseCase.swift
//
//  Created by kazutaka.ando on 7/9/19.

//

protocol CastUseCaseType {
    func getCastList(id: Int) -> Observable<Cast>
    func getMovieListByCast(id: Int) -> Observable<PagingInfo<Movie>>
    func loadMoreMovieListByCast(id: Int, page: Int) -> Observable<PagingInfo<Movie>>
}

struct CastUseCase: CastUseCaseType {
    let castRepository: CastRepositoryType
    
    func getCastList(id: Int) -> Observable<Cast> {
        return castRepository.getCastList(id: id)
    }
    
    func getMovieListByCast(id: Int) -> Observable<PagingInfo<Movie>> {
        return loadMoreMovieListByCast(id: id, page: 1)
    }
    
    func loadMoreMovieListByCast(id: Int, page: Int) -> Observable<PagingInfo<Movie>> {
        return castRepository.getListMovieByCast(id: id, page: page)
    }

}
