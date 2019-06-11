
@testable import MovieDB
import XCTest
import Reusable

final class MainViewControllerTests: XCTestCase {
    var viewController: MainViewController!

    override func setUp() {
        super.setUp()
        viewController = MainViewController()
    }

    func test_ibOutlets() {
        XCTAssertNotNil(viewController)
        
    }
}
