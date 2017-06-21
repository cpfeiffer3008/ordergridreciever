//
//  User.swift
//  OrderGridReciever
//
//  Created by Christian Pfeiffer on 22.05.17.
//  Copyright © 2017 Christian Pfeiffer. All rights reserved.
//

import Foundation

struct User {
    
    let uid: String
    let email: String
    
    init(authData: User) {
        uid = authData.uid
        email = authData.email
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
    
}

