//
//  PTAExternalsConfigurator.swift
//  AppForPulse
//
//  Created by Ivashin Dmitry on 3/27/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import Foundation
import MagicalRecord
import SDWebImage

class PTAExternalsConfigurator
{
    enum ReachabilityStatus {
        case notReachable
        case reachableViaCell
        case reachableViaWifi
    }
    
    let reachability = Reachability()!
    
    var reachabilityStatus = ReachabilityStatus.notReachable
    
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
    
    func handleExternals()
    {
        setupMagicalRecord()
        setupSDWebImageManager()
        configureReachability()
    }
    
    private func setupMagicalRecord()
    {
        MagicalRecord.setLoggingLevel(.error)
        MagicalRecord.setupCoreDataStack(withAutoMigratingSqliteStoreNamed: "Model")
    }
    
    private func setupSDWebImageManager()
    {
        SDWebImageManager.shared().imageDownloader?.shouldDecompressImages = false
        SDWebImageManager.shared().imageDownloader?.maxConcurrentDownloads = 5
        SDWebImageManager.shared().imageDownloader?.executionOrder = .lifoExecutionOrder
    }    
}
