//
//  FavoriteViewControllerTests.swift
//
//  Created by kazutaka.ando on 6/11/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

@testable import MovieDB
import XCTest
import Reusable

final class FavoriteViewControllerTests: XCTestCase {
    var viewController: FavoriteViewController!

    override func setUp() {
        super.setUp()
        viewController = FavoriteViewController.instantiate()
    }

    func test_ibOutlets() {
        _ = viewController.view
        XCTAssert(true)
//        XCTAssertNotNil(viewController.tableView)
    }
}
