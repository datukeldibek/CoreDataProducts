//
//  CoreDataProduct+CoreDataProperties.swift
//  
//
//  Created by Jarae on 6/6/23.
//
//

import Foundation
import CoreData


extension CoreDataProduct {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataProduct> {
        return NSFetchRequest<CoreDataProduct>(entityName: "CoreDataProduct")
    }

    @NSManaged public var name: String?
    @NSManaged public var price: String?
    @NSManaged public var productDescription: String?
    @NSManaged public var brand: String?
    @NSManaged public var category: String?

}
