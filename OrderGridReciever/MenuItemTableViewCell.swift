//
//  MenuItemTableViewCell.swift
//  OrderGridReciever
//
//  Created by Christian Pfeiffer on 01.07.17.
//  Copyright © 2017 Christian Pfeiffer. All rights reserved.
//

import UIKit

class MenuItemTableViewCell: UITableViewCell {
    @IBOutlet weak var PriceLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
