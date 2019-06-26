//
//  CategoriesUseCase.swift
//
//  Created by kazutaka.ando on 6/11/19.
//  Copyright © 2019 kazando All rights reserved.
//

protocol CategoriesUseCaseType {
    func getMoviesList(_ category: CategoryType) -> Observable<PagingInfo<Movie>>
    func loadMoreMoviesList(category: CategoryType, page: Int) -> Observable<PagingInfo<Movie>>
}

struct CategoriesUseCase: CategoriesUseCaseType {
    
    let movieRepository: MoviesRepositoryType
    
    func getMoviesList(_ category: CategoryType) -> Observable<PagingInfo<Movie>> {
        return loadMoreMoviesList(category: category, page: 1)
    }
    
    func loadMoreMoviesList(category: CategoryType, page: Int) -> Observable<PagingInfo<Movie>> {
        return movieRepository.getMoviesList(category: category, page: page)
    }
}
