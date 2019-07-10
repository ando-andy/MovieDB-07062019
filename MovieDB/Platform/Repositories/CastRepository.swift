//
//  CastRepository.swift
//  MovieDB
//
//  Created by kazutaka.ando on 2019/07/09.
//  Copyright © 2019 Kazando. All rights reserved.
//

protocol CastRepositoryType {
    func getCastList(id: Int) -> Observable<Cast>
    func getListMovieByCast(id: Int, page: Int) -> Observable<PagingInfo<Movie>>
}

final class CastRepository: CastRepositoryType {
    
    func getCastList(id: Int) -> Observable<Cast> {
        let input = API.GetCastListInput(id: id)
        return API.shared.getCastList(input)
    }
    
    func getListMovieByCast(id: Int, page: Int) -> Observable<PagingInfo<Movie>> {
        let input = API.GetMovieListByCastInput(id: id, page: page)
        return API.shared.getListMovieByCast(input)
            .map { output in
                guard let movies = output.movies else {
                    throw APIInvalidResponseError()
                }
                return PagingInfo<Movie>(page: page, items: movies)
        }
    }
}
