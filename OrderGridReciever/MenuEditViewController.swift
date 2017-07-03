//
//  MenuEditViewController.swift
//  OrderGridReciever
//
//  Created by Christian Pfeiffer on 01.07.17.
//  Copyright © 2017 Christian Pfeiffer. All rights reserved.
//

import UIKit

class MenuEditViewController: UIViewController {
    @IBOutlet weak var MenuTableView: UITableView!
    let MenuModel : FirebaseMenueModel = FirebaseMenueModel()
    
    var TableDataSource : UITableViewDataSource!
    var TableDelegate : UITableViewDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableDataSource = MenuTableDataSource()
        TableDelegate = MenuTableDelegate()
    
        MenuTableView.dataSource = TableDataSource
        MenuTableView.delegate = TableDelegate
        
        MenuModel.observeFirebaseMenue()
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(reloadTable), name: Notification.Name("fireReloadEditTable"), object: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadTable(){
        print ("MenuTable was told to reload!")
        MenuTableView.reloadData()
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
