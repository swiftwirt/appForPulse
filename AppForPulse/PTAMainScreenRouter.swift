//
//  PTAMainScreenRouter.swift
//  AppForPulse
//
//  Created by Ivashin Dmitry on 4/2/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import UIKit
import SVWebViewController

class PTAMainScreenRouter {
    
    weak var viewController: PTAMainScreenViewController!
    
    func showWebPage(_ link: String)
    {
        if link != "" { // TODO: put validation here
            let webViewController = SVWebViewController(address: link)
            viewController.navigationController?.show(webViewController!, sender: nil)
        } else {
            viewController.output.showNoLinkAlert()
        }
    }
}
