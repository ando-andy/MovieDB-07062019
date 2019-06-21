//
//  Utils.swift
//  MovieDB
//
//  Created by kazutaka.ando on 2019/06/20.
//  Copyright © 2019 Kazando. All rights reserved.
//

func after(interval: TimeInterval, completion: (() -> Void)?) {
    DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
        completion?()
    }
}
