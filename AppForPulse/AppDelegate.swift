//
//  AppDelegate.swift
//  AppForPulse
//
//  Created by Ivashin Dmitry on 3/27/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let applicationManager = PTAApplicationManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        applicationManager.handleExternalResources()
        
        let navigationController = window?.rootViewController as! UINavigationController
        let mainScreenViewController = navigationController.viewControllers[0] as! PTAMainScreenViewController
        mainScreenViewController.applicationManager = applicationManager
        
        return true
    }
}

