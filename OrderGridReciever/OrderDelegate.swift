//
//  OrderDelegate.swift
//  OrderGridReciever
//
//  Created by Christian Pfeiffer on 18.05.17.
//  Copyright © 2017 Christian Pfeiffer. All rights reserved.
//

import UIKit
import Firebase

class OrderDelegate: NSObject, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
