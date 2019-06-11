
@testable import MovieDB

final class AppNavigatorMock: AppNavigatorType {

    // MARK: - toMain
    
    var toMainCalled = false
    
    func toMain() {
        toMainCalled = true
    }
}
