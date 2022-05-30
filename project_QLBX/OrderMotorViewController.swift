//
//  OrderMotorViewController.swift
//  project_QLBX
//
//  Created by Tinh12722 on 5/29/22.
//  Copyright © 2022 Tinh12722. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class OrderMotorViewController: UIViewController ,UITextFieldDelegate{
    var motor_id:String = ""
    var sql = DatabaseLayer()
    var motors: [Motorbike] = []
    var ref: DatabaseReference!
    
    @IBOutlet weak var btnxacnhan: UIButton!
    @IBOutlet weak var tfdiachi: UITextField!
    @IBOutlet weak var tfsdt: UITextField!
    @IBOutlet weak var tfname: UITextField!
    @IBOutlet weak var viewthongtin: UIView!
    @IBOutlet weak var lbprice: UILabel!
    @IBOutlet weak var lbnsx: UILabel!
    
    @IBOutlet weak var lbpk: UILabel!
    @IBOutlet weak var lbnametype: UILabel!
    @IBOutlet weak var lbnamemanu: UILabel!
    @IBOutlet weak var lbnamemotor: UILabel!
    
    @IBOutlet weak var imagemotor: UIImageView!
    
    let customAlert = MyAlert()
    override func viewDidLoad() {

        super.viewDidLoad()
        getdata_motor_byid(id: motor_id)
        self.showSpinner()
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (t) in
            self.setvalue_control(motor: self.motors[0])
            self.removeSpinner()
        }
        viewthongtin.layer.borderColor =  UIColor.black.cgColor
        viewthongtin.layer.cornerRadius = 10
        viewthongtin.layer.borderWidth = 2
        tfname.delegate = self
        tfname.returnKeyType = .done
        tfsdt.delegate = self
        tfsdt.returnKeyType = .done
        tfdiachi.delegate = self
        tfdiachi.returnKeyType = .done
        navigationController?.popViewController(animated: true)
        btnxacnhan.layer.cornerRadius = 10
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnxacnhan(_ sender: Any) {
        sql.insert_bill(bill: Bill(id: "", motor_id: motor_id, phone: tfsdt.text!,account: login_user, name: tfname.text!, timestamp: 1, address: tfdiachi.text!))
        
        
        customAlert.shopAlert(with: "Xác nhận", message: "Đặt hàng thành công \n Vào tài khoản để kiểm tra hoặc quay lại để tiếp tục", on: self)
        btnxacnhan.isEnabled = false
    }
    
    func setvalue_control(motor : Motorbike) {
           lbnamemotor.text = motor.name
           lbpk.text = String(motor.cubic_meter) + " cc"
           lbnsx.text = String(motor.nsx)
        lbprice.text = df2so(Double(motor.price))+" đ"
         
           if !motor.image.isEmpty {
               let imageData = Data(base64Encoded: motor.image, options: .ignoreUnknownCharacters)!
               imagemotor.image = UIImage(data: imageData)
           }
            lbnametype.text = getnametype(id: motor.type_id)
            lbnamemanu.text = getmanu(id: motor.manu_id).manu_name
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let btn = sender as? UIButton {
            if btn == btnxacnhan {
                
            }
        }
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
extension UINavigationController {
  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
      popToViewController(vc, animated: animated)
    }
  }
    func backToViewController(vc: Any) {
       // iterate to find the type of vc
       for element in viewControllers as Array {
        if "\(type(of: element)).Type" == "\(type(of: (vc as AnyObject)))" {
             self.popToViewController(element, animated: true)
             break
          }
       }
    }

}
