
@testable import MovieDB

final class MainNavigatorMock: MainNavigatorType {
    // MARK: - toMain
    
    var toMainCalled = false
    
    func toMain() {
        toMainCalled = true
    }
}
