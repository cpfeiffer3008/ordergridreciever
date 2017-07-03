//
//  MenuTableDataSource.swift
//  OrderGridReciever
//
//  Created by Christian Pfeiffer on 01.07.17.
//  Copyright © 2017 Christian Pfeiffer. All rights reserved.
//

import UIKit

class MenuTableDataSource: NSObject, UITableViewDataSource {
    
    let MenuModel : FirebaseMenueModel = FirebaseMenueModel()
    let MyFormatter : EuroFormatter = EuroFormatter()
    
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = MenuItemTableViewCell()
        let index = indexPath.row
        let entry = MenuModel.getElement(from: index)
        
        cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell")! as! MenuItemTableViewCell
        cell.NameLabel.text = String(entry.name)
        cell.PriceLabel.text = MyFormatter.string(for: entry.price)
        
        return cell
    }
    
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuModel.numberofEntries()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let menuItem = MenuModel.getElement(from: indexPath.row)
            menuItem.ref?.removeValue()
        }
    }
}
