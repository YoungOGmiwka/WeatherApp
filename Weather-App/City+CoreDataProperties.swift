//
//  City+CoreDataProperties.swift
//  
//
//  Created by Михаил on 27.09.2023.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var attribute: NSObject?

}
