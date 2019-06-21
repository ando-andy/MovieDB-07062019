import UIKit

protocol AppNavigatorType {
    func toMain()
}

struct AppNavigator: AppNavigatorType {
    unowned let assembler: Assembler
    unowned let window: UIWindow
    
    func toMain() {
        let mainVC: MainViewController = assembler.resolve()
        window.rootViewController = mainVC
    }
}
