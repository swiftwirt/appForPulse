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
    func handleExternals()
    {
        setupMagicalRecord()
        setupSDWebImageManager()
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
