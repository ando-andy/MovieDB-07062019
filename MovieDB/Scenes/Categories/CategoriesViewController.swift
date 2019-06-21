//
//  CategoriesViewController.swift
//
//  Created by kazutaka.ando on 6/11/19.
//  Copyright © 2019 kazando All rights reserved.
//

import UIKit
import Reusable

final class CategoriesViewController: UIViewController, BindableType {
    
    // MARK: - IBOutlets
    
    // MARK: - Properties
    
    var viewModel: CategoriesViewModel!

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
        let input = CategoriesViewModel.Input()
        let output = viewModel.transform(input)
    }
}

// MARK: - Binders
extension CategoriesViewController {

}

// MARK: - StoryboardSceneBased
extension CategoriesViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.categories
}
