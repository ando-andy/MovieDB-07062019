
import UIKit
import Reusable

final class MovieViewController: UITabBarController, BindableType {
    
    // MARK: - IBOutlets
    
    // MARK: - Properties
    
    var viewModel: MovieViewModel!

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
        let input = MovieViewModel.Input()
        let output = viewModel.transform(input)
    }
}

// MARK: - Binders
extension MovieViewController {

}

// MARK: - StoryboardSceneBased
extension MovieViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.movie
}
