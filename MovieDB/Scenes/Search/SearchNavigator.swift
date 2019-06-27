//
//  SearchNavigator.swift
//
//  Created by kazutaka.ando on 6/26/19.
//

protocol SearchNavigatorType {
    func toMovieDetail()
}

struct SearchNavigator: SearchNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toMovieDetail() {
        //TODO
    }

}
