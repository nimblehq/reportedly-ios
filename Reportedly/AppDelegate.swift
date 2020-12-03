//
//  AppDelegate.swift
//  Reportedly
//
//  Created by Mikey Pham on 11/9/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    // MARK: - Application life cycle
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Showing the launch screen 0.5s more, right now it is dismissing to fast
        Thread.sleep(forTimeInterval: 0.5)
        
        // Then, show the login screen
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        let module = LoginEmailModule()
        module.router.show(on: window)
        window.makeKeyAndVisible()
        
        // TODO: - Testing purpose only, will remove when have actual APIs
        Network.shared.apollo.fetch(query: LaunchListQuery()) { result in
            switch result {
            case .success(let graphQLResult):
                print("Success! Result: \(graphQLResult)")
            case .failure(let error):
                print("Failure! Error: \(error)")
            }
        }
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
}

