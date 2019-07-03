//
//  MovieDetailNavigator.swift
//
//  Created by kazutaka.ando on 6/27/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

protocol MovieDetailNavigatorType {
    func toCastDetail()
    func backward()
}

struct MovieDetailNavigator: MovieDetailNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController

    func toCastDetail() {
    }
    
    func backward() {
        navigationController.popViewController(animated: true)
    }
    
}
