//
//  ConfigScreenViewController.swift
//  OrderGridReciever
//
//  Created by Christian Pfeiffer on 30.06.17.
//  Copyright © 2017 Christian Pfeiffer. All rights reserved.
//

import UIKit
import Firebase

class ConfigScreenViewController: UIViewController {
    let model : FirebaseRDModel = FirebaseRDModel()
    let menumodel : FirebaseMenueModel = FirebaseMenueModel()
    let ref : DatabaseReference = Database.database().reference(withPath: "restaurant/MyFirstRestaurant")
    
    @IBOutlet weak var CurrentRestaurantNameLabel: UILabel!
    @IBOutlet weak var NewRestaurantNameTextField: UITextField!
    @IBOutlet weak var CurrentRestaurantTableCountLabel: UILabel!
    @IBOutlet weak var TableCountDecrementButton: UIButton!
    @IBOutlet weak var TableCountIncrementButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        CurrentRestaurantNameLabel.text = "Name: \(model.getRestaurantName())"
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(updateRestaurantProperties), name: Notification.Name("firereloadtable"), object: nil)
        
        
        // Do any additional setup after loading the view.
    }
    
    func updateRestaurantProperties(){
        CurrentRestaurantNameLabel.text = "Name: \(model.getRestaurantName())"
        CurrentRestaurantTableCountLabel.text = String(model.getTableCount())
        if (model.getTableCount() <= 1)  {
        TableCountDecrementButton.isEnabled = false
        }
        else {
        TableCountDecrementButton.isEnabled = true
        }
        
    }
    
    @IBAction func SetNewRestaurantNameAction(_ sender: UIButton) {
        ref.child("name").setValue(NewRestaurantNameTextField.text)
        NewRestaurantNameTextField.resignFirstResponder()
        
    }
    
    @IBAction func IncrementTableCountAction(_ sender: Any) {
        ref.child("tables").setValue((model.getTableCount()+1))
    }
    
    
    @IBAction func DecrementTableCountAction(_ sender: Any) {
        ref.child("tables").setValue((model.getTableCount()-1))
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
