//
//  MovieDetailViewController.swift
//
//  Created by kazutaka.ando on 6/27/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import UIKit
import Reusable
import Cosmos

final class MovieDetailViewController: UIViewController, BindableType {
    
    // MARK: - IBOutlets
    @IBOutlet weak var backDropImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var reviewView: CosmosView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var overViewLabel2: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var castLabel: UILabel!
    @IBOutlet weak var castCollectionView: UICollectionView!
    
    // MARK: - Properties
    
    var viewModel: MovieDetailViewModel!

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
        self.title = self.viewModel.movie.title
        //castCollectionView.delegate = self
    }

    func bindViewModel() {
        let input = MovieDetailViewModel.Input(
            loadTrigger: Driver.just(()),
            backwardTrigger: backButton.rx.tap.asDriverOnErrorJustComplete())
        let output = viewModel.transform(input)
        
        output.movieDetail
            .map { MovieViewModel(movie: $0) }
            .drive(model)
            .disposed(by: rx.disposeBag)
        
        output.backward
            .drive()
            .disposed(by: rx.disposeBag)
    }
    
    @IBAction func showReviewButton(_ sender: Any) {
    }
    
    @IBAction func watchTrailerButton(_ sender: Any) {
    }
    
    @IBAction func addFavoriteButton(_ sender: Any) {
    }
}

// MARK: - Binders
extension MovieDetailViewController {
    var model: Binder<MovieViewModel> {
        return Binder(self) { viewController, movieDetailModel in
            viewController.do {
                $0.backDropImage.sd_setImage(with: movieDetailModel.backdropImageURL, completed: nil)
                $0.posterImage.sd_setImage(with: movieDetailModel.posterImageURL, completed: nil)
                $0.titleLabel.text = movieDetailModel.name
                $0.overViewLabel2.text = movieDetailModel.overview
                $0.timeLabel.text = String(format: "%ldm", movieDetailModel.runtime)
                $0.reviewView.rating = (movieDetailModel.voteAverage)
            }
        }
    }
}

extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.size.height
        let width = height / 2
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

// MARK: - StoryboardSceneBased
extension MovieDetailViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.movieDetail
}
