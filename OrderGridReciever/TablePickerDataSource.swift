//
//  TablePickerDataSource.swift
//  OrderGridReciever
//
//  Created by Christian Pfeiffer on 30.06.17.
//  Copyright © 2017 Christian Pfeiffer. All rights reserved.
//

import UIKit

class TablePickerDataSource: NSObject, UIPickerViewDataSource {
    let model = FirebaseRDModel()
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { return model.getTableCount()}
    
    func getData(row : Int, component : Int) ->String {
        return String(row+1)
    }
    
}
