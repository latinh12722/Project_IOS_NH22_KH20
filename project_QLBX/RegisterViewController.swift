//
//  RegisterViewController.swift
//  project_QLBX
//
//  Created by Tinh12722 on 5/19/22.
//  Copyright © 2022 Tinh12722. All rights reserved.
//

import UIKit
import FirebaseDatabase
class RegisterViewController: UIViewController {

    var ref = Database.database().reference().child("user")
    @IBOutlet weak var tfusername: UITextField!
    @IBOutlet weak var tfpassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func cancel_register(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapOnRegister(_ sender: Any) {
        let key:String = tfusername.text!
        ref.queryOrdered(byChild: "username").queryEqual(toValue: key).observe(DataEventType.value, with: { (Snapshot) in
            
            if Snapshot.childrenCount != 1 && key.count == 8{
                let user = [
                    "username" : key,
                    "password" : self.tfpassword.text as Any
                    ] as [String : Any]
                
                
                self.ref.child(key).setValue(user)
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
