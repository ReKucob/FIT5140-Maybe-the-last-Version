//
//  EditLocationViewController.swift
//  FIT5140-Maybe the last Version
//
//  Created by Burns on 6/9/19.
//  Copyright © 2019 Burns. All rights reserved.
//

import UIKit

class EditLocationViewController: UIViewController, DatabaseListener {
   
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
    }

    @IBOutlet weak var EditIconField: UISegmentedControl!
    @IBOutlet weak var EditLongitudeField: UITextField!
    @IBOutlet weak var EditLatitudeField: UITextField!
    @IBOutlet weak var EditNameField: UITextField!
    @IBOutlet weak var EditDescriptionField: UITextField!
    @IBAction func undoAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    @IBAction func saveNew(_ sender: Any) {
    }
    
    @IBAction func currentPoint(_ sender: Any) {
//        if let currentLocation = currentLocation{
//            EditLatitudeField.text = "\(currentLocation.latitude)"
//            EditLongitudeField.text = "\(currentLocation.longitude)"
//        }
//        else {
//            let alertController = UIAlertController(title: "Location Not Found", message: "The Loction has not been determined yet.", preferredStyle: .alert)
//
//            alertController.addAction(UIAlertAction(title:"Dismiss", style: .default, handler: nil))
//            present(alertController,animated: true, completion: nil)
//        }
    }
    
    @IBAction func EditPhoto(_ sender: Any) {
//        let controller = UIImagePickerController()
//        if UIImagePickerController.isSourceTypeAvailable(.camera){
//            controller.sourceType = .camera
//        }
//        else
//        {
//            controller.sourceType = .photoLibrary
//        }
//
//        controller.allowsEditing = false
//        controller.delegate = self
//        self.present(controller, animated: true, completion: nil)
    }
    @IBOutlet weak var EditImageField: UIImageView!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
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
    
    
}
