@testable import MovieDB
import XCTest
import Reusable

final class MovieViewControllerTests: XCTestCase {
    var viewController: MoviesViewController!

    override func setUp() {
        super.setUp()
        viewController = MoviesViewController.instantiate()
    }

    func test_ibOutlets() {
        _ = viewController.view
        XCTAssert(true)
    }
}
