//
//  Entry+CoreDataProperties.swift
//  Travelogue
//
//  Created by Clayton Cornett on 12/3/19.
//  Copyright © 2019 Clayton Cornett. All rights reserved.
//
//

import Foundation
import CoreData


extension Entry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest<Entry>(entityName: "Entry")
    }

    @NSManaged public var body: String?
    @NSManaged public var rawAddDate: NSDate?
    @NSManaged public var rawImage: NSData?
    @NSManaged public var title: String?
    @NSManaged public var trip: Trip?

}
