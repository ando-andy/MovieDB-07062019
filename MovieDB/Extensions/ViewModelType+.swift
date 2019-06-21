//
//  ViewModelType+.swift
//  MovieDB
//
//  Created by kazutaka.ando on 2019/06/20.
//  Copyright © 2019 Kazando. All rights reserved.
//

extension ViewModelType {
    func checkIfDataIsEmpty<T: Collection>(fetchItemsTrigger: Driver<Void>,
                                           loadTrigger: Driver<Bool>,
                                           items: Driver<T>) -> Driver<Bool> {
        return Driver.combineLatest(fetchItemsTrigger, loadTrigger)
            .map { $0.1 }
            .withLatestFrom(items) { ($0, $1.isEmpty) }
            .map { loading, isEmpty -> Bool in
                if loading { return false }
                return isEmpty
            }
    }
    
    func validate<T>(object: Driver<T>,
                     trigger: Driver<Void>,
                     validator: @escaping (T) -> ValidationResult) -> Driver<ValidationResult> {
        return Driver.combineLatest(object, trigger)
            .map { $0.0 }
            .map { validator($0) }
            .startWith(.valid)
    }
}

