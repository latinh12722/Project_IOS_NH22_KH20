//
//  ManufactureManagerViewController.swift
//  project_QLBX
//
//  Created by Tinh12722 on 5/26/22.
//  Copyright © 2022 Tinh12722. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class ManufactureManagerViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    var ref: DatabaseReference!
    var nameimage : String = ""
		
    @IBOutlet weak var btnchonanh: UIButton!
    
    @IBOutlet weak var btnxoa: UIButton!
    @IBOutlet weak var btnsua: UIButton!
    @IBOutlet weak var btnthem: UIButton!
    @IBOutlet weak var tfmanuname: UITextField!
    @IBOutlet weak var lbmanuid: UILabel!
    @IBOutlet weak var imagemanu: UIImageView!
    @IBOutlet weak var tbmanu: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tbmanu.dataSource = self
        tbmanu.delegate = self
        tbmanu.register(UINib(nibName: "ManuManagerTableViewCell", bundle: nil), forCellReuseIdentifier: "ManuManagerTableViewCell")
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageProcessing))
        imagemanu.addGestureRecognizer(tap)
        imagemanu.isUserInteractionEnabled = true
        btnchonanh.addGestureRecognizer(tap)
        btnchonanh.isUserInteractionEnabled = true
        tfmanuname.delegate = self
        tfmanuname.returnKeyType = .done
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func dimiss_manu(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
   
    @IBAction func btndatlai(_ sender: Any) {
        tfmanuname.text = ""
        lbmanuid.text = "ID: "
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbmanu.dequeueReusableCell(withIdentifier: "ManuManagerTableViewCell", for: indexPath) as! ManuManagerTableViewCell
        
        cell.setvalue_manu(manu: manus[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lbmanuid.text = manus[indexPath.row].manu_id
        tfmanuname.text = manus[indexPath.row].manu_name
        if !manus[indexPath.row].image.isEmpty {
            let imageData = Data(base64Encoded: manus[indexPath.row].image, options: .ignoreUnknownCharacters)!
            imagemanu.image = UIImage(data: imageData)
            
        }
        imagemanu.layer.zPosition = 20
    }
    @IBAction func btnthem(_ sender: Any) {
        if nameimage != "" {
            ref = Database.database().reference().child("manufactures")
            var imageString = ""
            if let image = imagemanu.image {
                let imageNSData = image.pngData()! as NSData
                imageString = imageNSData.base64EncodedString(options: .lineLength64Characters)
            }
            
            let k = ref.childByAutoId().key
            
            let manu = ["manu_id": k as Any,
                        "manu_name": tfmanuname.text as Any,
                        "image": imageString
            ]
            ref.child(String(k!)).setValue(manu)
            self.showSpinner()
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (t) in
                self.getdata_manu()
                self.tbmanu.reloadData()
                self.removeSpinner()
            }
        }
        
    }
    @IBAction func btnsua(_ sender: Any) {
        let id = lbmanuid.text
        ref = Database.database().reference().child("manufactures")
        
        var imageString = ""
        if let image = imagemanu.image {
            let imageNSData = image.pngData()! as NSData
            imageString = imageNSData.base64EncodedString(options: .lineLength64Characters)
        }
        
        ref.child(id!).setValue(["manu_id": id as Any ,
                                 "manu_name": tfmanuname.text as Any ,
                                "image": imageString])
        
        
        self.showSpinner()
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (t) in
            self.getdata_manu()
            self.tbmanu.reloadData()
            self.removeSpinner()
        }
        self.showToast(message: "Sửa thành công", font: .systemFont(ofSize: 12.0))
        
    }
    @IBAction func btnxoa(_ sender: Any) {
        let id = lbmanuid.text
        ref = Database.database().reference().child("manufactures")
        ref.child(id!).removeValue()
        
        
        self.showSpinner()
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (t) in
            self.getdata_manu()
            self.tbmanu.reloadData()
            self.removeSpinner()
        }
        self.showToast(message: "Xoá thành công", font: .systemFont(ofSize: 12.0))
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
       
        imagemanu.image = selectedImage
        imagemanu.layer.zPosition = 10
    }
            //hide ther imagePickerController
        dismiss(animated: true, completion: nil)
    }
}
