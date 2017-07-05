//
//  MenuItemPush.swift
//  OrderGridReciever
//
//  Created by Christian Pfeiffer on 05.07.17.
//  Copyright © 2017 Christian Pfeiffer. All rights reserved.
//

import UIKit
import Firebase

struct MenueItemPush {
    
    let key: String
    let name: String
    let price : Double
    let ref: DatabaseReference?
    let image : String
    let storage = Storage.storage()
    let storageRef : StorageReference
    
    
    init(name: String, price: Double, imageRef : String) {
        self.key = ""
        self.name = name
        self.price = price
        self.image = imageRef
        self.ref = nil
        self.storageRef = storage.reference()
    }
    
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "price": price,
            "picture": image
        ]
    }
    
}
//gs://ordergrid-644f7.appspot.com/Itempictures/Goas.jpg
//gs://ordergrid-644f7.appspot.com/Itempictures/Goas.jpg
