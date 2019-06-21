//
//  UIViewController+Rx.swift
//  MovieDB
//
//  Created by kazutaka.ando on 2019/06/20.
//  Copyright © 2019 Kazando. All rights reserved.
//

import UIKit
import MBProgressHUD

extension Reactive where Base: UIViewController {
    var error: Binder<Error> {
        return Binder(base) { viewController, error in
            viewController.showError(message: error.localizedDescription)
        }
    }
    
    var isLoading: Binder<Bool> {
        return Binder(base) { viewController, isLoading in
            if isLoading {
                let hud = MBProgressHUD.showAdded(to: viewController.view, animated: true)
                hud.offset.y = -30
            } else {
                MBProgressHUD.hide(for: viewController.view, animated: true)
            }
        }
    }
}
