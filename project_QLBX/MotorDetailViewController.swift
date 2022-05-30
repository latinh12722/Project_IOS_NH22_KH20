//
//  MotorDetailViewController.swift
//  project_QLBX
//
//  Created by Tinh12722 on 5/27/22.
//  Copyright © 2022 Tinh12722. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class MotorDetailViewController: UIViewController {
    
    var ref: DatabaseReference!
    @IBOutlet weak var lbfule_transmission: UILabel!
    @IBOutlet weak var lbpk: UILabel!
    
    @IBOutlet weak var lbnsx: UILabel!
    @IBOutlet weak var lbnamemanu: UILabel!
    @IBOutlet weak var lbtype_name: UILabel!
    
    
    @IBOutlet weak var lbphanh: UILabel!
    @IBOutlet weak var lbprice: UILabel!
    @IBOutlet weak var lbname: UILabel!
    @IBOutlet weak var image_manu: UIImageView!
    @IBOutlet weak var image: UIImageView!
    var motor_id: String = ""
    var sql = DatabaseLayer()
    var motors: [Motorbike] = []
    override func viewDidLoad(){
        
        
        super.viewDidLoad()
        getdata_motor_byid(id: motor_id)
        self.showSpinner()
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (t) in
            self.setvalue_control(motor: self.motors[0])
            self.removeSpinner()
        }
    }
    
    @IBAction func account(_ sender: Any) {
        if login_user != "" {
                    
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
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnmuahang(_ sender: Any) {
        if login_user != "" {
            let vc = OrderMotorViewController()
            vc.modalPresentationStyle = .fullScreen
            vc.motor_id = motor_id
            present(vc, animated: true, completion: nil)
        }else{
            let story = UIStoryboard(name: "Main", bundle: nil)
            let logincontroller = story.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
            logincontroller.modalPresentationStyle = .fullScreen
            self.present(logincontroller, animated: true, completion: nil)
        }
    }
    
    func setvalue_control(motor : Motorbike) {
        lbname.text = motor.name
        lbpk.text = String(motor.cubic_meter) + " cc"
        lbnsx.text = String(motor.nsx)
        lbphanh.text = motor.brake
        lbfule_transmission.text = motor.fuel + " / " + motor.transmission
        if !motor.image.isEmpty {
            let imageData = Data(base64Encoded: motor.image, options: .ignoreUnknownCharacters)!
            image.image = UIImage(data: imageData)
        }
        if !getmanu(id: motor.manu_id).image.isEmpty {
            let imageData = Data(base64Encoded: getmanu(id: motor.manu_id).image, options: .ignoreUnknownCharacters)!
            image_manu.image = UIImage(data: imageData)
        }
        lbnamemanu.text = getmanu(id: motor.manu_id).manu_name
        lbtype_name.text = getnametype(id: motor.type_id)
        lbprice.text = df2so(Double(motor.price))
    }
    
    
    
    func getdata_motor_byid(id: String){
        ref = Database.database().reference().child("motorbikes")
        let db = ref.queryOrdered(byChild: "id").queryEqual(toValue: id)
        
        db.observe(DataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount > 0 {
                print(snapshot.childrenCount)
                
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
                    self.motors.append(moto)
                }
            }
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
