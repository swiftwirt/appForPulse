//
//  PTAMainScreenInteractor.swift
//  AppForPulse
//
//  Created by Ivashin Dmitry on 3/28/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import UIKit

class PTAMainScreenInteractor {

    var output: PTAMainScreenPresenter!
    
    var applicationManager: PTAApplicationManager = {
        return PTAApplicationManager.instance()
    }()
    
    func getDefaultList() {
        let status = applicationManager.reachabilityStatus
        switch status {
        case .reachableViaCell, .reachableViaWifi:
            getDefaultFromRemote()
            output.fiterLibraryWith(nil)
            break
        case .notReachable:
            output.fiterLibraryWith(nil)
            break
        }
    }
    
    func searchWith(_ title: String)
    {
        let status = applicationManager.reachabilityStatus
        switch status {
        case .reachableViaCell, .reachableViaWifi:
            searchInRemote(title)
            let predicate = NSPredicate(format: "title CONTAINS[c] %@", title)
            output.fiterLibraryWith(predicate)
            break
        case .notReachable:
            let predicate = NSPredicate(format: "title CONTAINS[c] %@", title)
            output.fiterLibraryWith(predicate)
            break
        }
    }
    
    func showNoLinkAlert()
    {
        output.showNoLinkAlert()
    }
    
    func handleFetch()
    {
        output.handleFetch()
    }
    
    func getSearchBar() -> UIView
    {
        return output.getSearchBar()
    }
    
    private func searchInRemote(_ searchText: String)
    {
        applicationManager.apiService.searchRecipesInRemoteBy(title: searchText) { (result) in
            switch(result) {
            case .success(let value):
                print(value)
                if let dictionary = value as? [String : Any] {
                    self.applicationManager.apiService.updateLibraryWith(dictionary)
                }
            case .failure(let error):
                print("****** error from parseJSON: \(error)")
            }
        }
    }
    
    private func getDefaultFromRemote()
    {
        applicationManager.apiService.getDefaultListRecipesFromRemote { (result) in
            switch(result) {
            case .success(let value):
                print(value)
                if let dictionary = value as? [String : Any] {
                    self.applicationManager.apiService.updateLibraryWith(dictionary)
                }
                print("****** Can't get JSON error")
            case .failure(let error):
                print("****** error from getDefaultListRecipesFromRemote: \(error)")
            }
        }
    }
}
