//
//  ViewController.swift
//  FIT5140-Maybe the last Version
//
//  Created by Burns on 2/9/19.
//  Copyright © 2019 Burns. All rights reserved.
//

//This page gets some of codes from this website:
//https://www.raywenderlich.com/548-mapkit-tutorial-getting-started


import UIKit
import MapKit

//main page, contains the mapKit.
class ViewController: UIViewController, DatabaseListener, CLLocationManagerDelegate {

    //use a list to get all core data.
    var locationList: [LocationInfo] = []
    weak var databaseController: DatabaseProtocol?
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        databaseController = appDelegate.databaseController
        
        // set the center area
        centerMapLocation(location: initialLocation)
        mapView.delegate = self
      
        //set geofence here to monitor the move.
        for locations in locationList{
            let centerArea = CLLocationCoordinate2D(latitude: locations.latitude, longitude: locations.longitude)
            let geoLocation = CLCircularRegion(center: centerArea, radius: 500, identifier: locations.name!)
            geoLocation.notifyOnExit = true
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startMonitoring(for: geoLocation)
        }
    }
    
    //popup alert window about geofence
    func locationManager(_ manager: CLLocationManager, didExitRegion: CLRegion) {
        let alert = UIAlertController(title: "Movement Detected!", message: "You have left this historical sight", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //when view ill appear, set what will show on the screen.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        databaseController?.addListener(listener: self)
        
        for location in locationList{
            let sight = LocationAnnotation(newTitle: location.name!, newSubtitle: location.introduction!, lat: location.latitude, long: location.longitude, icon: location.iconName!, image: location.photoName!)
            mapView.addAnnotation(sight)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        databaseController?.removeListener(listener: self)
    }
    
    var listenerType = ListenerType.locationinfo
    
    // use  local list to get the core data from coredata and set in the local list.
    func onMapModelChange(change: DatabaseChange, historicals: [LocationInfo]) {
        locationList = historicals
    }
    
    //Melbourne CBD's location
    let initialLocation = CLLocation(latitude: -37.8124, longitude: 144.9623)
    
    //set the distance for the view
    let regionRadius:CLLocationDistance = 1000
    
    //This function is used to set the initial map view when use open the app.
    func centerMapLocation(location:CLLocation){
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
}

//change the pin style on the screen and make sure whe user click the pin ,it will show different view to user.
extension ViewController: MKMapViewDelegate {
    // 1
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? LocationAnnotation else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero,
                                                         size: CGSize(width: 30, height: 30)))
            mapsButton.setBackgroundImage(UIImage(named: "Architecture"), for: UIControl.State())
            view.rightCalloutAccessoryView = mapsButton
        }
        return view
    }
}
    

   
    



