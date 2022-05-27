//
//  MotorbikeManagerViewController.swift
//  project_QLBX
//
//  Created by Tinh12722 on 5/25/22.
//  Copyright © 2022 Tinh12722. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class MotorbikeManagerViewController: UIViewController , UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBOutlet weak var motor_table: UITableView!
    @IBOutlet weak var imagemotor: UIImageView!
    var is_protype_table = false
    var is_manufacture_table = false
    @IBOutlet weak var btn_type_dropdown: UIButton!
    @IBOutlet weak var btn_manu_dropdown: UIButton!
    @IBOutlet weak var protype_table: UITableView!
    @IBOutlet weak var manufacture_table: UITableView!
    @IBOutlet weak var protype_table_DropDownHC:NSLayoutConstraint!
    @IBOutlet weak var manufacture_table_DropDownHC:NSLayoutConstraint!
    
    @IBOutlet weak var lbid: UILabel!
    @IBOutlet weak var tfnsx: UITextField!
    @IBOutlet weak var tfdongco: UITextField!
    @IBOutlet weak var tfphanh: UITextField!
    @IBOutlet weak var tfpk: UITextField!
    @IBOutlet weak var tfname: UITextField!
    @IBOutlet weak var tftruyentai: UITextField!
    @IBOutlet weak var tfprice: UITextField!
    @IBOutlet weak var tfnhietlieu: UITextField!
    
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        protype_table.dataSource = self
        protype_table.delegate = self
        manufacture_table.dataSource = self
        manufacture_table.delegate = self
        motor_table.dataSource = self
        motor_table.delegate = self
        protype_table_DropDownHC.constant = 0
        manufacture_table_DropDownHC.constant = 0
        let nib = UINib(nibName: "AdminTableViewCell", bundle: nil)
        protype_table.register(nib, forCellReuseIdentifier: "AdminTableViewCell")
        manufacture_table.register(nib, forCellReuseIdentifier: "AdminTableViewCell")
        
        motor_table.register(UINib(nibName: "MotorManagerTableViewCell", bundle: nil), forCellReuseIdentifier: "MotorManagerTableViewCell")
        
        
        protype_table.layer.zPosition = 10
        manufacture_table.layer.zPosition = 10
        
        ref = Database.database().reference().child("motorbikes")
        
        
        
        imagemotor.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageProcessing))
        
        imagemotor.addGestureRecognizer(tap)
    }
    
    @IBAction func btndatlai(_ sender: Any) {
        tfnsx.text = ""
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var number = 1
        switch tableView {
        case manufacture_table:
            number = manus.count
        case protype_table:
            number = types.count
        case motor_table:
            number = motorbikes.count
        default:
            number = 1
        }
        return number
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView {
        case motor_table:
            let name = "MotorManagerTableViewCell"
            let motorcell = tableView.dequeueReusableCell(withIdentifier: name, for: indexPath) as! MotorManagerTableViewCell
            let m = motorbikes[indexPath.row]
            motorcell.setvalue_motor(moto: m)
            return motorcell
        case protype_table:
            let cell = protype_table.dequeueReusableCell(withIdentifier: "AdminTableViewCell", for: indexPath) as! AdminTableViewCell
            cell.lbname.text = types[indexPath.row].type_name
            return cell
        case manufacture_table:
            let cell = manufacture_table.dequeueReusableCell(withIdentifier: "AdminTableViewCell", for: indexPath) as! AdminTableViewCell
            cell.lbname.text = manus[indexPath.row].manu_name
            return cell
            
        
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch tableView {
        case protype_table:
            btn_type_dropdown.setTitle(types[indexPath.row].type_name, for: .normal)
            UIView.animate(withDuration: 0.5){
                self.protype_table_DropDownHC.constant = 0
                self.is_protype_table = false
            }
        case manufacture_table:
            
            btn_manu_dropdown.setTitle(manus[indexPath.row].manu_name, for: .normal)
            UIView.animate(withDuration: 0.5){
            self.manufacture_table_DropDownHC.constant = 0
            self.is_manufacture_table = false
        }
        default:
            let moto = motorbikes[indexPath.row]
            tfname.text = moto.name
            tfnsx.text = String(moto.nsx)
            tfpk.text = String(moto.cubic_meter)
            tfdongco.text = moto.engine
            tfphanh.text = moto.brake
            tfnhietlieu.text = moto.fuel
            tftruyentai.text = moto.transmission
            lbid.text = "ID: " + moto.id
            tfprice.text = String(moto.price)
        }
        self.view.layoutIfNeeded()
    }
    @IBAction func btnprotype(_ sender: AnyObject){
        UIView.animate(withDuration: 0.5){
                if self.is_protype_table == false{
                    self.is_protype_table = true
                    self.protype_table_DropDownHC.constant = 44.0 * 3.0
                }else{
                    self.protype_table_DropDownHC.constant = 0
                    self.is_protype_table = false
                }
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func btnmanufacture(_ sender: AnyObject){
        UIView.animate(withDuration: 0.5){
                if self.is_manufacture_table == false{
                    self.is_manufacture_table = true
                    self.manufacture_table_DropDownHC.constant = 44.0 * 3.0
                }else{
                    self.manufacture_table_DropDownHC.constant = 0
                    self.is_manufacture_table = false
                }
            self.view.layoutIfNeeded()
        }
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
                    motorbikes.append(moto!)
                }
                
            }
        })
    }
    
    
    @IBAction func imageProcessing(_ sender: UITapGestureRecognizer) {
            //Hide the Keyboard
//        edtMealName.resignFirstResponder()
        //Create an object of ImagePickerControlelr
        let imagePickerController = UIImagePickerController()
        //Setup the properties for the imagePickerControler
        imagePickerController.sourceType = .photoLibrary
        //Delegation of ImagePickerController
        imagePickerController.delegate = self
        //show the imagepickercontroler to the screen
        present(imagePickerController, animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //get the image from the imagePickerController
        if let selectedImage = info[.originalImage] as? UIImage{
            imagemotor.image = selectedImage
        }
        //hide ther imagePickerController
        dismiss(animated: true, completion: nil)
    }
}
