//
//  PTAMailScreenViewController.swift
//  AppForPulse
//
//  Created by Ivashin Dmitry on 3/27/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import UIKit
import CoreData

class PTAMailScreenViewController: CoreDataTableViewController {
    
    struct CellReuseIdentifier {
        static let recipeCell = "PTARecipeCell"
    }
    
    var applicationManager: PTAApplicationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        parseJSON()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RecipeEntity")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: .mr_default(), sectionNameKeyPath: nil, cacheName: nil)
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifier.recipeCell, for: indexPath)
        let recipe = fetchedResultsController?.object(at: indexPath) as! RecipeEntity
        cell.textLabel?.text = recipe.title
        cell.detailTextLabel?.text = recipe.details
        return cell
    }
    
    private func parseJSON()
    {
        applicationManager.apiService.getDefaultListRecipesFromRemote { (result) in
            switch(result) {
            case .success(let value):
                print(value)
            case .failure(let error):
                print("****** error from parseJSON: \(error)")
            }
        }
    }
}
