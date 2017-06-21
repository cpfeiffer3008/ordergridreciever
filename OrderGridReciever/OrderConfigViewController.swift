//
//  OrderConfigViewController.swift
//  OrderGridReciever
//
//  Created by Christian Pfeiffer on 14.06.17.
//  Copyright © 2017 Christian Pfeiffer. All rights reserved.
//

import UIKit

class OrderConfigViewController: UIViewController {
    let model = FirebaseRDModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func DeleteEverythingAction(_ sender: Any) {
    }

    @IBAction func DeleteOrdersForTable(_ sender: Any) {
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
