//
//  MovieDetailViewControllerTests.swift
//
//  Created by kazutaka.ando on 6/27/19.

//

@testable import MovieDB
import Reusable
import XCTest

final class MovieDetailControllerTests: XCTest {
    
    private var viewController: MovieDetailViewController!
    
    override func setUp() {
        super.setUp()
        viewController = MovieDetailViewController.instantiate()
    }
    
    func test_ibOutlets() {
        _ = viewController.view
        XCTAssertNotNil(viewController.backDropImage)
        XCTAssertNotNil(viewController.posterImage)
        XCTAssertNotNil(viewController.titleLabel)
        XCTAssertNotNil(viewController.timeLabel)
        XCTAssertNotNil(viewController.overviewLabel)
        XCTAssertNotNil(viewController.castCollectionView)
        XCTAssertNotNil(viewController.reviewView)
        XCTAssertNotNil(viewController.backButton)
        XCTAssertNotNil(viewController.watchTrailerButton)
        XCTAssertNotNil(viewController.showReviewButton)
        XCTAssertNotNil(viewController.addFavoriteButton)
    }
}
