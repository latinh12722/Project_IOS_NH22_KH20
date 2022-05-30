//
//  BillsManagerViewController.swift
//  project_QLBX
//
//  Created by Tinh12722 on 5/30/22.
//  Copyright © 2022 Tinh12722. All rights reserved.
//

import UIKit

class BillsManagerViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    
    var sql = DatabaseLayer()
    var is_motor_table = false
    
    var motor_id = ""
    var timestamp = -1.0
    @IBOutlet weak var viewxe: UIView!
    @IBOutlet weak var viewtt: UIView!
    
    @IBOutlet weak var lbbill_id: UILabel!
    @IBOutlet weak var imagemotor: UIImageView!
    @IBOutlet weak var tfdiachi: UITextField!
    @IBOutlet weak var tfsdt: UITextField!
    @IBOutlet weak var tfname: UITextField!
    @IBOutlet weak var lbnsx: UILabel!
    @IBOutlet weak var lbpk: UILabel!
    @IBOutlet weak var lbprice: UILabel!
    @IBOutlet weak var lbtype: UILabel!
    @IBOutlet weak var lbmanu: UILabel!
    @IBOutlet weak var lbmotorname: UILabel!
    @IBOutlet weak var btnselectmotor: UIButton!
    @IBOutlet weak var bill_table: UITableView!
    @IBOutlet weak var motor_table: UITableView!
    @IBOutlet weak var motor_table_DropDownHC:NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        motor_table_DropDownHC.constant = 0
        viewtt.layer.cornerRadius = 12
        viewtt.layer.borderWidth = 2

        viewxe.layer.cornerRadius = 12
        viewxe.layer.borderWidth = 2

        motor_table.delegate = self
        motor_table.dataSource = self
        bill_table.delegate = self
        bill_table.dataSource = self
        motor_table.layer.zPosition = 100
        viewxe.layer.zPosition = -1
        motor_table.register(UINib(nibName: "AdminTableViewCell", bundle: nil), forCellReuseIdentifier: "AdminTableViewCell")
        bill_table.register(UINib(nibName: "BillsManagerTableViewCell", bundle: nil), forCellReuseIdentifier: "BillsManagerTableViewCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case bill_table:
            return bills.count
        default:
            return motorbikes.count
        }
    }
    @IBAction func btndatlai(_ sender: Any) {
        setcontrol()
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case bill_table:
            let cell = bill_table.dequeueReusableCell(withIdentifier: "BillsManagerTableViewCell", for: indexPath) as! BillsManagerTableViewCell
            cell.setvaluecell(bill: bills[indexPath.row])
            return cell
        default:
            let cell = motor_table.dequeueReusableCell(withIdentifier: "AdminTableViewCell", for: indexPath) as! AdminTableViewCell
            cell.lbname.text = motorbikes[indexPath.row].name
            return cell
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case bill_table:
            return 70.0
        default:
            return 40.0
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            switch tableView {
            case bill_table:
                setvaluemotor(motor: getmotor_byid(motor_id: bills[indexPath.row].motor_id))
                tfname.text = bills[indexPath.row].name
                tfsdt.text = bills[indexPath.row].phone
                tfdiachi.text = bills[indexPath.row].address
                lbbill_id.text = bills[indexPath.row].id
                timestamp = bills[indexPath.row].timestamp
                break
            default:
                btnselectmotor.setTitle(motorbikes[indexPath.row].name, for: .normal)
            UIView.animate(withDuration: 0.5){
                self.motor_table_DropDownHC.constant = 0
                self.is_motor_table = false
                self.setvaluemotor(motor: motorbikes[indexPath.row])
                
            }
        }
    }
    @IBAction func btnselectmotor(_ sender: AnyObject){
        UIView.animate(withDuration: 0.5){
                if self.is_motor_table == false{
                    self.is_motor_table = true
                    self.motor_table_DropDownHC.constant = 44.0 * 3.0
                }else{
                    self.motor_table_DropDownHC.constant = 0
                    self.is_motor_table = false
                }
            self.view.layoutIfNeeded()
        }
    }
    func setvaluemotor(motor:Motorbike) {
        motor_id = motor.id
        lbmotorname.text = motor.name
        lbpk.text = String(motor.cubic_meter)
        lbnsx.text = String(motor.nsx)
        lbmanu.text = getmanu(id: motor.manu_id).manu_name
        lbtype.text = getnametype(id: motor.type_id)
        lbprice.text = df2so(Double(motor.price))+" đ"
        if !motor.image.isEmpty {
            let imageData = Data(base64Encoded: motor.image, options: .ignoreUnknownCharacters)!
            imagemotor.image = UIImage(data: imageData)
        }
    }
    
    
    @IBAction func btnthem(_ sender: Any) {
        if tfsdt.text!.isValidPhone && tfname.text != "" && tfdiachi.text != ""{
            let bill = Bill(id: lbbill_id.text!, motor_id: motor_id, phone: tfsdt.text!, account: login_user, name: tfname.text!, timestamp: 1, address: tfdiachi.text!)
            sql.insert_bill(bill: bill)
            self.showSpinner()
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (t) in
                self.sql.getbills()
                self.bill_table.reloadData()
                self.removeSpinner()
            }
            self.showToast(message: "Thêm thành công", font: .systemFont(ofSize: 12.0))
        }else{
            self.showToast(message: "vui lòng nhập lại đữ liệu", font: .systemFont(ofSize: 12.0))
        }
    }
    
    @IBAction func btnsua(_ sender: Any) {
        if tfsdt.text!.isValidPhone && tfname.text != "" && tfdiachi.text != "" && timestamp != -1{
            let bill = Bill(id: lbbill_id.text!, motor_id: motor_id, phone: tfsdt.text!, account: login_user, name: tfname.text!, timestamp: timestamp, address: tfdiachi.text!)
            sql.update_bill(bill: bill)
            self.showSpinner()
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (t) in
                self.sql.getbills()
                self.bill_table.reloadData()
                self.removeSpinner()
            }
            self.showToast(message: "Sửa thành công", font: .systemFont(ofSize: 12.0))
        }else{
            self.showToast(message: "vui lòng nhập lại đữ liệu", font: .systemFont(ofSize: 12.0))
        }
    }
    
    @IBAction func btnxoa(_ sender: Any) {
        
    }
    func setcontrol() {
        tfname.text = ""
        tfdiachi.text = ""
        tfsdt.text = ""
        timestamp = -1
        lbbill_id.text = ""
        self.showSpinner()
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (t) in
            self.sql.getbills()
            self.bill_table.reloadData()
            self.removeSpinner()
        }
        
    }
    

}
