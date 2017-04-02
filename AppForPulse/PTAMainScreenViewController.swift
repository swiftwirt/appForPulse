//
//  PTAMainScreenViewController.swift
//  AppForPulse
//
//  Created by Ivashin Dmitry on 3/27/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import UIKit
import CoreData

class PTAMainScreenViewController: CoreDataTableViewController {
    
    struct CellReuseIdentifier {
        static let recipeCell = "PTARecipeCell"
    }
    
    var applicationManager: PTAApplicationManager!
    
    var output: PTAMainScreenInteractor!
    var router: PTAMainScreenRouter!
    
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
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifier.recipeCell, for: indexPath) as! PTARecipeCell
        let recipe = fetchedResultsController?.object(at: indexPath) as? RecipeEntity!
        cell.recipe = recipe
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return getSearchBar()
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = fetchedResultsController?.object(at: indexPath) as? RecipeEntity!
        guard let link = recipe?.deepLink else { return }
        showWebPage(link)
    }
    
    func getSearchBar() -> UIView
    {
        return output.getSearchBar()
    }
    
    func getDefaultList()
    {
        output.getDefaultList()
    }
    
    func searchWith(_ title: String)
    {
        output.searchWith(title)
    }
    
    func showWebPage(_ link: String)
    {
        router.showWebPage(link)
    }
    
    func handleFetch() {
        output.handleFetch()
    }
}

extension PTAMainScreenViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            getDefaultList()
            searchBar.resignFirstResponder()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchText = searchBar.text
    }
}
