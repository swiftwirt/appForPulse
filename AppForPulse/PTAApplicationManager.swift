//
//  PTAApplicationManager.swift
//  AppForPulse
//
//  Created by Ivashin Dmitry on 3/27/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import UIKit
import PKHUD

enum ReachabilityStatus {
    case notReachable
    case reachableViaCell
    case reachableViaWifi
}

class PTAApplicationManager {
    
    struct DefaultsKeys {
        static let firstLaunch = "FirstTime"
    }
    
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
    
    var exterlansConfigurator = PTAExternalsConfigurator()
    var alertHandler = PATAlertHandler()
    
    let reachability = Reachability()!
    
    var reachabilityStatus = ReachabilityStatus.notReachable {
        didSet {
            handleReachability()
            handleConnectionAlerts(isFirstLaunch)
        }
    }
    
    private var isFirstLaunch: Bool {
        let userDefaults = UserDefaults.standard
        let firstLaunch = userDefaults.bool(forKey: DefaultsKeys.firstLaunch)
        if firstLaunch {
            userDefaults.set(false, forKey: DefaultsKeys.firstLaunch)
            userDefaults.synchronize()
        }
        return firstLaunch
    }
    
    func registerDefaults()
    {
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: DefaultsKeys.firstLaunch)
        userDefaults.synchronize()
    }
    
    init() {
        registerDefaults()
    }
    
    func configureReachability()
    {
        reachability.whenReachable = { reachability in
            DispatchQueue.main.async {
                if reachability.isReachableViaWiFi {
                    self.reachabilityStatus = .reachableViaWifi
                } else if reachability.isReachableViaWWAN {
                    self.reachabilityStatus = .reachableViaCell
                }
                print("Reachability now \(self.reachabilityStatus) :-)")
            }
        }
        reachability.whenUnreachable = { reachability in
            DispatchQueue.main.async {
                self.reachabilityStatus = .notReachable
                print("Reachability now \(self.reachabilityStatus) :-(")
            }
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
            self.reachabilityStatus = .reachableViaWifi
        }
    }
    
    private func handleReachability()
    {
        if reachabilityStatus == .notReachable { HUD.hide(); return }
            apiService.getDefaultListRecipesFromRemote { (result) in
                switch(result) {
                case .success(let value):
                print(value)
                if let dictionary = value as? [String : Any] {
                    self.apiService.updateLibraryWith(dictionary)
                } else {
                    print("****** Can't get JSON error")
                }
                case .failure(let error):
                print("****** error from getDefaultListRecipesFromRemote: \(error)")
            }
        }
    }
    
    private func handleConnectionAlerts(_ forFirstLaunch: Bool)
    {
        if forFirstLaunch { return }
        
        switch reachabilityStatus {
        case .notReachable:
            alertHandler.showOfflineAlert()
        default:
            alertHandler.showOnlineAlert()
        }
    }
    
    func handleExternalResources()
    {
        exterlansConfigurator.handleExternals()
        configureReachability()
    }
}
