//
//  LocationTableViewController.swift
//  FIT5140-Maybe the last Version
//
//  Created by Burns on 2/9/19.
//  Copyright © 2019 Burns. All rights reserved.
//

import UIKit
import MapKit

class LocationTableViewController: UITableViewController, NewLocationDelegate {

    var viewController: ViewController?
    var locationList = [LocationAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Location 1
        var location = LocationAnnotation(newTitle: "Melbourne Museum", newSubtitle: "A natural and cultural history museum located in the Carlton Gardens in Melbourne", lat: -37.8033, long: 144.9717)
        locationList.append(location)
        viewController?.mapView.addAnnotation(location)
        
        //Location 2
        location = LocationAnnotation(newTitle: "Cooks' Cottage", newSubtitle: "Previously known as Captain Cook's Cottage", lat: -37.8145, long: 144.9794)
        locationList.append(location)
        viewController?.mapView.addAnnotation(location)
        
        //Location 3
        location = LocationAnnotation(newTitle: "Old Melbourne Gaol", newSubtitle: "A museum and former prison located in Russell Street", lat: -37.8078, long: 144.9653)
        locationList.append(location)
        viewController?.mapView.addAnnotation(location)
        
        //Location 4
        location = LocationAnnotation(newTitle: "Melbourne Tram Museum", newSubtitle: "Explore the history of trams and the contribution they have made to the development of our city at an authentic heritage location", lat: -37.8273, long: 145.0247)
        locationList.append(location)
        viewController?.mapView.addAnnotation(location)
        
        //Lcocation 5
        location = LocationAnnotation(newTitle: "Flinders Street Railway Station", newSubtitle: "A railway station on the corner of Flinders and Swanston Streets i", lat: -37.8183, long: 144.9671)
        locationList.append(location)
        viewController?.mapView.addAnnotation(location)
        
        //Location 6
        location = LocationAnnotation(newTitle: "St. Michael's Uniting Church", newSubtitle: "The Church became a congregation of the Uniting Church in Australia at its inception in 1977.", lat: -37.8143, long: 144.9693)
        locationList.append(location)
        viewController?.mapView.addAnnotation(location)
        
        //Location 7
        location = LocationAnnotation(newTitle: "The Old Treasury Building", newSubtitle: "Was once home to the Treasury Department of the Government of Victoria, but is now a museum of Melbourne history, known as the Old Treasury Building. ", lat: -37.8132, long: 144.9744)
        locationList.append(location)
        viewController?.mapView.addAnnotation(location)
        
        //Location 8
        location = LocationAnnotation(newTitle: "Koorie Heritage Trust Cultural Centre", newSubtitle: "A bold statement and significant recognition of our shared history and the importance of Koorie peoples and communities as part of a broader 21st century community.", lat: -37.8134, long: 144.9539)
        locationList.append(location)
        viewController?.mapView.addAnnotation(location)
        
        //Location 9
        location = LocationAnnotation(newTitle: "Shrine of Remembrance", newSubtitle: "An iconic landmark honouring the service of Australian men and women in war and peacekeeping.", lat: -37.8305, long: 144.9734)
        locationList.append(location)
        viewController?.mapView.addAnnotation(location)
        
        //Location 10
        location = LocationAnnotation(newTitle: "Chinese Museum", newSubtitle: "AThe Chinese Museum or Museum of Chinese Australian History is an Australian history museum located in Melbourne's Chinatown.", lat: -37.8108, long: 144.9691)
        locationList.append(location)
        viewController?.mapView.addAnnotation(location)
        
        //Location 11
        location = LocationAnnotation(newTitle: "Polly Woodside", newSubtitle: "a Belfast-built, three-masted, iron-hulled barque, preserved in Melbourne, Victoria, and forming the central feature of the South Wharf precinct.", lat: -37.8245, long: 144.9536)
        locationList.append(location)
        viewController?.mapView.addAnnotation(location)
        
        //Location 12
        location = LocationAnnotation(newTitle: "Manchester Unity Building", newSubtitle: "Admire the Art Deco architecture and elegant arcade of this heritage-listed landmark on the corner of Collins and Swanston Streets.", lat: -37.8154, long: 144.9663)
        locationList.append(location)
        viewController?.mapView.addAnnotation(location)
        
        //Location 13
        location = LocationAnnotation(newTitle: "Her Majesty's Theatre", newSubtitle: "Her Majesty's Theatre is a 1,700 seat theatre in Melbourne's East End Theatre District, Australia. Built in 1886.", lat: -37.8110, long: 144.9696)
        locationList.append(location)
        viewController?.mapView.addAnnotation(location)
        
        //Location 14
        location = LocationAnnotation(newTitle: "Victoria Police Museum", newSubtitle: "A law enforcement museum operated by the Historical Services Unit within the Media and Corporate Communications Department of Victoria Police. ", lat: -37.8223, long: 144.9542)
        locationList.append(location)
        viewController?.mapView.addAnnotation(location)
        
        //Location 15
        location = LocationAnnotation(newTitle: "The Scots' Church", newSubtitle: "It was the first Presbyterian church to be built in the Port Phillip District and is located on Collins Street.", lat: -37.8146, long: 144.9685)
        locationList.append(location)
        viewController?.mapView.addAnnotation(location)
        
    }
    
    
    //add the annotation into map
    func locationAnnotationAdded(annotation: LocationAnnotation)
    {
        locationList.append(annotation)
        viewController?.mapView.addAnnotation(annotation)
        tableView.insertRows(at: [IndexPath(row:locationList.count - 1, section: 0)], with: .automatic)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return locationList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
        let annotation = self.locationList[indexPath.row]
        
        //set text into the table cell
        cell.textLabel?.text = annotation.title
        cell.detailTextLabel?.text = annotation.subtitle

        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewController?.focusOn(annotation:self.locationList[indexPath.row])
        // Return false if you do not want the specified item to be editable
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            locationList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addLocationSegue"{
            let controller = segue.destination as! NewLocationViewController
            controller.delegate = self
        }
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    
}


