//
//  DetailsViewController.swift
//  FIT5140-Maybe the last Version
//
//  Created by Burns on 4/9/19.
//  Copyright © 2019 Burns. All rights reserved.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var nameViewField: UILabel!
    @IBOutlet weak var imageViewField: UIImageView!
    @IBOutlet weak var descriptionViewField: UILabel!
    @IBOutlet weak var mapLocationView: MKMapView!
    
    var locationDetails: LocationInfo?
    var viewController: ViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameViewField?.text = locationDetails?.name
        descriptionViewField?.text = locationDetails?.introduction
        let newCenterLocation = CLLocation(latitude: locationDetails!.latitude, longitude: locationDetails!.longitude )
        let currentAnnotation = LocationAnnotation.init(newTitle: locationDetails!.name!, newSubtitle: locationDetails!.introduction!, lat: locationDetails!.latitude, long: locationDetails!.longitude, icon: locationDetails!.iconName!, image:
            locationDetails!.photoName!)
        
        
        imageViewField.image = UIImage(named: locationDetails!.photoName!)
        loadImageData(fileName: locationDetails!.photoName!)
        
        
        centerMapLocation(location: newCenterLocation)
        mapLocationView.addAnnotation(currentAnnotation)
        
        // Do any additional setup after loading the view.
    }
    
    func loadImageData(fileName: String) {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let pathComponent = path.appendingPathComponent(fileName)
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: pathComponent){
            imageViewField.image = UIImage(contentsOfFile: pathComponent)
        }
    }
    
    func centerMapLocation(location:CLLocation){
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,latitudinalMeters: 500, longitudinalMeters: 500)
        mapLocationView.setRegion(coordinateRegion, animated: true)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editDetailsSegue" {
            let controller = segue.destination as! EditLocationViewController
            controller.editLocations = locationDetails
        }
    }

}

