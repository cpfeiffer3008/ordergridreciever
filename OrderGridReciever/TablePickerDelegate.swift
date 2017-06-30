//
//  TablePickerDelegate.swift
//  OrderGridReciever
//
//  Created by Christian Pfeiffer on 30.06.17.
//  Copyright © 2017 Christian Pfeiffer. All rights reserved.
//

import UIKit

class TablePickerDelegate: NSObject, UIPickerViewDelegate {
    let model = FirebaseRDModel()
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let vDataSource = pickerView.dataSource as! TablePickerDataSource
        
        return vDataSource.getData(row: row, component: component)
    }
    
    func pickerView( _ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView{
        let vDataSource = pickerView.dataSource as! TablePickerDataSource
        var pickerLabel = view as! UILabel!
        
        if view == nil {
            pickerLabel = UILabel()}
        
        let titleData = vDataSource.getData(row: row , component: component)
        let title = NSAttributedString( string : titleData ,
                                        attributes :
            [NSFontAttributeName:UIFont(name: "Georgia", size: 21.0)!,
             NSForegroundColorAttributeName:UIColor.black])
        
        pickerLabel!.attributedText = title
        pickerLabel!.textAlignment = .center
        return pickerLabel!
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadAllComponents()
        
        model.setTable(Table: row+1)
        model.MakeModeltoTableModel()
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("newtableselected"), object: nil)
        print("Selected Table: ",model.getTable())
        
    }
    
    
    
    
}
