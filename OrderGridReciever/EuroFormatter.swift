//
//  EuroFormatter.swift
//  OrderGridReciever
//
//  Created by Christian Pfeiffer on 30.06.17.
//  Copyright © 2017 Christian Pfeiffer. All rights reserved.
//

import UIKit

class EuroFormatter: NumberFormatter {
    override init() {
        super.init()
        self.maximumFractionDigits = 2
        self.numberStyle = .currency
        self.currencyCode = "EUR"
        self.currencySymbol = "€"
        self.locale = NSLocale(localeIdentifier: "de_DE") as Locale!
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
