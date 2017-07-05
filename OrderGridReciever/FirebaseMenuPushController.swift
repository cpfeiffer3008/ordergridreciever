//
//  FirebaseMenuPushController.swift
//  OrderGridReciever
//
//  Created by Christian Pfeiffer on 01.07.17.
//  Copyright © 2017 Christian Pfeiffer. All rights reserved.
//

import UIKit
import Firebase

class FirebaseMenuPushController: NSObject {
    let databaseref = Database.database().reference(withPath: "menue")
    let storageref = Storage.storage().reference(withPath: "Itempictures")
    let nc = NotificationCenter.default
    
    func pushNewMenuItemtoFirebase (name : String, price: Double, image: UIImage){
        let generatedStorageID = generateNewStorageItemID().uuidString
        let myStorageIDforDataBase : String = generatedStorageID
        var data = NSData()
        data = UIImageJPEGRepresentation(image, 0.8)! as NSData
        // set upload path
        let filePath = "\(generatedStorageID)"
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        self.storageref.child(filePath).putData(data as Data, metadata: metaData){(metaData,error) in
            if let error = error {
                print(error.localizedDescription)
                self.nc.post(name: Notification.Name("firemenuuploadfail"), object: nil)
                
                return
            }else{
//                Upload erfolgreich Eintrag in der Datenbank hinzufügen
                let mymenuitem = MenueItemPush(name: name, price: price, imageRef: myStorageIDforDataBase)
                let itemref = self.databaseref.childByAutoId()
                itemref.setValue(mymenuitem.toAnyObject())
//                Notification an den VC schicken
                self.nc.post(name: Notification.Name("firemenuuploadsucessful"), object: nil)
            }
        }
    }
    
    func generateNewStorageItemID() -> UUID{
        return UUID()
    }
    
    func getStorageref () -> StorageReference{
        return storageref
    }

//    func uploadPhotoToFirebaseStorage(myPhoto : UIImage, generatedID : String) ->Bool{
//        var data = NSData()
//        data = UIImageJPEGRepresentation(myPhoto, 0.8)! as NSData
//        // set upload path
//        let filePath = "\(storageref)\(generatedID))"
//        let metaData = StorageMetadata()
//        metaData.contentType = "image/jpg"
//        self.storageref.child(filePath).putData(data as Data, metadata: metaData){(metaData,error) in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }else{
//                return(true)
//            }
////           Do Epic Shit here!
//        }
    
        
    
}



