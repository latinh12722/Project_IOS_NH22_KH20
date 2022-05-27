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
    }

    @IBAction func dimiss_manu(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
   
    @IBAction func btndatlai(_ sender: Any) {
        tfmanuname.text = ""
        lbmanuid.text = ""
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
        imagemanu.image = UIImage(named: manus[indexPath.row].image)
    }
    @IBAction func btnthem(_ sender: Any) {
        print(imagemanu.image)
//        ref = Database.database().reference().child("manufactures")
//        let k = ref.childByAutoId().key
//        let manu = ["manu_id":k as Any,
//                    "manu_name": tfmanuname,
//                    "image": imagemanu.image?.
//        ]
//        ref.child(String(k!)).setValue(manu)
    }
    @IBAction func btnsua(_ sender: Any) {
        
    }
    @IBAction func btnxoa(_ sender: Any) {
        
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
    }
            //hide ther imagePickerController
        dismiss(animated: true, completion: nil)
    }
}
