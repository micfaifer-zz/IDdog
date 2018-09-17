//
//  AppDelegate.swift
//  IDdog
//
//  Created by lugia on 11/09/18.
//  Copyright © 2018 MicFaifer. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        if UserDefaultsManager.shared.userToken != nil {
            let homeView = storyboard.instantiateViewController(withIdentifier: "dogfeed")
            self.window?.rootViewController = homeView
        }else {
            let homeView = storyboard.instantiateViewController(withIdentifier: "login")
            self.window?.rootViewController = homeView
        }
        self.window?.makeKeyAndVisible()

        return true
    }
}

