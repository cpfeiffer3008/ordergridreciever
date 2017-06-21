//
//  FirebaseRDModel.swift
//  OrderGridReciever
//
//  Created by Christian Pfeiffer on 22.05.17.
//  Copyright © 2017 Christian Pfeiffer. All rights reserved.
//

import UIKit
import Firebase

class FirebaseSingleton{
        
        static let sharedInstance = FirebaseSingleton()
        fileprivate var data : [OrderItem] = []
        let ref = Database.database().reference(withPath: "order")
    
    private init (){
    }
}

class FirebaseRDModel {
    fileprivate var model = FirebaseSingleton.sharedInstance
    
    init(){
    }
    
    func numberofEntries() -> Int {
        return model.data.count
    }
    
    func getElement (from i : Int) -> OrderItem {
        return model.data[i]
    }
    
    func set(element: OrderItem, at i : Int){
        model.data[i] = element
    }

    func remove(at index: Int) {
        //model.ref.
        model.data.remove(at: index)
    }

    func wipeModel(){
        model.ref.removeValue()
    }
    
    func append(element : OrderItem){
        model.data.append(element)
    }
    
    func observeFirebase(){
            // 1
            model.ref.observe(.value, with: { snapshot in
                print(snapshot)
            // 2
            var newItems: [OrderItem] = []
            
            // 3
            for item in snapshot.children {
                // 4
                let orderItem = OrderItem(snapshot: item as! DataSnapshot)
                newItems.append(orderItem)
            }
            
            // 5
            self.model.data = newItems
            self.notifyTabletoReload()
        })
    }
    func notifyTabletoReload(){
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("firereload"), object: nil)
    }
    
    
}


