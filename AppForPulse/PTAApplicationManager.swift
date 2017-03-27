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
    
    func handleExternalResources()
    {
        exterlansConfigurator.handleExternals()
    }
    
}
