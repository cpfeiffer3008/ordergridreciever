//
//  OrderConfigViewController.swift
//  OrderGridReciever
//
//  Created by Christian Pfeiffer on 14.06.17.
//  Copyright © 2017 Christian Pfeiffer. All rights reserved.
//

import UIKit
import Firebase

class OrderConfigViewController: UIViewController {
    let model = FirebaseRDModel()
    let ref = Database.database().reference(withPath: "order")
    @IBOutlet weak var TablePickerView: UIPickerView!
    @IBOutlet weak var DeleteForTableButton: UIButton!
    @IBOutlet weak var ActionNotifyLabel: UILabel!
    @IBOutlet weak var ActionNotifyLabelCounter: UILabel!
    
    var PickerDS : UIPickerViewDataSource!
    var pickerDelegate : UIPickerViewDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ActionNotifyLabelCounter.isHidden = true
        ActionNotifyLabel.isHidden = true
        
        PickerDS = TablePickerDataSource()
        pickerDelegate = TablePickerDelegate()
        
        TablePickerView.dataSource = PickerDS
        TablePickerView.delegate = pickerDelegate
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(reloadPicker), name: Notification.Name("firereloadtable"), object: nil)
        nc.addObserver(self, selector: #selector(newTableSelected), name: Notification.Name("newtableselected"), object: nil)
        
        TablePickerView.reloadAllComponents()
        newTableSelected()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func DeleteEverythingAction(_ sender: Any) {
        let alertSheetController = UIAlertController(title: "Alle Bestellungen löschen", message: "Wollen sie: alle Bestellungen löschen? Dies kann nicht rückgängig gemacht werden!",preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Abbrechen", style: .cancel) { action -> Void in
        }
        alertSheetController.addAction(cancelAction)
        
        let enterAction = UIAlertAction(title: "Alles Löschen!", style: .default) { action -> Void in
            self.ActionNotifyLabelCounter.text = "\(self.model.numberofEntries()) Elemente gelöscht"
            self.ActionNotifyLabel.text = "Löschen erfolgreich"
            
            self.ref.removeValue()
            
            self.ActionNotifyLabel.isHidden = false
            self.ActionNotifyLabelCounter.isHidden = false

        }
        alertSheetController.addAction(enterAction)
        
        self.present(alertSheetController, animated: true) {}
    }
    
    func reloadPicker(){
        TablePickerView.reloadAllComponents()
    }
    
    func newTableSelected(){
        DeleteForTableButton.setTitle("Bestellungen für Tisch \(model.getTable()) löschen", for: .normal)
    }
    
    

    @IBAction func DeleteOrdersForTable(_ sender: Any) {
        let alertSheetController = UIAlertController(title: "Bestellungen von Tisch \(model.getTable()) löschen?", message: "Wollen sie: alle Bestellungen von Tisch \(model.getTable()) löschen? Dies kann nicht rückgängig gemacht werden!",preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Abbrechen", style: .cancel) { action -> Void in
        }
        alertSheetController.addAction(cancelAction)
        
        let enterAction = UIAlertAction(title: "Löschen", style: .default) { action -> Void in
            self.ActionNotifyLabelCounter.text = "\(self.model.numberofEntriesForSelectedTable()) Elemente gelöscht"
            self.ActionNotifyLabel.text = "Löschen für Tisch \(self.model.getTable()) erfolgreich"
            
            self.model.MakeModeltoTableModel()
            self.model.wipeforTable()
            self.ActionNotifyLabel.isHidden = false
            self.ActionNotifyLabelCounter.isHidden = false
        }
        alertSheetController.addAction(enterAction)
        
        self.present(alertSheetController, animated: true) {}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
