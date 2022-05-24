//
//  ViewController.swift
//  project_QLBX
//
//  Created by Tinh12722 on 5/17/22.
//  Copyright © 2022 Tinh12722. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
var login_user = ""
var login_admin = "admin"
var motorbikes:[Motorbike] = []
var manus:[manufacture] = []
var types:[protype] = []
class ViewController: UIViewController{
    var ref: DatabaseReference!
    
    @IBOutlet weak var btnselection_moto: UIButton!
    
    @IBOutlet weak var btncancel_search: UIButton!
    @IBOutlet weak var btnsearch: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnAccount: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        btnAccount.target = self
        btnAccount.action = #selector(click_account)
        ref = Database.database().reference().child("motorbikes")
        getdata_moto()
        
        btnselection_moto.addTarget(self, action: #selector(adddl), for: .touchUpInside)
        
        btnsearch.layer.cornerRadius = 10
        btncancel_search.isHidden = false
        
        
    }
    @objc func adddlmanu_type(){
//        ref = Database.database().reference().child("manufactures")
//        for m in manus {
//            let k = ref.childByAutoId().key
//            let manu = ["manu_id":k as Any,
//                      "manu_name": m.manu_name,
//                      "image": m.image
//            ]
//            ref.child(String(k!)).setValue(manu)
//        }
//
//        ref = Database.database().reference().child("protypes")
//        for t in types {
//            let k = ref.childByAutoId().key
//            let type = ["type_id":k as Any,
//                      "type_name": t.type_name
//            ]
//            ref.child(String(k!)).setValue(type)
//        }
    }
    @objc func addadmin(){
        //        ref = Database.database().reference().    child("admin")
        //        let key = ref.childByAutoId().key
        //
        //        let admin = ["id":key as Any,
        //                  "admin":"admin",
        //                  "pass":"123"]
        //        ref.child(String(key!)).setValue(admin)
    }
    @objc func adddl() {
        ref = Database.database().reference().child("motorbikes")
        let key = ref.childByAutoId().key
        let xe = ["id":key as Any,
                  "moto_name":"Wave Alpha",
                  "moto_price":20000000,
                  "type_id": "-N2NXKwjVF3hfpZ5VyhC",
                  "manu_id": "-N2NXKwjVF3hfpZ5Vyh8",
                  "fuel":"Gasolin",
                  "transmission":"Manual",
                  "cubic_meter" : 110,
                  "brake" : "Phanh cơ",
                  "engine" : "Phun xăng điện tử Fi/ PGM-FI",
                  "nsx":2018,
                  "image":"sirius"] as [String : Any]
        ref.child(String(key!)).setValue(xe)
        
    }
    func getdata_moto(){
        
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
                    motorbikes.append(moto!)
                }
                self.collectionView.reloadData()
            }
        })
    }
    @objc func click_account (sender:UIButton) {
        if login_user != "" {
            print("ok")
//            let navigation = UINavigationController(rootViewController: logincontroller)
//            self.view.addSubview(navigation.view)
//            self.addChild(navigation)
//            navigation.didMove(toParent: self)
        }else{
            if login_admin != "" {
                let story = UIStoryboard(name: "Main", bundle: nil)
                let AdminViewController = story.instantiateViewController(identifier: "AdminViewController") as! AdminViewController
                AdminViewController.modalPresentationStyle = .fullScreen
                self.present(AdminViewController, animated: true, completion: nil)
            }else{
                let story = UIStoryboard(name: "Main", bundle: nil)
                let logincontroller = story.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
                logincontroller.modalPresentationStyle = .fullScreen
                self.present(logincontroller, animated: true, completion: nil)
            }
        }
    }
    
    static func df2so(_ price: Double) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.decimalSeparator = "."
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: price as NSNumber)!
    }
}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if motorbikes.count > 0{
            return motorbikes.count
        }
        else{
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MotorbikeCollectionViewCell", for: indexPath) as! MotorbikeCollectionViewCell
            
        cell.setup(with: motorbikes[indexPath.row])
        cell.layer.cornerRadius = 10
        return cell
        
    }
}
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 300)
    }
}
extension ViewController:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}


