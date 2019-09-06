//
//  LocationAnnotation.swift
//  FIT5140-Maybe the last Version
//
//  Created by Burns on 2/9/19.
//  Copyright © 2019 Burns. All rights reserved.
//
//
//This is the class to set the attributes of annotation which will be used in the ap to show pins.

import UIKit
import MapKit

class LocationAnnotation: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var icon: String?
    var image: String?
    
    init(newTitle: String, newSubtitle: String, lat: Double, long: Double, icon: String, image: String) {
        self.title = newTitle
        self.subtitle = newSubtitle
        coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        self.icon = icon
        self.image = image
    }
}
