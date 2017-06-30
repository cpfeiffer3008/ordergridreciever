//
//  FirebaseMenuModel.swift
//  OrderGridReciever
//
//  Created by Christian Pfeiffer on 30.06.17.
//  Copyright © 2017 Christian Pfeiffer. All rights reserved.
//

import UIKit
import Firebase


class FirebaseMenueSingleton{
    
    static let sharedInstance = FirebaseMenueSingleton()
    fileprivate var data : [MenueItem] = []
    let ref = Database.database().reference(withPath: "menue")
    
    
    private init (){
    }
}
class FirebaseMenueModel: NSObject {
    fileprivate var model = FirebaseMenueSingleton.sharedInstance
    
    override init(){
    }
    
    func numberofEntries() -> Int {
        return model.data.count
    }
    
    func getElement (from i : Int) -> MenueItem {
        return model.data[i]
    }
    
    func set(element: MenueItem, at i : Int){
        model.data[i] = element
    }
    
    func remove(at index: Int) {
        model.data.remove(at: index)
    }
    
    func wipeModel(){
        model.data = []
    }
    
    func append(element : MenueItem){
        model.data.append(element)
    }
    func setImage(newImage : UIImage, i: Int){
        model.data[i].imageRes = newImage
        self.notifyCollectionToReload()
    }
    
    func setImgDownloadHasStarted(started: Bool, i: Int){
        model.data[i].ImageDownloadHasStarted = started
    }
    
    func observeFirebaseMenue(){
        model.ref.observe(.value, with: { snapshot in
            print(snapshot)
            var newItems: [MenueItem] = []
            for item in snapshot.children {
                let menuItem = MenueItem(snapshot: item as! DataSnapshot)
                newItems.append(menuItem)
            }
            self.model.data = newItems
            print("New Number of Entries is: \(self.model.data.count)")
            self.notifyCollectionToReload()
        })
    }
    
    func notifyCollectionToReload(){
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("fireReloadCollection"), object: nil)
    }
    
}
