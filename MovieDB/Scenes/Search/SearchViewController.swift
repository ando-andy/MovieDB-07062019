//
//  SearchViewController.swift
//
//  Created by kazutaka.ando on 6/26/19.
//

import UIKit
import Reusable

final class SearchViewController: UIViewController, BindableType {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: RefreshTableView!
    
    // MARK: - Properties
    
    var viewModel: SearchViewModel!
    private var searchTerms = ""
    private var searchWasCancelled = false
    
    let searchController = UISearchController(searchResultsController: nil)
    
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
   
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationItem.searchController?.isActive = false
    }
    
    // MARK: - Methods

    private func configView() {
        self.do {
            $0.definesPresentationContext = true
            $0.title = "Search Movie"
        }
        
        searchController.do {
            $0.searchBar.delegate = self
            $0.searchBar.placeholder = "Enter Keyword"
        }
        
        navigationItem.do {
            $0.searchController = searchController
            $0.hidesSearchBarWhenScrolling = false
            $0.searchController?.obscuresBackgroundDuringPresentation = false
        }
        
        tableView.do {
            $0.rowHeight = 150
            $0.register(cellType: CategoriesTableViewCell.self)
        }
    }

    func bindViewModel() {
        let input = SearchViewModel.Input(
            loadTrigger: Driver.just(()),
            reloadTrigger: tableView.loadMoreTopTrigger,
            loadMoreTrigger: tableView.loadMoreBottomTrigger,
            selectMovieTrigger: tableView.rx.itemSelected.asDriver(),
            textTrigger: searchController.searchBar.rx.text.orEmpty.asDriver()
                .throttle(0.5)
                .distinctUntilChanged()
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

// MARK: - Binders
extension SearchViewController {

}

// MARK: - Delegaiton
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchWasCancelled = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchTerms = searchBar.text ?? ""
        searchWasCancelled = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchWasCancelled {
            searchBar.text = self.searchTerms
        } else {
            searchTerms = searchBar.text ?? ""
        }
    }
}

// MARK: - StoryboardSceneBased
extension SearchViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.search
}
