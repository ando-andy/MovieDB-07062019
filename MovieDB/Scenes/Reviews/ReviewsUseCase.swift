//
//  ReviewsUseCase.swift
//
//  Created by kazutaka.ando on 7/11/19.
//

protocol ReviewsUseCaseType {
    func getReviewList(_ id: Int) -> Observable<PagingInfo<Review>>
    func loadMoreReviewList(id: Int, page: Int) -> Observable<PagingInfo<Review>>
}

struct ReviewsUseCase: ReviewsUseCaseType {
    let reviewRepository: ReviewsRepositoryType
    
    func getReviewList(_ id: Int) -> Observable<PagingInfo<Review>> {
        return loadMoreReviewList(id: id, page: 1)
    }
    
    func loadMoreReviewList(id: Int, page: Int) -> Observable<PagingInfo<Review>> {
        return reviewRepository.getReviewList(id: id, page: page)
    }
}
