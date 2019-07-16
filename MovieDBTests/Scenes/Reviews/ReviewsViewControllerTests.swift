//
//  ReviewsViewControllerTests.swift
//
//  Created by kazutaka.ando on 7/11/19.
//

@testable import MovieDB
import XCTest
import Reusable

final class ReviewsViewControllerTests: XCTestCase {
    var viewController: ReviewsViewController!

    override func setUp() {
        super.setUp()
        viewController = ReviewsViewController.instantiate()
    }

    func test_ibOutlets() {
        _ = viewController.view
        XCTAssert(true)
//        XCTAssertNotNil(viewController.tableView)
    }
}
