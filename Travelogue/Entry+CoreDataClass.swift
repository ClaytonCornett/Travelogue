//
//  Entry+CoreDataClass.swift
//  Travelogue
//
//  Created by Clayton Cornett on 12/4/19.
//  Copyright © 2019 Clayton Cornett. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(Entry)
public class Entry: NSManagedObject {
    
    var addDate: Date? {
        get {
            return rawAddDate as Date?
        }
        set {
            rawAddDate = newValue as NSDate?
        }
    }
    
    var image: UIImage? {
        get {
            if let imageData = rawImage as Data? {
                return UIImage(data: imageData)
            } else {
                return nil
            }
        }
        set {
            if let image = newValue {
                rawImage = convertImageToNSData(image: image)
            }
        }
    }
    
    convenience init?(title: String, body: String?, image: UIImage?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        // import UIKit is needed to access UIApplication
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext, !title.isEmpty else {
            return nil
        }
        
        self.init(entity: Entry.entity(), insertInto: managedContext)
        self.title = title
        self.body = body
        self.addDate = Date(timeIntervalSinceNow: 0)
        
        if let image = image {
            self.rawImage = convertImageToNSData(image: image)
        }
    }
    
    func convertImageToNSData(image: UIImage) -> NSData? {
        // The image data can be represented as PNG or JPEG data formats.
        // Both ways to format the image data are listed below and the JPEG version is the one being used.
        
        //return image.jpegData(compressionQuality: 1.0) as NSData?
        return processImage(image: image).pngData() as NSData?
    }
    
    // See: https://stackoverflow.com/questions/3554244/uiimagepngrepresentation-issues-images-rotated-by-90-degrees/33311936
    // This function processes the image so that it is oriented correctly when displayed.
    func processImage(image: UIImage) -> UIImage {
        if (image.imageOrientation == .up) {
            return image
        }
        
        UIGraphicsBeginImageContext(image.size)
        
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size), blendMode: .copy, alpha: 1.0)
        let copy = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        guard let unwrappedCopy = copy else {
            return image
        }
        
        return unwrappedCopy
    }
}
