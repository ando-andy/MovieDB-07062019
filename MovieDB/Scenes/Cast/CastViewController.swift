//
//  CastViewController.swift
//
//  Created by kazutaka.ando on 7/9/19.

//

import UIKit
import Reusable

final class CastViewController: UIViewController, BindableType {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var castImage: UIImageView!
    @IBOutlet weak var castNameLabel: UILabel!
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var knowForLabel: UILabel!
    @IBOutlet weak var placeOfBirthLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var biographyLabel: UILabel!

    // MARK: - Properties
    
    var viewModel: CastViewModel!

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    override func loadView() {
        super.loadView()
        self.hidesBottomBarWhenPushed = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Methods

    private func configView() {
        movieTableView.do {
            $0.rowHeight = 120
            $0.register(cellType: CategoriesTableViewCell.self)
        }
    }

    func bindViewModel() {
        let input = CastViewModel.Input(
            loadTrigger: Driver.just(()),
            backwardTrigger: backButton.rx.tap.asDriverOnErrorJustComplete(),
            selectMovieTrigger: movieTableView.rx.itemSelected.asDriver()
        )
        
        let output = viewModel.transform(input)
        
        output.castList
            .map{ CastMovieDetailViewModel(cast: $0) }
            .drive(cast)
            .disposed(by: rx.disposeBag)
        
        output.movieList
            .drive(movieTableView.rx.items) { tableView, index, movie in
                return tableView.dequeueReusableCell(
                    for: IndexPath(row: index, section: 0),
                    cellType: CategoriesTableViewCell.self)
                    .then {
                        $0.bindViewModel(MovieViewModel(movie: movie))
                    }
            }
            .disposed(by: rx.disposeBag)
        
        output.backward
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.selectedMovie
            .drive()
            .disposed(by: rx.disposeBag)
    }
}

// MARK: - Binders
extension CastViewController {
    var cast: Binder<CastMovieDetailViewModel> {
        return Binder(self) { viewController, castDetailModel in
            viewController.do {
                $0.castImage.sd_setImage(with: castDetailModel.profileImageURL, completed: nil)
                $0.castNameLabel.text = castDetailModel.name
                $0.knowForLabel.text = String(format: "Known For: %@",
                                              castDetailModel.knowFor)
                $0.genderLabel.text = String(format: "Gender: %@",
                                             castDetailModel.gender.title)
                $0.birthdayLabel.text = String(format: "Birthday: %@",
                                               castDetailModel.birthdayString)
                $0.placeOfBirthLabel.text = String(format: "Place of birth: %@",
                                                   castDetailModel.placeOfBirth)
                $0.biographyLabel.text = castDetailModel.biography
            }
        }
    }
}

// MARK: - StoryboardSceneBased
extension CastViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.cast
}
