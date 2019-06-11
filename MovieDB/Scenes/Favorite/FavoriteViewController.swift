//
//  FavoriteViewController.swift
//
//  Created by kazutaka.ando on 6/11/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import UIKit
import Reusable

final class FavoriteViewController: UIViewController, BindableType {
    
    // MARK: - IBOutlets
    
    // MARK: - Properties
    
    var viewModel: FavoriteViewModel!

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
        let input = FavoriteViewModel.Input()
        let output = viewModel.transform(input)
    }
}

// MARK: - Binders
extension FavoriteViewController {

}

// MARK: - StoryboardSceneBased
extension FavoriteViewController: StoryboardSceneBased {
    static var sceneStoryboard = UIStoryboard()
}
