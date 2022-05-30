//
//  BIll.swift
//  project_QLBX
//
//  Created by Tinh12722 on 5/30/22.
//  Copyright © 2022 Tinh12722. All rights reserved.
//

import UIKit
class Bill {
    var id: String
    var motor_id: String
    var phone: String
    var name: String
    var timestamp: Double
    var address: String
    var account:String
    init(id: String,motor_id: String,phone: String,account:String ,name: String,timestamp: Double,address: String) {
        self.id = id
        self.motor_id = motor_id
        self.name = name
        self.timestamp = timestamp
        self.phone = phone
        self.address = address
        self.account = account
    }
}
