//
//  NewLocationViewController.swift
//  FIT5140-Maybe the last Version
//
//  Created by Burns on 2/9/19.
//  Copyright © 2019 Burns. All rights reserved.
//

import UIKit
import MapKit
import CoreData

protocol NewLocationDelegate{
    func locationAnnotationAdded(annotation: LocationAnnotation)
}

class NewLocationViewController: UIViewController, CLLocationManagerDelegate {
    
    var historicalLocation: [NSManagedObject] = []
    
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
            self.save(locationName: titleTextView.text!, locationDescription: descriptionTextField.text!, latitude: Double(latitudeTextView.text!)!, Longitude: Double(longitudeTextView.text!)!)
            navigationController?.popViewController(animated: true)
            
            /*let location = LocationAnnotation(newTitle: titleTextView.text!, newSubtitle: descriptionTextField.text!, lat: Double(latitudeTextView.text!)!, long: Double(longitudeTextView.text!)!)
            delegate?.locationAnnotationAdded(annotation: location)
            */
            
 
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
    
    func save(locationName: String, locationDescription: String, latitude: Double, Longitude: Double)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntitName: "LocationsMetaData", in: managedContext)!
        
        let historicalLocations = NSManagedObject(entity: entity, insertInto: managedContext)
        
        historicalLocations.setValue(locationName, value(forKeyPath: "locationName"))
        historicalLocations.setValue(locationDescription, value(forKeyPath: "locationDescription"))
        historicalLocations.setValue(latitude, value(forKeyPath: "latitude"))
        historicalLocations.setValue(Longitude, value(forKeyPath: "Longitude"))
        
        
        do{
            try managedContext.save()
            historicalLocation.append(historicalLocations)
        }
        catch let error as NSError {
            print("Cannot save. \(error), \(error.userInfo)")
        }
        
    }
}

