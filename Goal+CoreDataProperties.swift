//
//  Goal+CoreDataProperties.swift
//  beltProj
//
//  Created by Lu Yu on 7/25/17.
//  Copyright © 2017 Lu Yu. All rights reserved.
//

import Foundation
import CoreData


extension Goal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal> {
        return NSFetchRequest<Goal>(entityName: "Goal")
    }

    @NSManaged public var ttl: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var cmp: Bool

}
