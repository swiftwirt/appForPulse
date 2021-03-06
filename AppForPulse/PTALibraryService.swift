//
//  PTARecipeService.swift
//  AppForPulse
//
//  Created by Ivashin Dmitry on 3/27/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import MagicalRecord
import SDWebImage

class PTALibraryService {
    
    func updateLibraryWith(_ dictionary: [String: Any])
    {
        let predicate = NSPredicate(format: "title == %@", dictionary["title"] as! String) // TODO: See if it works
        guard let recipes = RecipeEntity.mr_findAll(with: predicate) as? [RecipeEntity], recipes.count > 0 else {
            let recipe = RecipeEntity.mr_createEntity()
            recipe?.deepLink = dictionary["href"] as! String?
            recipe?.details = dictionary["ingredients"] as! String?
            recipe?.imageThumbnail = dictionary["thumbnail"] as! String?
            recipe?.title = (dictionary["title"] as! String?)?.replacingOccurrences(of: "\n", with: "")
            
            let imageURL = URL(string: dictionary["thumbnail"] as! String)
            let downloader = SDWebImageDownloader.shared()
            downloader.downloadImage(with: imageURL, options: .highPriority, progress: nil, completed: { (image, data, error, completed) in
                if image != nil && completed {
                    recipe?.image = UIImagePNGRepresentation(image!) as NSData?
                }
            })
            return
        }
    }
}
