//
//  EditLocationViewController.swift
//  FIT5140-Maybe the last Version
//
//  Created by Burns on 6/9/19.
//  Copyright © 2019 Burns. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class EditLocationViewController: UIViewController, DatabaseListener, CLLocationManagerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
   
    weak var databaseController: DatabaseProtocol?
    
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

    var editLocations: LocationInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EditNameField.text! = editLocations!.name!
        EditDescriptionField.text! = editLocations!.introduction!
        EditLatitudeField.text! = String(format: "%f", editLocations!.latitude)
        EditLongitudeField.text! = String(format: "%f", editLocations!.longitude)
        EditIconField.selectedSegmentIndex = selectSegment(icon: editLocations!.iconName!)
        EditImageField.image = UIImage(named: editLocations!.photoName!)
        
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        databaseController = appDelegate.databaseController
        managedObjectContext = appDelegate.persistantContainer?.viewContext
        
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 10
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation])
    {
        let location = locations.last!
        currentLocation = location.coordinate
    }
    
    
    @IBOutlet weak var EditIconField: UISegmentedControl!
    @IBOutlet weak var EditLongitudeField: UITextField!
    @IBOutlet weak var EditLatitudeField: UITextField!
    @IBOutlet weak var EditNameField: UITextField!
    @IBOutlet weak var EditDescriptionField: UITextField!
    
    var currentLocation: CLLocationCoordinate2D?
    var locationManager: CLLocationManager = CLLocationManager()
    var managedObjectContext: NSManagedObjectContext?
    
    @IBAction func undoAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    @IBAction func saveNew(_ sender: Any) {
        if EditNameField.text!.isEmpty || EditDescriptionField.text!.isEmpty || EditLatitudeField.text!.isEmpty || EditLongitudeField.text!.isEmpty
        {
            let alertController = UIAlertController(title: "Empty Alert!", message: "You can not leave any space in the text field.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title:"Dismiss", style: .default, handler: nil))
            present(alertController,animated: true, completion: nil)
        }
        else
        {
            guard let image = EditImageField.image
                
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
            
            
            let _ = databaseController!.addLocationInfo(name: EditNameField.text!, introduction: EditDescriptionField.text!, latitude: Double(EditLatitudeField.text!)!, longitude: Double(EditLongitudeField.text!)!, iconName: segmentImageNameShift(currentSegement: EditIconField.selectedSegmentIndex), photoName: "\(date)")
            navigationController?.popViewController(animated: true)
            
        }
        }
    
    @IBAction func currentPoint(_ sender: Any) {
        if let currentLocation = currentLocation{
            EditLatitudeField.text = "\(currentLocation.latitude)"
            EditLongitudeField.text = "\(currentLocation.longitude)"
        }
        else
        {
            let alertController = UIAlertController(title: "Location Not Found", message: "The Loction has not been determined yet.", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title:"Dismiss", style: .default, handler: nil))
            present(alertController,animated: true, completion: nil)
        }
    }
    
    @IBAction func EditPhoto(_ sender: Any) {
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
    @IBOutlet weak var EditImageField: UIImageView!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    //translate the segment name to different segment numbers
    func selectSegment(icon: String) -> Int{
        let segmentSelected = icon
        
        switch segmentSelected {
        case "Archiecture":
            return 0
        case "Cabin":
            return 1
        case "Church":
            return 2
        case "Museum":
            return 3
        case "Shrine":
            return 4
        case "Station":
            return 5
        default:
            return 0
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]){
        if let pickedImage = info[.originalImage] as? UIImage{
            EditImageField.image = pickedImage
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

}

