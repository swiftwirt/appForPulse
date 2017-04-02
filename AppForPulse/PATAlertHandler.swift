//
//  PATAlertHandler.swift
//  AppForPulse
//
//  Created by Ivashin Dmitry on 4/2/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import UIKit

class PATAlertHandler {

    func showOnlineAlert()
    {
        let alertController = UIAlertController(title: "Connected!", message: "Internet connection established! We're good to go!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(action)
        
        if let visibleViewController = getVisibleViewController() {
            visibleViewController.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showOfflineAlert()
    {
        let alertController = UIAlertController(title: "Disconnected!", message: "Internet connection lost! I shall better use local base for search!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(action)
        
        if let visibleViewController = getVisibleViewController() {
            visibleViewController.present(alertController, animated: true, completion: nil)
        }
    }
    
    private func getVisibleViewController() -> UIViewController?
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        let navigationViewController = appDelegate.window?.rootViewController as! UINavigationController
        let visibleViewController = navigationViewController.topViewController
        return visibleViewController
    }

}
