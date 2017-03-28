//
//  RecipeEntity+CoreDataProperties.swift
//  AppForPulse
//
//  Created by Ivashin Dmitry on 3/28/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import Foundation
import CoreData


extension RecipeEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecipeEntity> {
        return NSFetchRequest<RecipeEntity>(entityName: "RecipeEntity");
    }

    @NSManaged public var deepLink: String?
    @NSManaged public var details: String?
    @NSManaged public var image: NSData?
    @NSManaged public var imageThumbnail: String?
    @NSManaged public var title: String?

}
