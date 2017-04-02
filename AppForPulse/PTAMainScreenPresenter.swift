//
//  PTAMainScreenPresenter.swift
//  AppForPulse
//
//  Created by Ivashin Dmitry on 3/28/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import UIKit
import CoreData

class PTAMainScreenPresenter
{
    struct ThemeColors {
        static let green = UIColor(colorLiteralRed: 37/255, green: 158/255, blue: 37/255, alpha: 1.0)
    }
    
    weak var output: PTAMainScreenViewController!
    
    func fiterLibraryWith(_ predicate: NSPredicate?)
    {
        output.fetchedResultsController = nil

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RecipeEntity")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        fetchRequest.predicate = predicate
        output.fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: .mr_default(), sectionNameKeyPath: nil, cacheName: nil)    
    }
    
    func handleFetch()
    {        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RecipeEntity")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        output.fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: .mr_default(), sectionNameKeyPath: nil, cacheName: nil)
    }
    
    func showNoLinkAlert()
    {
        let alertController = UIAlertController(title: "Oooops! No link!", message: "Recipe you're trying get details about has no deep links! Sorry there's nothing we could do =(", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(action)
        output.present(alertController, animated: true, completion: nil)
    }
    
    func getSearchBar() -> UIView
    {
        let rect = output.tableView.frame
        
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: -44.0, width: rect.size.width, height: 44.0))
        searchBar.barTintColor = ThemeColors.green
        searchBar.placeholder = "Search"
        searchBar.delegate = output
        
        // MARK: - removes ugly top and bottom lines
        let bottomLineView = UIView(frame: CGRect(x: 0, y: rect.size.height-2, width: rect.size.width, height: 2))
        bottomLineView.backgroundColor = ThemeColors.green
        searchBar.addSubview(bottomLineView)
        
        let topLineView = UIView(frame: CGRect(x: 0, y: 0, width: rect.size.width, height: 2))
        topLineView.backgroundColor = ThemeColors.green
        searchBar.addSubview(topLineView)
        
        return searchBar
    }
    
    
}
