//
//  Trip+CoreDataClass.swift
//  Travelogue
//
//  Created by Clayton Cornett on 12/4/19.
//  Copyright © 2019 Clayton Cornett. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(Trip)
public class Trip: NSManagedObject {
    
    var tripEntries: [Entry]? {
        return self.entry?.array as? [Entry]
    }
    
    convenience init?(name: String?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate  //UIKit is needed to access UIApplication
        guard let managedContext = appDelegate?.persistentContainer.viewContext,
            let name = name, name != "" else {
                return nil
        }
        self.init(entity: Trip.entity(), insertInto: managedContext)
        self.name = name
}
}
