//
//  PTAAPIService.swift
//  AppForPulse
//
//  Created by Ivashin Dmitry on 3/27/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import UIKit

enum APIResult<T>
{
    case success(T)
    case failure(Error)
}

class PTAAPIService {

    private let restAPIService = PTARestAPIService()
    private let libraryService = PTALibraryService()
    
    func getDefaultListRecipesFromRemote(_ completionHandler: @escaping (APIResult<Any>) -> Void)
    {
        restAPIService.getDefaultListRecipes(completionHandler)
    }
    
    func searchRecipesInRemoteBy(title: String, completionHandler: @escaping (APIResult<Any>) -> Void)
    {
        restAPIService.searchRecipesBy(title: title, completionHandler: completionHandler)
    }
    
    func getAllListRecipesFromLibrary(_ completionHandler: @escaping (APIResult<Any>) -> Void)
    {
        libraryService.getAllRecipesFromLibrary(completionHandler)
    }
    
    func searchRecipesInLibrary(title: String, completionHandler: @escaping (APIResult<Any>) -> Void)
    {
        libraryService.searchRecipesInLibrary(title: title, completionHandler: completionHandler)
    }
}
