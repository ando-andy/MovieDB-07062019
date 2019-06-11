//
//  FavoriteNavigator.swift
//
//  Created by kazutaka.ando on 6/11/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

protocol FavoriteNavigatorType {

}

struct FavoriteNavigator: FavoriteNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
