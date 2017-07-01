//
//  NewMenuItemViewController.swift
//  OrderGridReciever
//
//  Created by Christian Pfeiffer on 01.07.17.
//  Copyright © 2017 Christian Pfeiffer. All rights reserved.
//

import UIKit
import Firebase

class NewMenuItemViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var NewItemImageView: UIImageView!
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var PriceTextField: UITextField!
    
    let MyFormatter : EuroFormatter = EuroFormatter()
    let storageRef = Storage.storage().reference(withPath: "Itempictures")
    let ref = Database.database().reference(withPath: "menue")
    
    var MyImage : UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CreateMenuItemAction(_ sender: Any) {
        let MyItemRef : DatabaseReference = ref.childByAutoId()
        
    }
    
    
    @IBAction func TakeNewImageAction(_ sender: Any) {
        let actionSheetController = UIAlertController(title: "Ein Bild ihrem Produkt hinzufügen",
                                                      message: "Bild aufnehmen oder vom Gerät laden?",
                                                      preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Abbrechen", style: .cancel) { action -> Void in
            print("Cancel gedrückt")
        }
        actionSheetController.addAction(cancelAction)
        
        let cameraAction = UIAlertAction(title: "Mit Kamera aufnehmen", style: .default) { action -> Void in
            self.openCamera()
            print("Enter")
        }
        actionSheetController.addAction(cameraAction)
        
        let photolibaryAction = UIAlertAction(title: "Aus Fotos laden", style: .default) { action -> Void in
            self.openLibary()
            print("Enter")
        }
        actionSheetController.addAction(photolibaryAction)
        
        let popover = actionSheetController.popoverPresentationController;
        if let popover = popover {
            popover.sourceView = sender as? UIView
            popover.sourceRect = (sender as AnyObject).bounds
            popover.permittedArrowDirections = .up
        }
        self.present(actionSheetController, animated: true) { () -> Void in
            print("Ready")

        }
    }
    
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func openLibary(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!){
        MyImage = image
        NewItemImageView.image = MyImage
        self.dismiss(animated: true, completion: nil);
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
