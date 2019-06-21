//
//  CategoriesNavigator.swift
//
//  Created by kazutaka.ando on 6/11/19.
//  Copyright © 2019 kazando All rights reserved.
//

protocol CategoriesNavigatorType {

}

struct CategoriesNavigator: CategoriesNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
