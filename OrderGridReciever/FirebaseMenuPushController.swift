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
    let menueref = Database.database().reference(withPath: "menue")
    
    func pushNewMenuItemtoFirebase (name : String, price: Double, image: UIImage, imageRef: StorageReference, key: String){
        let mymenuitem = MenueItem(name: name, price: price, image: image, imageRef: imageRef, key: key)
        let itemref = self.menueref.childByAutoId()
        itemref.setValue(mymenuitem.toAnyObject())
    
    }

}
