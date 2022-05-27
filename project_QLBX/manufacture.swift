//
//  manufactures.swift
//  project
//
//  Created by TinhNe on 5/11/22.
//  Copyright © 2022 TinhNe. All rights reserved.
//

import UIKit

class manufacture {
    var manu_id:String
    var manu_name:String
    var image:String
    init?(manu_id:String, manu_name:String, image:String) {
        self.manu_id = manu_id
        self.manu_name = manu_name
        self.image = image
    }
}
