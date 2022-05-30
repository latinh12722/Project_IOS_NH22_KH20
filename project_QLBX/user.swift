//
//  user.swift
//  project_QLBX
//
//  Created by Tinh12722 on 5/30/22.
//  Copyright © 2022 Tinh12722. All rights reserved.
//

import UIKit
class user {
    var username:String
    var password:String
    var role:Int
    init(username:String,password:String,role: Int) {
        self.password = password
        self.username = username
        self.role = role
    }
}
