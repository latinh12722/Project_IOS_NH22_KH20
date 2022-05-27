//
//  ProtypesManagerViewController.swift
//  project_QLBX
//
//  Created by Tinh12722 on 5/26/22.
//  Copyright © 2022 Tinh12722. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class ProtypesManagerViewController: UIViewController ,
UITableViewDelegate, UITableViewDataSource {
    
    var ref: DatabaseReference!
    @IBOutlet weak var tftypename: UITextField!
    @IBOutlet weak var lbtypeid: UILabel!
    @IBOutlet weak var tbprotype: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tbprotype.dataSource = self
        tbprotype.delegate = self
        tbprotype.register(UINib(nibName: "AdminTableViewCell", bundle: nil), forCellReuseIdentifier: "AdminTableViewCell")
    }


    @IBAction func dissmiss(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func btndatlai(_ sender: Any) {
        lbtypeid.text = ""
        tftypename.text = ""
        self.showSpinner()
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (t) in
            self.getdata_type()
            self.tbprotype.reloadData()
            self.removeSpinner()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbprotype.dequeueReusableCell(withIdentifier: "AdminTableViewCell", for: indexPath) as!
        AdminTableViewCell
        cell.lbname.text
            = types[indexPath.row].type_name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tftypename.text = types[indexPath.row].type_name
        lbtypeid.text = types[indexPath.row].type_id
    }
   
    @IBAction func adddata_protype(_ sender: Any) {
        ref = Database.database().reference().child("protypes")
        let k = ref.childByAutoId().key
        let type = [
            "type_id":k as Any,
            "type_name": tftypename.text!
        ]
        ref.child(String(k!)).setValue(type)
        
        
     
        self.showSpinner()
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (t) in
            self.getdata_type()
            self.tbprotype.reloadData()
            self.removeSpinner()
        }
        self.showToast(message: "Thêm thành công", font: .systemFont(ofSize: 12.0))
    }
    @IBAction func update_protype(_ sender: Any) {
        let id = lbtypeid.text
        ref = Database.database().reference().child("protypes")
        ref.child(id!).setValue(["type_id": id , "type_name": tftypename.text])
        
        
        self.showSpinner()
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (t) in
            self.getdata_type()
            self.tbprotype.reloadData()
            self.removeSpinner()
        }
        self.showToast(message: "Sửa thành công", font: .systemFont(ofSize: 12.0))
    }
    @IBAction func remove_protype(_ sender: Any) {
        let id = lbtypeid.text
        ref = Database.database().reference().child("protypes")
        ref.child(id!).removeValue()
        
        
        self.showSpinner()
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (t) in
            self.getdata_type()
            self.tbprotype.reloadData()
            self.removeSpinner()
        }
        self.showToast(message: "Xoá thành công", font: .systemFont(ofSize: 12.0))
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
    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

