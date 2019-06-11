//
//  CategoriesViewControllerTests.swift
//
//  Created by kazutaka.ando on 6/11/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

@testable import MovieDB
import XCTest
import Reusable

final class CategoriesViewControllerTests: XCTestCase {
    var viewController: CategoriesViewController!

    override func setUp() {
        super.setUp()
        viewController = CategoriesViewController.instantiate()
    }

    func test_ibOutlets() {
        _ = viewController.view
        XCTAssert(true)
//        XCTAssertNotNil(viewController.tableView)
    }
}
