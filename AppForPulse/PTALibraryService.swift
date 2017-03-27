//
//  PTARecipeService.swift
//  AppForPulse
//
//  Created by Ivashin Dmitry on 3/27/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import MagicalRecord

class PTALibraryService {
    
    func getAllRecipesFromLibrary(_ completionHandler: @escaping (APIResult<Any>) -> Void)
    {
        guard let success = RecipeEntity.mr_findAllSorted(by: "title", ascending: true) as? [RecipeEntity] else { completionHandler(APIResult.failure(fatalError() as! Error)) } //TODO: fix that
        completionHandler(APIResult.success(success))
    }
    
    func searchRecipesInLibrary(title: String, completionHandler: @escaping (APIResult<Any>) -> Void)
    {
        let predicate = NSPredicate(format: "ANY title CONTAINS[c] %@", title)
        guard let success = RecipeEntity.mr_findAll(with: predicate) as? [RecipeEntity] else { completionHandler(APIResult.failure(fatalError() as! Error)) } //TODO: fix that
        completionHandler(APIResult.success(success))
    }
    
    func updateLibraryWith(_ recipeInfo: RecipeInfo)
    {
        let predicate = NSPredicate(format: "title == %@", recipeInfo.title!)// TODO: Remove force unwrapping
        guard let _ = RecipeEntity.mr_findAll(with: predicate) as? [RecipeEntity] else {
            let recipe = RecipeEntity.mr_createEntity()
            recipe?.title = recipeInfo.title
            recipe?.deepLink = recipeInfo.deepLink
            recipe?.details = recipeInfo.details
            recipe?.imageThumbnail = recipeInfo.imageThumbnail
            recipe?.image = recipeInfo.image
            return
        }
    }
}