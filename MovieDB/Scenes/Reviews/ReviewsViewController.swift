//
//  ReviewsViewController.swift
//
//  Created by kazutaka.ando on 7/11/19.
//

import UIKit
import Reusable

final class ReviewsViewController: UIViewController, BindableType {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: RefreshTableView!
    
    // MARK: - Properties
    
    var viewModel: ReviewsViewModel!

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
        title = "Reviews"
        tableView.do {
            $0.estimatedRowHeight = 150
            $0.register(cellType: ReviewTableViewCell.self)
        }
        
    }

    func bindViewModel() {
        let input = ReviewsViewModel.Input(loadTrigger: Driver.just(()),
                                           reloadTrigger: tableView.loadMoreTopTrigger,
                                           loadMoreTrigger: tableView.loadMoreBottomTrigger)
        let output = viewModel.transform(input)
        
        output.reviewList
            .drive(tableView.rx.items) { tableView, index, review in
                return tableView.dequeueReusableCell(
                    for: IndexPath(row: index, section: 0),
                    cellType: ReviewTableViewCell.self)
                    .then {
                        $0.bindViewModel(ReviewViewModel(review: review))
                    }
            }
            .disposed(by: rx.disposeBag)
        
        output.error
            .drive(rx.error)
            .disposed(by: rx.disposeBag)
        
        output.refreshing
            .drive(tableView.isLoadingMoreTop)
            .disposed(by: rx.disposeBag)
        
        output.loadingMore
            .drive(tableView.isLoadingMoreBottom)
            .disposed(by: rx.disposeBag)
        
        output.fetchItems
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.isEmptyData
            .drive(tableView.isEmptyData)
            .disposed(by: rx.disposeBag)
    }
}

// MARK: - Binders
extension ReviewsViewController {

}

// MARK: - StoryboardSceneBased
extension ReviewsViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.reviews
}
