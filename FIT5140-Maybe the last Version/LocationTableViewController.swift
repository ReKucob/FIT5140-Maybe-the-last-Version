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


