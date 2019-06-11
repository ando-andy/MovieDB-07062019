import UIKit

protocol AppNavigatorType {
    func toMain()
}

struct AppNavigator: AppNavigatorType {
    unowned let assembler: Assembler
    unowned let window: UIWindow
    
    func toMain() {
        let navigator: MainNavigatorType = assembler.resolve(window: window)
        navigator.toMain()
    }
}
