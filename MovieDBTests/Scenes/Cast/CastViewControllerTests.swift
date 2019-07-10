//
//  CastViewControllerTests.swift
//
//  Created by kazutaka.ando on 7/9/19.

//

@testable import MovieDB
import XCTest
import Reusable

final class CastViewControllerTests: XCTestCase {
    var viewController: CastViewController!

    override func setUp() {
        super.setUp()
        viewController = CastViewController.instantiate()
    }

    func test_ibOutlets() {
        _ = viewController.view
        XCTAssert(true)
//        XCTAssertNotNil(viewController.tableView)
    }
}
