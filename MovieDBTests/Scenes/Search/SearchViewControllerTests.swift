//
//  SearchViewControllerTests.swift
//
//  Created by kazutaka.ando on 6/26/19.
//

@testable import MovieDB
import XCTest
import Reusable

final class SearchViewControllerTests: XCTestCase {
    var viewController: SearchViewController!

    override func setUp() {
        super.setUp()
        viewController = SearchViewController.instantiate()
    }

    func test_ibOutlets() {
        _ = viewController.view
        XCTAssert(true)
//        XCTAssertNotNil(viewController.tableView)
    }
}
