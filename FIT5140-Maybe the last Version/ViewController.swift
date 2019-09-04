//
//  ViewController.swift
//  FIT5140-Maybe the last Version
//
//  Created by Burns on 2/9/19.
//  Copyright © 2019 Burns. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, DatabaseListener {

    var locationList: [LocationInfo] = []
    weak var databaseController: DatabaseProtocol?
    
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        databaseController = appDelegate.databaseController
        
        centerMapLocation(location: initialLocation)
        
        
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

    
    
    let initialLocation = CLLocation(latitude: -37.8124, longitude: 144.9623)
    
    //set the distance for the view
    let regionRadius:CLLocationDistance = 1000
    
    //This function is used to set the initial map view when use open the app.
    func centerMapLocation(location:CLLocation){
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func focusOn(annotation: MKAnnotation){
        mapView.selectAnnotation(annotation, animated: true)
        let newCenter = MKCoordinateRegion(center: annotation.coordinate,latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(newCenter, animated: true)
    }

   
    

}

