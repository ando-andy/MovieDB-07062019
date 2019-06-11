
import UIKit
import Reusable

final class MainViewController: UITabBarController, BindableType {
    
    // MARK: - IBOutlets
    
    // MARK: - Properties
    
    var viewModel: MainViewModel!

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    deinit {
        logDeinit()
    }
    
    // MARK: - Methods

    private func configView() {
        
    }

    func bindViewModel() {
        let input = MainViewModel.Input()
        let output = viewModel.transform(input)
    }
}

// MARK: - Binders
extension MainViewController {

}
