//
//  Motorbike.swift
//  project
//
//  Created by TinhNe on 5/11/22.
//  Copyright © 2022 TinhNe. All rights reserved.
//

import UIKit
class Motorbike {
    var id:String = ""
    var name:String = ""
    var price:Int = 0
    var type_id:String = "", manu_id:String = "", brake:String
    var fuel:String = "",transmission:String = ""
    var image:String, engine:String
    var nsx:Int,cubic_meter:Int
    init(id:String, name:String, price:Int, type_id:String, manu_id:String, brake:String, fuel:String, transmission:String, engine:String, cubic_meter:Int, image:String, nsx:Int) {
        self.id = id
        self.name = name
        self.price = price
        self.type_id = type_id
        self.manu_id = manu_id
        self.image = image
        self.nsx = nsx
        self.brake = brake
        self.fuel = fuel
        self.transmission = transmission
        self.cubic_meter = cubic_meter
        self.engine = engine
    }
    
    func tostring(){
        print(id,name,image,type_id,manu_id,nsx)
    }
    
//    let xe = ["id":key as Any,
//    "moto_name":"Wave Alpha",
//    "moto_price":20000000,
//    "type_id": "1",
//    "manu_id": "1",
//    "fuel":"Gasolin",
//    "transmission":"Manual",
//    "cubic_meter" : 110,
//    "brake" : "Phanh cơ",
//    "engine" : "Phun xăng điện tử Fi/ PGM-FI",
//    "nsx":2018,
//    "image":"sirius"] as [String : Any]
}
	
