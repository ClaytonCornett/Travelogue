//
//  Trip+CoreDataClass.swift
//  Travelogue
//
//  Created by Clayton Cornett on 12/3/19.
//  Copyright © 2019 Clayton Cornett. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Trip)
public class Trip: NSManagedObject {

    
    convenience init?(name: String?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate  //UIKit is needed to access UIApplication
        guard let managedContext = appDelegate?.persistentContainer.viewContext,
            let name = name, name != "" else {
                return nil
        }
        self.init(entity: Category.entity(), insertInto: managedContext)
        self.name = name
}
