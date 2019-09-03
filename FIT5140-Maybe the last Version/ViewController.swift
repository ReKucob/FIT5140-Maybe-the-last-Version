//
//  ViewController.swift
//  FIT5140-Maybe the last Version
//
//  Created by Burns on 2/9/19.
//  Copyright © 2019 Burns. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    var locationList: [LocationAnnotation] = []
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var locationTableView: LocationTableViewController?
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        centerMapLocation(location: initialLocation)
        locationList = appDelegate.defaultList
        
        for location in locationList{
            mapView.addAnnotation(location)
        }
        
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

extension ViewController: MKMapViewDelegate {
    // 1
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? LocationTableViewController else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = (annotation as! MKAnnotation)
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: (annotation as! MKAnnotation), reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
}

