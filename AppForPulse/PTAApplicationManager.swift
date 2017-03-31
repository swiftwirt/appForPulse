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
    
    var exterlansConfigurator = PTAExternalsConfigurator()
    
    var reachabilityStatus = ReachabilityStatus.notReachable {
        didSet {
            handleReachability()
        }
    }
    
    let reachability = Reachability()!


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
    
    func handleReachability()
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
    
    func handleExternalResources()
    {
        exterlansConfigurator.handleExternals()
        configureReachability()
    }
}
