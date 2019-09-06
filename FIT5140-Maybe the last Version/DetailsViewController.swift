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
        
        // set every datail in each field to show to user.
        nameViewField?.text = locationDetails?.name
        descriptionViewField?.text = locationDetails?.introduction
        let newCenterLocation = CLLocation(latitude: locationDetails!.latitude, longitude: locationDetails!.longitude )
        let currentAnnotation = LocationAnnotation.init(newTitle: locationDetails!.name!, newSubtitle: locationDetails!.introduction!, lat: locationDetails!.latitude, long: locationDetails!.longitude, icon: locationDetails!.iconName!, image:
            locationDetails!.photoName!)
        
        //set image from gallery or assets
        loadImageData(fileName: locationDetails!.photoName!)
        
        //show a small map to user to show the location of the sight
        centerMapLocation(location: newCenterLocation)
        mapLocationView.addAnnotation(currentAnnotation)
        
        // Do any additional setup after loading the view.
    }
    
    //judge whether the image from gallery or assets and pick it from there which searched by their name.
    func loadImageData(fileName: String) {
        if isPurnInt(string: fileName){
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
            let pathComponent = path.appendingPathComponent(fileName)
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: pathComponent){
                imageViewField.image = UIImage(contentsOfFile: pathComponent)
            }
        } else {
            imageViewField.image = UIImage(named: locationDetails!.photoName!)
        }
    }
    
    //set the small map center as the location
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
    
    func isPurnInt(string: String) -> Bool {
        let scan: Scanner = Scanner(string: string)
        var val:Int = 0
        return scan.scanInt(&val) && scan.isAtEnd
    }

}

