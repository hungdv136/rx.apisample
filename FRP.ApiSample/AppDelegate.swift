//
//  AppDelegate.swift
//  FRP.ApiSample
//
//  Created by Hung Dinh on 10/9/16.
//  Copyright © 2016 Chu Cuoi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = createRootViewController()
        return true
    }
    
    private func createRootViewController() -> UINavigationController {
        let rootController = PostViewController()
        rootController.viewModel = PostViewModel(service: PostAPIService())
        return UINavigationController(rootViewController: rootController)
    }
}

