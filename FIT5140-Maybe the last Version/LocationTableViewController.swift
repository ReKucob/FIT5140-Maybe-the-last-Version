//
//  LocationTableViewController.swift
//  FIT5140-Maybe the last Version
//
//  Created by Burns on 2/9/19.
//  Copyright © 2019 Burns. All rights reserved.
//

//Search function in this page come from this website: https://www.raywenderlich.com/472-uisearchcontroller-tutorial-getting-started

import UIKit
import MapKit
import CoreData

class LocationTableViewController: UITableViewController, DatabaseListener, CLLocationManagerDelegate{
    

    var locationList: [LocationInfo] = []
    var filterLocations: [LocationInfo] = []
    var viewController: ViewController?
    weak var databaseController: DatabaseProtocol?
  
    //add a seachcontroller foe future search
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        databaseController = appDelegate.databaseController
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Locations"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        databaseController?.addListener(listener: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        databaseController?.removeListener(listener: self)
    }
    
    var listenerType = ListenerType.locationinfo
    
    func onMapModelChange(change: DatabaseChange, historicals: [LocationInfo]) {
        locationList = historicals
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filterLocations.count
        }
        
        return locationList.count
        // #warning Incomplete implementation, return the number of rows
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //find the next cell by identifier.
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as! LocationTableViewCell
        if isFiltering(){
           locationList[indexPath.row] = filterLocations[indexPath.row]
        }
        //set text into the table cell
        cell.titleLabel?.text = locationList[indexPath.row].name
        cell.subtitleLabel?.text = locationList[indexPath.row].iconName
        cell.imageLabel?.image = UIImage(named: locationList[indexPath.row].iconName!)
        return cell
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
    
    //when user click the 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView!.deselectRow(at: indexPath, animated: true)
        let sight = self.locationList[indexPath.row]
        self.performSegue(withIdentifier: "showDetailSegue", sender: sight)
    }
    

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            databaseController?.deleteLocationInfo(locationInfo: locationList[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "showDetailSegue" {
        let controller = segue.destination as! DetailsViewController
        controller.locationDetails = sender as? LocationInfo
        }
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }

    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filterLocations = locationList.filter({( location : LocationInfo) -> Bool in
            return (location.name?.lowercased().contains(searchText.lowercased()))!
        })
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
}
extension LocationTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
    filterContentForSearchText(searchController.searchBar.text!)
    }
}

