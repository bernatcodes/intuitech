//
//  AppDelegate.swift
//  Intuitech
//
//  Created by Bernát Szabó on 2023. 09. 06..
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let navigationController = UINavigationController()
        let networkManager = NetworkManager()
        let coordinator = Coordinator(navigationController: navigationController,
                                      networkManager: networkManager)
        coordinator.start()
        
        window?.makeKeyAndVisible()
        window?.rootViewController = navigationController
        return true
    }
}
