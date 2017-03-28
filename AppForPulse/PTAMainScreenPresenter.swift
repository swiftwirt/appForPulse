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
    weak var output: PTAMailScreenViewController!
    
    func showNoConnectionError()
    {

    }
    
    func fiterLibraryWith(_ predicate: NSPredicate?)
    {
        output.fetchedResultsController = nil

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RecipeEntity")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        fetchRequest.predicate = predicate
        output.fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: .mr_default(), sectionNameKeyPath: nil, cacheName: nil)
    }
}
