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
    
    
    let FIRPushController = FirebaseMenuPushController()
    let MyFormatter : EuroFormatter = EuroFormatter()
    let storageRef = Storage.storage().reference(withPath: "Itempictures")
    let ref = Database.database().reference(withPath: "menue")
    
    var MyImage : UIImage?
    let progressView = ProgressView(text: "Speisekarteneintrag hochladen")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(uploadFinished), name: Notification.Name("firemenuuploadsucessful"), object: nil)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CreateMenuItemAction(_ sender: Any) {
//        Textfield error handling
        
        guard ((NameTextField.text?.characters.count)! > 0) else {
            showinvalidNameErrorDialg()
            return
        }
        guard (Double(PriceTextField.text!) != nil) else {
            showinvalidPriceErrorDialg()
            return
        }
        
        if ((NewItemImageView.image == #imageLiteral(resourceName: "one"))){
            showinvalidImageErrorDialg()
            return
        }
        
        var tempprice : Double = Double(PriceTextField.text!)!
        tempprice = (tempprice * 100).rounded()/100
        
        
        FIRPushController.pushNewMenuItemtoFirebase(name: NameTextField.text!, price: tempprice, image: MyImage!)

        self.view.addSubview(progressView)
        progressView.show()
        
        
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
    
    func uploadFinished(){
        MyImage = #imageLiteral(resourceName: "one")
        NewItemImageView.image = #imageLiteral(resourceName: "one")
        NameTextField.text = ""
        PriceTextField.text = ""
        
        progressView.hide()
        
        let alertSheetController = UIAlertController(title: "Upload erfolgreich", message: "Sie können noch weitere Produkte ihrer Speisekarte hinzufügen",preferredStyle: .alert)
        
        let enterAction = UIAlertAction(title: "Ok", style: .default) { action -> Void in}
        alertSheetController.addAction(enterAction)
        
        self.present(alertSheetController, animated: true) {}
    }
    
    func showinvalidPriceErrorDialg(){
        let alertSheetController = UIAlertController(title: "Ungültigen Preis eingegeben", message: "Bitte geben sie den Preis in folgenden Format ein : 4.20",preferredStyle: .alert)
        
        let enterAction = UIAlertAction(title: "Ok", style: .default) { action -> Void in}
        alertSheetController.addAction(enterAction)
        
        self.present(alertSheetController, animated: true) {}
    }
    
    func showinvalidNameErrorDialg(){
        let alertSheetController = UIAlertController(title: "Keinen Namen eingegeben", message: "Bitte geben sie einen Namen für ihr Produkt in das Textfeld ein",preferredStyle: .alert)
        
        let enterAction = UIAlertAction(title: "Ok", style: .default) { action -> Void in}
        alertSheetController.addAction(enterAction)
        
        self.present(alertSheetController, animated: true) {}
        
    }

    func showinvalidImageErrorDialg(){
        let alertSheetController = UIAlertController(title: "Kein Foto eingegeben", message: "Bitte fügen sie ein Bild hinzu",preferredStyle: .alert)
        
        let enterAction = UIAlertAction(title: "Ok", style: .default) { action -> Void in}
        alertSheetController.addAction(enterAction)
        
        self.present(alertSheetController, animated: true) {}
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
