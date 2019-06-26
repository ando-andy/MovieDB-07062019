//
//  CategoriesViewController.swift
//
//  Created by kazutaka.ando on 6/11/19.
//  Copyright © 2019 kazando All rights reserved.
//

import UIKit
import Reusable
import RxCocoa

final class CategoriesViewController: UIViewController, BindableType {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: RefreshTableView!
    // MARK: - Properties
    
    var viewModel: CategoriesViewModel!

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.do {
            $0.navigationBar.prefersLargeTitles = true
            $0.navigationItem.largeTitleDisplayMode = .always
        }
    }
    
    // MARK: - Methods

    private func configView() {
        self.title = viewModel.category.categoryTitle 
        tableView.do {
            $0.rowHeight = 150
            $0.register(cellType: CategoriesTableViewCell.self)
        }
    }

    func bindViewModel() {
        let input = CategoriesViewModel.Input(
            loadTrigger: Driver.just(()),
            reloadTrigger: tableView.loadMoreTopTrigger,
            loadMoreTrigger: tableView.loadMoreBottomTrigger,
            selectMovieTrigger: tableView.rx.itemSelected.asDriver()
        )
        
        let output = viewModel.transform(input)
        
        output.movieList
            .drive(tableView.rx.items) { tableView, index, movie in
                return tableView.dequeueReusableCell(
                    for: IndexPath(row: index, section: 0),
                    cellType: CategoriesTableViewCell.self)
                    .then {
                        $0.bindViewModel(MovieViewModel(movie: movie))
                    }
            }
            .disposed(by: rx.disposeBag)
        
        output.error
            .drive(rx.error)
            .disposed(by: rx.disposeBag)
        
        output.loading
            .drive(rx.isLoading)
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
        
        output.selectedMovie
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.isEmptyData
            .drive(tableView.isEmptyData)
            .disposed(by: rx.disposeBag)
    }
}

extension CategoriesViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.categories
}
