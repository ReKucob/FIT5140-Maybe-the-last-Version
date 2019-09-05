import UIKit
import CoreData

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imageView: UIImageView!
    var managedObjectContext: NSManagedObjectContext?
    
    override func viewDidLoad() {
       super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedObjectContext = appDelegate.persistantContainer?.viewContext
        
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
    
    @IBAction func savePhoto(_ sender: Any) {
        guard let image = imageView.image else{
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
        
        do {
            try self.managedObjectContext?.save()
            displayMessage("Image has been saved!","Success")
        }
        catch
        {
            displayMessage("Could not save to database","Error")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]){
    if let pickedImage = info[.originalImage] as? UIImage{
        imageView.image = pickedImage
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
