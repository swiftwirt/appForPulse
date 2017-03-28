//
//  PTAApplicationManager.swift
//  AppForPulse
//
//  Created by Ivashin Dmitry on 3/27/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import UIKit

class PTAApplicationManager {
    
    private var exterlansConfigurator = PTAExternalsConfigurator()
    
    // MARK: - Made for cases when we can't use dependancy injection
    static func instance() -> PTAApplicationManager
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }        
        return appDelegate.applicationManager
    }
    
    lazy var apiService: PTAAPIService = {
        
        let service = PTAAPIService()
        
        return service
        
    }()
    
    lazy var isFirstLaunch: Bool = {
        let userDefaults = UserDefaults.standard
        let firstTime = userDefaults.bool(forKey: "FirstTime")
        if firstTime {
            userDefaults.set(false, forKey: "FirstTime")
            userDefaults.synchronize()
        }
        return firstTime
    }()
    
    func handleExternalResources()
    {
        exterlansConfigurator.handleExternals()
    }
    
    func registerDefaults() {
        let dictionary = ["FirstTime": true] as [String : Any]
        UserDefaults.standard.register(defaults: dictionary)
    }
}
