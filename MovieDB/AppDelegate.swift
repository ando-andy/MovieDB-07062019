//
//  AppDelegate.swift
//  MovieDB
//
//  Created by kazutaka.ando on 2019/06/10.
//  Copyright © 2019 Kazando. All rights reserved.
//

import UIKit
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var assembler: Assembler = DefaultAssembler()
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
       // Localize.setCurrentLanguage("ja")
        
        window = UIWindow(frame: UIScreen.main.bounds).then {
            $0.tintColor = UIColor.black
            $0.backgroundColor = UIColor.white
        }
        
        if NSClassFromString("XCTest") != nil { // test
            window?.rootViewController = UnitTestViewController()
        } else {
            bindViewModel()
        }
    }
    
    private func bindViewModel() {
        guard let window = window else { return }
        
        let vm: AppViewModel = assembler.resolve(window: window)
        let input = AppViewModel.Input(loadTrigger: Driver.just(()))
        let output = vm.transform(input)
        
        output.toMain
            .drive()
            .disposed(by: rx.disposeBag)
    }
}
