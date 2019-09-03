//
//  LocationsMetaData+CoreDataProperties.swift
//  FIT5140-Maybe the last Version
//
//  Created by Burns on 3/9/19.
//  Copyright © 2019 Burns. All rights reserved.
//
//

import Foundation
import CoreData


extension LocationsMetaData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocationsMetaData> {
        return NSFetchRequest<LocationsMetaData>(entityName: "LocationsMetaData")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var locationDescription: String?
    @NSManaged public var locationName: String?
    @NSManaged public var longitude: Double
    @NSManaged public var locationImage: ImageMetaData?

}
