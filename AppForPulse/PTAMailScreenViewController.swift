//
//  PTAMailScreenViewController.swift
//  AppForPulse
//
//  Created by Ivashin Dmitry on 3/27/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import UIKit
import CoreData

class PTAMailScreenViewController: CoreDataTableViewController, UITextFieldDelegate {
    
    struct CellReuseIdentifier {
        static let recipeCell = "PTARecipeCell"
    }
    
    var applicationManager: PTAApplicationManager!
    
    var searchText: String? {
        didSet {
          applicationManager.apiService.searchRecipesInRemoteBy(title: searchText!) { (result) in
            switch result {
            case .success(let value):
                print(value)
                if let dictionary = value as? [String : Any] {
                    self.parseJSON(dictionary)
                }
            case .failure(let error):
                print(error)
            }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        
        getDefaultJSONDictionary()
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
    
    private func getDefaultJSONDictionary()
    {
        applicationManager.apiService.getDefaultListRecipesFromRemote { (result) in
            switch(result) {
            case .success(let value):
                print(value)
                if let dictionary = value as? [String : Any] {
                    self.parseJSON(dictionary)
                }
            case .failure(let error):
                print("****** error from parseJSON: \(error)")
            }
        }
    }
    
    private func parseJSON(_ dictionary: [String: Any])
    {
        for result in dictionary["results"] as! [[String: Any]] {
            applicationManager.apiService.updateLibraryWith(result)
        }
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
        getDefaultJSONDictionary()
        return true
    }
}
