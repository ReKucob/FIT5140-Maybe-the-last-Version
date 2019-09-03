//
//  AppDelegate.swift
//  FIT5140-Maybe the last Version
//
//  Created by Burns on 2/9/19.
//  Copyright © 2019 Burns. All rights reserved.
//

import UIKit
import CoreData


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var persistantContainer: NSPersistentContainer?
    var defaultList: [LocationAnnotation] = []

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        persistantContainer = NSPersistentContainer(name:"ImageModel")
        persistantContainer?.loadPersistentStores(){
            (description,error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        
        defaultList = setDefaultLocations()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


    func setDefaultLocations() -> [LocationAnnotation] {
        
        var locations:[LocationAnnotation] = []
        
        //Location 1
        let location1 = LocationAnnotation(newTitle: "Melbourne Museum", newSubtitle: "A natural and cultural history museum located in the Carlton Gardens in Melbourne", lat: -37.8033, long: 144.9717)
        locations.append(location1)
        
        //Location 2
        let location2 = LocationAnnotation(newTitle: "Cooks' Cottage", newSubtitle: "Previously known as Captain Cook's Cottage", lat: -37.8145, long: 144.9794)
        locations.append(location2)
       
        
        //Location 3
        let location3 = LocationAnnotation(newTitle: "Old Melbourne Gaol", newSubtitle: "A museum and former prison located in Russell Street", lat: -37.8078, long: 144.9653)
       locations.append(location3)
        
        //Location 4
        let location4 = LocationAnnotation(newTitle: "Melbourne Tram Museum", newSubtitle: "Explore the history of trams and the contribution they have made to the development of our city at an authentic heritage location", lat: -37.8273, long: 145.0247)
      locations.append(location4)
        
        //Lcocation 5
        let location5 = LocationAnnotation(newTitle: "Flinders Street Railway Station", newSubtitle: "A railway station on the corner of Flinders and Swanston Streets i", lat: -37.8183, long: 144.9671)
       locations.append(location5)
        
        //Location 6
        let location6 = LocationAnnotation(newTitle: "St. Michael's Uniting Church", newSubtitle: "The Church became a congregation of the Uniting Church in Australia at its inception in 1977.", lat: -37.8143, long: 144.9693)
      locations.append(location6)
        
        //Location 7
        let location7 = LocationAnnotation(newTitle: "The Old Treasury Building", newSubtitle: "Was once home to the Treasury Department of the Government of Victoria, but is now a museum of Melbourne history, known as the Old Treasury Building. ", lat: -37.8132, long: 144.9744)
        locations.append(location7)
        
        //Location 8
        let location8 = LocationAnnotation(newTitle: "Koorie Heritage Trust Cultural Centre", newSubtitle: "A bold statement and significant recognition of our shared history and the importance of Koorie peoples and communities as part of a broader 21st century community.", lat: -37.8134, long: 144.9539)
        locations.append(location8)
        
        //Location 9
        let location9 = LocationAnnotation(newTitle: "Shrine of Remembrance", newSubtitle: "An iconic landmark honouring the service of Australian men and women in war and peacekeeping.", lat: -37.8305, long: 144.9734)
       locations.append(location9)
        
        //Location 10
        let location10 = LocationAnnotation(newTitle: "Chinese Museum", newSubtitle: "AThe Chinese Museum or Museum of Chinese Australian History is an Australian history museum located in Melbourne's Chinatown.", lat: -37.8108, long: 144.9691)
        locations.append(location10)
        
        //Location 11
        let location11 = LocationAnnotation(newTitle: "Polly Woodside", newSubtitle: "a Belfast-built, three-masted, iron-hulled barque, preserved in Melbourne, Victoria, and forming the central feature of the South Wharf precinct.", lat: -37.8245, long: 144.9536)
        locations.append(location11)
        
        //Location 12
        let location12 = LocationAnnotation(newTitle: "Manchester Unity Building", newSubtitle: "Admire the Art Deco architecture and elegant arcade of this heritage-listed landmark on the corner of Collins and Swanston Streets.", lat: -37.8154, long: 144.9663)
        locations.append(location12)
        
        //Location 13
        let location13 = LocationAnnotation(newTitle: "Her Majesty's Theatre", newSubtitle: "Her Majesty's Theatre is a 1,700 seat theatre in Melbourne's East End Theatre District, Australia. Built in 1886.", lat: -37.8110, long: 144.9696)
        locations.append(location13)
        
        //Location 14
        let location14 = LocationAnnotation(newTitle: "Victoria Police Museum", newSubtitle: "A law enforcement museum operated by the Historical Services Unit within the Media and Corporate Communications Department of Victoria Police. ", lat: -37.8223, long: 144.9542)
        locations.append(location14)
        
        //Location 15
        let location15 = LocationAnnotation(newTitle: "The Scots' Church", newSubtitle: "It was the first Presbyterian church to be built in the Port Phillip District and is located on Collins Street.", lat: -37.8146, long: 144.9685)
        locations.append(location15)
        
        return locations
    }
    
    
}

