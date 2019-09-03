//
//  DatabaseProtocol.swift
//  FIT5140-Maybe the last Version
//
//  Created by Burns on 3/9/19.
//  Copyright © 2019 Burns. All rights reserved.
//

import Foundation

enum DatabaseChange{
    case add
    case remove
    case update
}

enum ListenerType{
    case image
    case locations
    case all
}

protocol DatabaseListener: AnyObject{
    var listenerType: ListenerType{get set}
    func onImageChange(change: DatabaseChange, imageoflocation: [LocationsMetaData])
    func onLocationChange(change: DatabaseChange, locationImage: [ImageMetaData])
}

protocol DatabaseProtocol: AnyObject {
    var defaultLocation: LocationsMetaData{get}
    
    func addLocation(locationName: String, locationDescription: String, latitude: Double, longitude: Double) -> LocationsMetaData
    
    func addImage(filename: String) -> ImageMetaData
    
    func addImageToLocation(location: LocationsMetaData, image: ImageMetaData) -> Bool
    
    func deleteLocation(location: LocationsMetaData)
    func deleteImage(image: ImageMetaData)
    
    func removeImageFromLocation(location: LocationsMetaData, image: ImageMetaData)
    
    func addListener(listener: DatabaseListener)
    func removeListener(listener: DatabaseListener)
}
