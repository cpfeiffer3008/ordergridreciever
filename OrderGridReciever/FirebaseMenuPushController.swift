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
    
    func pushNewMenuItemtoFirebase (name : String, price: Double, image: UIImage, imageRef: StorageReference, key: String){
        let mymenuitem = MenueItem(name: name, price: price, image: image, imageRef: imageRef, key: key)
        let itemref = self.databaseref.childByAutoId()
        itemref.setValue(mymenuitem.toAnyObject())
    
    }
    
    func generateNewDatabaseItemID() -> DatabaseReference{
    return self.databaseref.childByAutoId()
    }
    
    func generateNewStorageItemID() -> String{
    //return self.storageref.childByAutoId()
    }
    
    func uploadPhotoToFirebaseStorage(myPhoto : UIImage) ->String{
        var data = NSData()
        data = UIImageJPEGRepresentation(myPhoto, 0.8)! as NSData
        // set upload path
        let filePath = "\(storageref)\(generateNewStorageItemID())"
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        self.storageref.child(filePath).putData(data as Data, metadata: metaData){(metaData,error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }else{
                //store downloadURL
                let downloadURL = metaData!.downloadURL()!.absoluteString
                //store downloadURL at database
                self.databaseRef.child("users").child(FIRAuth.auth()!.currentUser!.uid).updateChildValues(["userPhoto": downloadURL])
                return downloadURL
            }
            
        }
    }
    }


