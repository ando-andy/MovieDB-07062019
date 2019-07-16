//
//  ReviewsNavigator.swift
//
//  Created by kazutaka.ando on 7/11/19.
//

protocol ReviewsNavigatorType {
    
}

struct ReviewsNavigator: ReviewsNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
