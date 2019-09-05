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

class NewLocationViewController: UIViewController, CLLocationManagerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, DatabaseListener {
   
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
    }
    
    var historicalLocation: [NSManagedObject] = []
    var managedObjectContext: NSManagedObjectContext?
    
    @IBOutlet weak var titleTextView: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var latitudeTextView: UITextField!
    @IBOutlet weak var longitudeTextView: UITextField!
    @IBOutlet weak var iconSegmented: UISegmentedControl!
    @IBOutlet weak var imageViewField: UIImageView!
    
    
    var delegate: NewLocationDelegate?
    var locationManager: CLLocationManager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D?
    
    weak var databaseController: DatabaseProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        databaseController = appDelegate.databaseController
        managedObjectContext = appDelegate.persistantContainer?.viewContext
        
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 10
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        // Do any additional setup after loading the view.
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
            /*self.save(locationName: titleTextView.text!, locationDescription: descriptionTextField.text!, latitude: Double(latitudeTextView.text!)!, Longitude: Double(longitudeTextView.text!)!)
            */
            
            guard let image = imageViewField.image
            
            else{
                displayMessage("Cannot save until a photo has been taken!", "Error")
                return
            }
            
            let date = UInt(Date().timeIntervalSince1970)
            var data = Data()
            data = image.jpegData(compressionQuality: 0.8)!
            
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
            let url = NSURL(fileURLWithPath: path)
            
            if let pathComponent = url.appendingPathComponent("\(date)"){
                let filePath = pathComponent.path
                let fileManager = FileManager.default
                fileManager.createFile(atPath: filePath, contents: data, attributes: nil)
            }
            
            let newImage = NSEntityDescription.insertNewObject(forEntityName: "LocationInfo", into: managedObjectContext!) as! LocationInfo
            newImage.photoName = "\(date)"
            
            let _ = databaseController!.addLocationInfo(name: titleTextView.text!, introduction: descriptionTextField.text!, latitude: Double(latitudeTextView.text!)!, longitude: Double(longitudeTextView.text!)!, iconName: segmentImageNameShift(currentSegement: iconSegmented.selectedSegmentIndex), photoName: "\(date)")
            navigationController?.popViewController(animated: true)
 
        }
    }
    
    func segmentImageNameShift(currentSegement: Int) -> String{
        let segmentSelected = currentSegement
        
        switch segmentSelected {
        case 0:
            return "Archiecture"
        case 1:
            return "Cabin"
        case 2:
            return "Church"
        case 3:
            return "Museum"
        case 4:
            return "Shrine"
        case 5:
            return "Station"
        default:
            return "Archiecture"
        }
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        let controller = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            controller.sourceType = .camera
        }
        else
        {
            controller.sourceType = .photoLibrary
        }
        
        controller.allowsEditing = false
        controller.delegate = self
        self.present(controller, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]){
        if let pickedImage = info[.originalImage] as? UIImage{
            imageViewField.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        displayMessage("There was an error in getting the image", "Error")
        
    }
    
    
    func displayMessage(_ message: String, _ title: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    /*func save(locationName: String, locationDescription: String, latitude: Double, Longitude: Double)
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
 */
}

