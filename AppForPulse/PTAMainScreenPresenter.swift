//
//  PTAMainScreenPresenter.swift
//  AppForPulse
//
//  Created by Ivashin Dmitry on 3/28/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import UIKit
import CoreData
import SVWebViewController

class PTAMainScreenPresenter
{
    weak var output: PTAMainScreenViewController!
    
    func fiterLibraryWith(_ predicate: NSPredicate?)
    {
        output.fetchedResultsController = nil

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RecipeEntity")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        fetchRequest.predicate = predicate
        output.fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: .mr_default(), sectionNameKeyPath: nil, cacheName: nil)    
    }
    
    func showWebPage(_ link: String)
    {
        if link != "" { // TODO: put validation here
            let webViewController = SVWebViewController(address: link)
            output.navigationController?.show(webViewController!, sender: nil)
        } else {
            showNoLinkAlert()
        }
    }
    
    func handleFetch()
    {        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RecipeEntity")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        output.fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: .mr_default(), sectionNameKeyPath: nil, cacheName: nil)
    }
    
    private func showNoLinkAlert()
    {
        let alertController = UIAlertController(title: "Oooops! No link!", message: "Recipe you're trying get details about has no deep links! Sorry there's nothing we could do =( ", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(action)
        output.present(alertController, animated: true, completion: nil)
    }
}
