//
//  CategoriesViewControllerTests.swift
//
//  Created by kazutaka.ando on 6/11/19.
//  Copyright © 2019 kazando All rights reserved.
//

@testable import MovieDB
import XCTest
import Reusable

final class CategoryViewControllerTests: XCTest {
    private var viewController: CategoriesViewController!
    
    override func setUp() {
        super.setUp()
        viewController = CategoriesViewController.instantiate()
    }
    
    func test_ibOutlets() {
        _ = viewController.view
        XCTAssertNotNil(viewController.tableView)
    }
}
