//
//  ImageMetaData+CoreDataProperties.swift
//  FIT5140-Maybe the last Version
//
//  Created by Burns on 3/9/19.
//  Copyright © 2019 Burns. All rights reserved.
//
//

import Foundation
import CoreData


extension ImageMetaData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageMetaData> {
        return NSFetchRequest<ImageMetaData>(entityName: "ImageMetaData")
    }

    @NSManaged public var filename: String?
    @NSManaged public var imageoflocation: LocationsMetaData?

}
