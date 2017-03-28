//
//  PTAMainScreenConfigurator.swift
//  AppForPulse
//
//  Created by Ivashin Dmitry on 3/28/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import UIKit

class PTAMainScreenConfigurator {
    
    class var sharedInstance: PTAMainScreenConfigurator {
        return PTAMainScreenConfigurator()
    }
    
    func configure(_ viewController: PTAMailScreenViewController) {
        
        let presenter = PTAMainScreenPresenter()
        presenter.output = viewController
        
        let interactor = PTAMainScreenInteractor()
        interactor.output = presenter
        
        viewController.output = interactor
    }
}
