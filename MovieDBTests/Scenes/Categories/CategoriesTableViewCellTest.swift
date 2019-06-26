//
//  CategoriesTableViewCellTest.swift
//  MovieDBTests
//
//  Created by kazutaka.ando on 2019/06/26.
//  Copyright © 2019 Kazando. All rights reserved.
//

@testable import MovieDB
import XCTest

final class CategoriesTableViewCellTest: XCTestCase {

    var cell: CategoriesTableViewCell!
    
    override func setUp() {
        super.setUp()
        cell = CategoriesTableViewCell.loadFromNib()
    }
    
    func test_ibOutlets() {
        XCTAssertNotNil(cell)
        XCTAssertNotNil(cell.nameLabel)
        XCTAssertNotNil(cell.posterImage)
    }
}
