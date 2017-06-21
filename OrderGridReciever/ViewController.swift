//
//  ViewController.swift
//  OrderGridReciever
//
//  Created by Christian Pfeiffer on 18.05.17.
//  Copyright © 2017 Christian Pfeiffer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var OrderTable: UITableView!
    
    
    var datasource : OrderDataSource!
    var delegate : OrderDelegate!
    var model : FirebaseRDModel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        OrderTable.allowsMultipleSelectionDuringEditing = false
        
        datasource = OrderDataSource()
        delegate = OrderDelegate()
        
        OrderTable.delegate = delegate
        OrderTable.dataSource = datasource
        
        model = FirebaseRDModel()
        model.observeFirebase()
        print(model.numberofEntries())
        
        let nc = NotificationCenter.default
        
        nc.addObserver(self, selector: #selector(reloadOrderTable), name: Notification.Name("firereload"), object: nil)


    }
    
    func reloadOrderTable(){
        OrderTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

