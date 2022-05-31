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
var login_admin = ""
var motorbikes:[Motorbike] = []
var manus:[manufacture] = []
var types:[protype] = []
var users:[user] = []
var bills:[Bill] = []
class ViewController: UIViewController{
    var search:String = ""
    var ref: DatabaseReference!
    var sql = DatabaseLayer()
    @IBOutlet weak var btnsearch: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnAccount: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        sql = DatabaseLayer()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        btnAccount.target = self
        btnAccount.action = #selector(click_account)
        ref = Database.database().reference().child("motorbikes")
        self.sql.getdata_moto()
        self.sql.getdata_manu()
        self.sql.getdata_type()
        self.sql.getalluser()
        self.sql.getbills()
        self.showSpinner()
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (t) in
            
            self.collectionView.reloadData()
            self.removeSpinner()
        }

        btnsearch.layer.cornerRadius = 10

    }
    
    
    
    @IBAction func reload(_ sender: Any) {
        btnsearch.titleLabel?.text = "🔎 Nhập từ khoá tìm kiếm"
        
        self.showSpinner()
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (t) in
            self.sql.getdata_moto()
            self.sql.getdata_manu()
            self.sql.getdata_type()
            self.collectionView.reloadData()
            self.removeSpinner()
        }
    }
    func getdata_type(){
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
        ref = Database.database().reference().child("protypes")
        for t in types {
            let k = ref.childByAutoId().key
            let type = ["type_id":k as Any,
                      "type_name": t.type_name
            ]
            ref.child(String(k!)).setValue(type)
        }
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
                self.collectionView.reloadData()
            }
        })
    }
    @objc func click_account (sender:UIButton) {
        print(bills.count)
        if login_user != "" {
            let vc = AccountUserViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }else{
            if login_admin != "" {
                let vc = AdminViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }else{
                let story = UIStoryboard(name: "Main", bundle: nil)
                let logincontroller = story.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
                logincontroller.modalPresentationStyle = .fullScreen
                self.present(logincontroller, animated: true, completion: nil)
            }
        }
        
        
        
    }
    @IBAction func unwindMain(_ sender: UIStoryboardSegue){}
    @IBAction func unwindMain_Search(_ sender: UIStoryboardSegue){
        if let sourceController = sender.source as? SearchViewController {
        // Get the new meal from meail detail controller
            
            
        }
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
        let vc = MotorDetailViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.motor_id = motorbikes[indexPath.row].id
        present(vc, animated: true, completion: nil)
    }
}


