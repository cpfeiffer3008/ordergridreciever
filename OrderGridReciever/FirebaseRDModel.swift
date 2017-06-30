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
    fileprivate var selectedTable = 1
    fileprivate var tableCount = 5
    fileprivate var RestaurantName : String = ""
    fileprivate var Itemtobeordered : MenueItem? = nil
    let ref = Database.database().reference(withPath: "order")
    let ref2 = Database.database().reference(withPath: "restaurant/MyFirstRestaurant")
    fileprivate var dataforTable : [OrderItem] = []
    let storageRef = Storage.storage().reference(withPath: "Itempictures")
    
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
    
    func numberofEntriesForSelectedTable() -> Int{
        return model.dataforTable.count
    }
    
    func getElement (from i : Int) -> OrderItem {
        return model.data[i]
    }
    
    func set(element: OrderItem, at i : Int){
        model.data[i] = element
    }
    
    func remove(at index: Int) {
        model.data.remove(at: index)
    }
    
    func wipeModel(){
        model.data = []
    }
    
    func wipeforTable(){
        for OrderItem in model.dataforTable {
            OrderItem.ref?.removeValue()
        }
    }
    
    func append(element : OrderItem){
        model.data.append(element)
    }
    
    func appendToTableModel(element : OrderItem){
        model.dataforTable.append(element)
    }
    
    func observeFirebaseOrders(){
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
        print("New Number of Entries is: \(self.model.dataforTable.count)")
        self.notifyTabletoReload()
        self.MakeModeltoTableModel()
        })
    }
    
    func observeFirebaseRestaurant(){
        model.ref2.observe(.value, with: { snapshot in
            print(snapshot)
            // 2
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            let newResName : String = postDict["name"]! as! String
            self.setRestaurantName(newName: newResName)
            self.model.tableCount = postDict["tables"] as! Int
            self.notifyRestaurantItemstoReload()
        })
    }
    
    func MakeModeltoTableModel(){
        model.dataforTable = []
        for OrderItem in model.data {
            print("OrderItem: \(OrderItem.table) SelectedTable: \(model.selectedTable)")
            if (OrderItem.table == model.selectedTable) {
                self.appendToTableModel(element: OrderItem)
            }
            else{
                print(OrderItem.table)}
        }
        //self.notifyTabletoReload()
        
    }
    
    func setRestaurantTitle(newTitle : String){
        model.RestaurantName = newTitle
    }
    
    func setTableCount (newCount : Int){
        model.tableCount = newCount
    }
    
    func notifyTabletoReload(){
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("firereload"), object: nil)
    }
    
    func notifyRestaurantItemstoReload(){
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("firereloadtable"),object: nil)
    }
    
    
    func setTable(Table : Int){
        model.selectedTable = Table
    }
    
    func getTable() ->Int {
        return model.selectedTable
    }
    
    func getTableCount() ->Int {
        return model.tableCount
    }
    
    func setRestaurantName(newName : String){
        model.RestaurantName = newName
    }
    
    func getRestaurantName() -> String {
        return model.RestaurantName
    }
    
    func calculateTotalPrice() ->Double{
        var totalPrice : Double = 0
        for OrderItem in model.dataforTable {
            totalPrice = totalPrice + Double(OrderItem.price)
        }
        return totalPrice
    }
    
    func setItemtobeOrdered (item: MenueItem){
        model.Itemtobeordered = item
    }
    
    func getItemtobeOrdered () -> MenueItem {
        guard (model.Itemtobeordered != nil) else {
            return MenueItem.init(name: "", price: 0.00, image: #imageLiteral(resourceName: "one"), imageRef: model.storageRef, key: "")
        }
        return model.Itemtobeordered!
    }
}

