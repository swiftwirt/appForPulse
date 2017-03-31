//
//  PTAMainScreenViewController.swift
//  AppForPulse
//
//  Created by Ivashin Dmitry on 3/27/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import UIKit
import CoreData

class PTAMainScreenViewController: CoreDataTableViewController, UITextFieldDelegate {
    
    struct CellReuseIdentifier {
        static let recipeCell = "PTARecipeCell"
    }
    
    var applicationManager: PTAApplicationManager!
    
    var output: PTAMainScreenInteractor!
    
    var searchText: String? {
        didSet {
            searchWith(searchText!)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PTAMainScreenConfigurator.sharedInstance.configure(self)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        
        getDefaultList()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RecipeEntity")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: .mr_default(), sectionNameKeyPath: nil, cacheName: nil)
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifier.recipeCell, for: indexPath) as! PTARecipeCell
        let recipe = fetchedResultsController?.object(at: indexPath)
        cell.recipe = recipe as! RecipeEntity!
        return cell
    }
    
    func getDefaultList()
    {
        output.getDefaultList()
    }
    
    func searchWith(_ title: String)
    {
        output.searchWith(title)
    }
    
    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            searchTextField.delegate = self
            searchTextField.text = searchText
        }
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        searchText = textField.text
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        getDefaultList()
        return true
    }
}
