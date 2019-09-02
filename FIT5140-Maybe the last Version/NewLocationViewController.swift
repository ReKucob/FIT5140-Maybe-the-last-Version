//
//  NewLocationViewController.swift
//  FIT5140-Maybe the last Version
//
//  Created by Burns on 2/9/19.
//  Copyright © 2019 Burns. All rights reserved.
//

import UIKit
import MapKit

protocol NewLocationDelegate{
    func locationAnnotationAdded(annotation: LocationAnnotation)
}

class NewLocationViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var titleTextView: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var latitudeTextView: UITextField!
    @IBOutlet weak var longitudeTextView: UITextField!
    
    var delegate: NewLocationDelegate?
    var locationManager: CLLocationManager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 10
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManager.startUpdatingLocation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation])
    {
        let location = locations.last!
        currentLocation = location.coordinate
    }
    
    
    @IBAction func useCurrentLocation(_ sender: Any) {
        if let currentLocation = currentLocation{
            latitudeTextView.text = "\(currentLocation.latitude)"
            longitudeTextView.text = "\(currentLocation.longitude)"
        }
        else {
            let alertController = UIAlertController(title: "Location Not Found", message: "The Loction has not been determined yet.", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title:"Dismiss", style: .default, handler: nil))
            present(alertController,animated: true, completion: nil)
        }
        
    }
    
    @IBAction func saveLocation(_ sender: Any) {
        if titleTextView.text!.isEmpty || descriptionTextField.text!.isEmpty || latitudeTextView.text!.isEmpty || longitudeTextView.text!.isEmpty
        {
            let alertController = UIAlertController(title: "Empty Alert!", message: "You can not leave any space in the text field.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title:"Dismiss", style: .default, handler: nil))
            present(alertController,animated: true, completion: nil)
        }
        else
        {
            let location = LocationAnnotation(newTitle: titleTextView.text!, newSubtitle: descriptionTextField.text!, lat: Double(latitudeTextView.text!)!, long: Double(longitudeTextView.text!)!)
            delegate?.locationAnnotationAdded(annotation: location)
            navigationController?.popViewController(animated: true)
            
        }
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
}

