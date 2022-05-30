//
//  DatabaseLayer.swift
//  project_QLBX
//
//  Created by Tinh12722 on 5/29/22.
//  Copyright © 2022 Tinh12722. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class DatabaseLayer {
    var ref: DatabaseReference!
    init() {}
    
    
   public func getdata_type(){
        ref = Database.database().reference().child("protypes")
        ref.observe(DataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount > 0 {
                types.removeAll()
                for artists in snapshot.children.allObjects as! [DataSnapshot]{
                    let artistObject = artists.value as? [String: AnyObject]
                    let type_id = artistObject?["type_id"] as! String
                    let type_name = artistObject?["type_name"] as! String
                   
                    let type = protype(type_id: type_id, type_name: type_name)
                    types.append(type!)
                }
            }
        })
    }
    func getdata_manu(){
        ref = Database.database().reference().child("manufactures")
        ref.observe(DataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount > 0 {
                manus.removeAll()
                for artists in snapshot.children.allObjects as! [DataSnapshot]{
                    let artistObject = artists.value as? [String: AnyObject]
                    let manu_id = artistObject?["manu_id"] as! String
                    let manu_name = artistObject?["manu_name"] as! String
                    let iamge:String = artistObject?["image"] as! String
                   
                    let manu = manufacture(manu_id: manu_id, manu_name: manu_name, image: iamge)
                    manus.append(manu!)
                }
                
            }
        })
    }
    func getdata_moto(){
        ref = Database.database().reference().child("motorbikes")
        ref.observe(DataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount > 0 {
                motorbikes.removeAll()
                
                for artists in snapshot.children.allObjects as! [DataSnapshot]{
                    let artistObject = artists.value as? [String: AnyObject]
                    let id = artistObject?["id"] as! String
                    let moto_name = artistObject?["moto_name"] as! String
                    let moto_price:Int = artistObject?["moto_price"] as! Int
                    let type_id:String = artistObject?["type_id"] as! String
                    let manu_id:String = artistObject?["manu_id"] as! String
                    let nsx:Int = artistObject?["nsx"] as! Int
                    let image = artistObject?["image"] as! String
                    let brake = artistObject?["brake"] as! String
                    let fuel = artistObject?["fuel"] as! String
                    let transmission = artistObject?["transmission"] as! String
                    let engine = artistObject?["engine"] as! String
                    let cubic_meter =  artistObject?["cubic_meter"] as! Int
                    
                    let moto = Motorbike(id: id, name: moto_name, price: moto_price, type_id: type_id, manu_id: manu_id, brake: brake, fuel: fuel, transmission: transmission, engine: engine, cubic_meter: cubic_meter, image: image, nsx: nsx)
                    motorbikes.append(moto)
                }
            }
        })
    }
    func insert_bill(bill: Bill) {
        ref = Database.database().reference().child("bills")
        let key = ref.childByAutoId().key
        let b = ["id":key as Any,
                  "name": bill.name,
                  "address": bill.address,
                  "phone": bill.phone,
                  "account" : bill.account,
                  "timestamp": [".sv": "timestamp"],
                  "motor_id": bill.motor_id ] as [String : Any]
        ref.child(String(key!)).setValue(b)
        
    }
    func getbills() {
        ref = Database.database().reference().child("bills")
        ref.observe(DataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount > 0 {
                bills.removeAll()
                
                for artists in snapshot.children.allObjects as! [DataSnapshot]{
                    let artistObject = artists.value as? [String: AnyObject]
                    let id = artistObject?["id"] as! String
                    let name = artistObject?["name"] as! String
                    let address:String = artistObject?["address"] as! String
                    let phone:String = artistObject?["phone"] as! String
                    let account:String = artistObject?["account"] as! String
                    let timestamp:Double = Double(artistObject?["timestamp"] as! Double)
                    let motor_id = artistObject?["motor_id"] as! String
                    
                    let bill = Bill(id: id, motor_id: motor_id, phone: phone, account: account, name: name, timestamp: timestamp, address: address)
                    bills.append(bill)
                }
            }
        })
    }
    func convertTimestamp(serverTimestamp: Double) -> String {
        let x = serverTimestamp / 1000
        let date = NSDate(timeIntervalSince1970: x)
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium

        return formatter.string(from: date as Date)
    }
    func getalluser() {
        ref = Database.database().reference().child("user")
        ref.observe(DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                for artists in snapshot.children.allObjects as! [DataSnapshot]{
                    let artistObject = artists.value as? [String: AnyObject]
                    
                    let user_name = artistObject?["username"] as! String
                    let pass_word = artistObject?["password"] as! String
                    let role = artistObject?["role"] as! Int
                    let us = user(username: user_name, password: pass_word,role: role)
                    users.append(us)
                }
            }
        })
    }
    
    func checklogin(username:String, password:String) -> Int {
       
        for us in users {
            if (us.password == password && us.username == username)
            {
                if (us.role == 1){
                    login_admin = us.username
                    return 1
                }
                login_user = us.username
                return 0
            }
        }
        return 2
    }
    func update_bill(bill:Bill) {
        ref = Database.database().reference().child("bills")
        ref.child(bill.id).setValue(["id":bill.id as Any,
        "name": bill.name,
        "address": bill.address,
        "phone": bill.phone,
        "account" : bill.account,
        "timestamp": [".sv": "timestamp"],
        "motor_id": bill.motor_id ])
    }
    func remove_bill(bill_id:String) {
        ref = Database.database().reference().child("bills")
        ref.child(bill_id).removeValue()
    }
    
}
