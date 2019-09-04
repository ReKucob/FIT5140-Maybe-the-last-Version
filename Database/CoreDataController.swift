//
//  CoreDataController.swift
//  FIT5140-Maybe the last Version
//
//  Created by Burns on 4/9/19.
//  Copyright © 2019 Burns. All rights reserved.
//

import UIKit
import CoreData

class CoreDataController: NSObject, DatabaseProtocol, NSFetchedResultsControllerDelegate {
    

    let DEFAULT_LOCATION_INFO = "Default LocationInfo"
    var listeners = MulticastDelegate<DatabaseListener>()
    var persistantContainer: NSPersistentContainer
    
    
    var locationInfoFetchedRsultsController: NSFetchedResultsController<LocationInfo>?
    
    override init() {
        persistantContainer = NSPersistentContainer(name:"MapModel")
        persistantContainer.loadPersistentStores(){(description,error) in
            if let error = error{
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
    
    super.init()
    
        if fetchLocationInfo().count == 0 {
    createDefaultEntries()
    }
    
}
    func saveContext(){
        if persistantContainer.viewContext.hasChanges{
            do{
                try persistantContainer.viewContext.save()
            }
            catch{
                fatalError("Failed to save to Core Data: \(error)")
            }
        }
    }
    
    func addLocationInfo(name: String, introduction: String, latitude: Double, longitude: Double, iconName: String, photoName: String) {
        let info = NSEntityDescription.insertNewObject(forEntityName: "LocationInfo", into: persistantContainer.viewContext) as! LocationInfo
        
        info.name = name
        info.introduction = introduction
        info.latitude = latitude
        info.longitude = longitude
        info.iconName = iconName
        info.photoName = photoName
        
        saveContext()
    }
    
    
    func deleteLocationInfo(locationInfo: LocationInfo) {
        persistantContainer.viewContext.delete(locationInfo)
        saveContext()
    }
    
    func addListener(listener: DatabaseListener) {
        listeners.addDelegate(listener)
        
        if listener.listenerType == ListenerType.locationinfo || listener.listenerType == ListenerType.all{
            listener.onMapModelChange(change: .update, historicals: fetchLocationInfo())
        }
    }
    
    func removeListener(listener: DatabaseListener) {
        listeners.removeDelegate(listener)
    }
    
    func fetchLocationInfo() -> [LocationInfo]{
        if locationInfoFetchedRsultsController == nil{
            let fetchRquest: NSFetchRequest<LocationInfo> = LocationInfo.fetchRequest()
            let nameSortDescriptor = NSSortDescriptor(key:"name", ascending: true)
            fetchRquest.sortDescriptors = [nameSortDescriptor]
            locationInfoFetchedRsultsController = NSFetchedResultsController<LocationInfo>(fetchRequest: fetchRquest, managedObjectContext: persistantContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
            locationInfoFetchedRsultsController?.delegate = self
            
            do{
                try locationInfoFetchedRsultsController?.performFetch()
            }
            catch{
                print("Fetch Request failed: \(error)")
            }
            
        }
        
        var historicals = [LocationInfo]()
        if locationInfoFetchedRsultsController?.fetchedObjects != nil{
            historicals = (locationInfoFetchedRsultsController?.fetchedObjects)!
        }
        
        return historicals
    }
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if controller == locationInfoFetchedRsultsController{
            listeners.invoke{
                (listener) in
                if listener.listenerType == ListenerType.locationinfo || listener.listenerType == ListenerType.all{
                    listener.onMapModelChange(change: .update, historicals: fetchLocationInfo())
                }            }
        }
        
    }
    
    func createDefaultEntries(){
        let _ = addLocationInfo(name: "Melbourne Museum", introduction: "A natural and cultural history museum located in the Carlton Gardens in Melbourne", latitude: -37.8033, longitude: 144.9717, iconName: "Museum", photoName: "nil")
        let _ = addLocationInfo(name: "Cooks' Cottage", introduction: "Previously known as Captain Cook's Cottage", latitude: -37.8145, longitude: 144.9794, iconName: "Cabin", photoName: "nil")
        let _ = addLocationInfo(name: "Old Melbourne Gaol", introduction: "A museum and former prison located in Russell Street", latitude: -37.8078, longitude: 144.9653, iconName: "Architecture", photoName: "nil")
        let _ = addLocationInfo(name: "Melbourne Tram Museum", introduction: "Explore the history of trams and the contribution they have made to the development of our city at an authentic heritage location", latitude: -37.8273, longitude: 145.0247, iconName: "Museum", photoName: "nil")
        let _ = addLocationInfo(name: "Flinders Street Railway Station", introduction: "A railway station on the corner of Flinders and Swanston Streets.", latitude: -37.8183, longitude: 144.9671, iconName: "Station", photoName: "nil")
        let _ = addLocationInfo(name: "St. Michael's Uniting Church", introduction: "The Church became a congregation of the Uniting Church in Australia at its inception in 1977.", latitude: -37.8143, longitude: 144.9693, iconName: "Church", photoName: "nil")
        let _ = addLocationInfo(name: "The Old Treasury Building", introduction: "Was once home to the Treasury Department of the Government of Victoria, but is now a museum of Melbourne history, known as the Old Treasury Building. ", latitude: -37.8132, longitude: 144.9744, iconName: "Architecture", photoName: "nil")
        let _ = addLocationInfo(name: "Koorie Heritage Trust Cultural Centre", introduction: "A bold statement and significant recognition of our shared history and the importance of Koorie peoples and communities as part of a broader 21st century community.", latitude: -37.8134, longitude: 144.9539, iconName: "Museum", photoName: "nil")
        let _ = addLocationInfo(name: "Shrine of Remembrance", introduction: "An iconic landmark honouring the service of Australian men and women in war and peacekeeping.", latitude: -37.8305, longitude: 144.9734, iconName: "Shrine", photoName: "nil")
        let _ = addLocationInfo(name: "Chinese Museum", introduction: "AThe Chinese Museum or Museum of Chinese Australian History is an Australian history museum located in Melbourne's Chinatown.", latitude: -37.8108, longitude: 144.9691, iconName: "Museum", photoName: "nil")
        let _ = addLocationInfo(name: "Polly Woodside", introduction: "a Belfast-built, three-masted, iron-hulled barque, preserved in Melbourne, Victoria, and forming the central feature of the South Wharf precinct.", latitude: -37.8245, longitude: 144.9536, iconName: "Cabin", photoName: "nil")
        let _ = addLocationInfo(name: "Manchester Unity Building", introduction: "Admire the Art Deco architecture and elegant arcade of this heritage-listed landmark on the corner of Collins and Swanston Streets.", latitude: -37.8154, longitude: 144.9663, iconName: "Architecture", photoName: "nil")
        let _ = addLocationInfo(name: "Her Majesty's Theatre", introduction: "Her Majesty's Theatre is a 1,700 seat theatre in Melbourne's East End Theatre District, Australia. Built in 1886.", latitude: -37.8110, longitude: 144.9696, iconName: "Museum", photoName: "nil")
        let _ = addLocationInfo(name: "Victoria Police Museum", introduction: "A law enforcement museum operated by the Historical Services Unit within the Media and Corporate Communications Department of Victoria Police. ", latitude: -37.8223, longitude: 144.9542, iconName: "Museum", photoName: "nil")
        let _ = addLocationInfo(name: "The Scots' Church", introduction: "It was the first Presbyterian church to be built in the Port Phillip District and is located on Collins Street.", latitude: -37.8146, longitude: 144.9685, iconName: "Church", photoName: "nil")
        
    }
}
