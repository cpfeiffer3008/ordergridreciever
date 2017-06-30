//
//  OrderCell.swift
//  OrderGridReciever
//
//  Created by Christian Pfeiffer on 18.05.17.
//  Copyright © 2017 Christian Pfeiffer. All rights reserved.
//

import UIKit

class OrderCell: UITableViewCell {

    @IBOutlet weak var TableLabel: UILabel!
    @IBOutlet weak var ItemLabel: UILabel!
    @IBOutlet weak var PriceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
