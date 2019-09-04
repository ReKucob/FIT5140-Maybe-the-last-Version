//
//  LocationInfo+CoreDataProperties.swift
//  FIT5140-Maybe the last Version
//
//  Created by Burns on 4/9/19.
//  Copyright © 2019 Burns. All rights reserved.
//
//

import Foundation
import CoreData


extension LocationInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocationInfo> {
        return NSFetchRequest<LocationInfo>(entityName: "LocationInfo")
    }

    @NSManaged public var name: String?
    @NSManaged public var introduction: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var iconName: String?
    @NSManaged public var photoName: String?

}
