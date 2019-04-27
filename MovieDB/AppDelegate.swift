//
//  AppDelegate.swift
//  MovieDB
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var window: UIWindow? = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = rootViewController
        return window
    }()

    private lazy var rootViewController = UINavigationController(rootViewController: ViewControllerAssembly.defaultAssembly.moviewListViewController())

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window?.makeKeyAndVisible()
        return true
    }
}

