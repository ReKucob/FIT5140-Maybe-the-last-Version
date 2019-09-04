//
//  DatabaseProtocol.swift
//  FIT5140-Maybe the last Version
//
//  Created by Burns on 4/9/19.
//  Copyright © 2019 Burns. All rights reserved.
//

import Foundation

enum DatabaseChange{
    case add
    case remove
    case update
}

enum ListenerType{
    case locationinfo
    case all
}

protocol DatabaseListener: AnyObject {
    var listenerType: ListenerType{get set}
    func onMapModelChange(change: DatabaseChange, historicals: [LocationInfo])
}

protocol DatabaseProtocol: AnyObject{
   
    
    func addLocationInfo(name: String,introduction: String,latitude: Double,longitude: Double,iconName: String,photoName: String)
    func deleteLocationInfo(locationInfo: LocationInfo)
    func addListener(listener: DatabaseListener)
    func removeListener(listener: DatabaseListener)

}
