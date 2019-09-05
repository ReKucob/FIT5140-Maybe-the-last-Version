//
//  DetailsViewController.swift
//  FIT5140-Maybe the last Version
//
//  Created by Burns on 4/9/19.
//  Copyright © 2019 Burns. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var nameViewField: UILabel!
    @IBOutlet weak var imageViewField: UIImageView!
    @IBOutlet weak var descriptionViewField: UILabel!

    var locationDetails: LocationInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameViewField?.text = locationDetails?.name
        descriptionViewField?.text = locationDetails?.introduction
        
        
        
        func loadImageData(fileName: String) -> UIImage? {
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
            
            let url = NSURL(fileURLWithPath: path)
            var image: UIImage?
            if let pathComponent = url.appendingPathComponent(fileName){
                let filePath = pathComponent.path
                let fileManager = FileManager.default
                let fileData = fileManager.contents(atPath: filePath)
                image = UIImage(data: fileData!)
            }
            
            return image
        }
        
        
        
        // Do any additional setup after loading the view.
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
