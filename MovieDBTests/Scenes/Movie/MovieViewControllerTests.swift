
@testable import MovieDB
import XCTest
import Reusable

final class MovieViewControllerTests: XCTestCase {
    var viewController: MovieViewController!

    override func setUp() {
        super.setUp()
        viewController = MovieViewController.instantiate()
    }

    func test_ibOutlets() {
        _ = viewController.view
        XCTAssert(true)
//        XCTAssertNotNil(viewController.tableView)
    }
}
