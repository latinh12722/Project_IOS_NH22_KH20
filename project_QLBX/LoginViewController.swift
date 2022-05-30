//
//  LoginViewController.swift
//  project_QLBX
//
//  Created by Tinh12722 on 5/17/22.
//  Copyright © 2022 Tinh12722. All rights reserved.
//

import UIKit
class LoginViewController: UIViewController {
    var sql = DatabaseLayer()
    var alert = MyAlert()
    @IBOutlet weak var tfpassword: UITextField!
    @IBOutlet weak var tfusername: UITextField!
    @IBOutlet weak var btnlogin:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func dimiss_login(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func tapOnRegister(_ sender: Any) {
        let vc = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        vc.modalPresentationStyle =  .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func login(_ sender: Any) {
        if sql.checklogin(username: tfusername.text!, password: tfpassword.text!) == 2{
            self.showToast(message: "Tài khoản / mật khẩu sai", font: .systemFont(ofSize: 12.0))
        }else{
                self.showToast(message: "Đăng nhập thành công", font: .systemFont(ofSize: 12.0))
                self.showSpinner()
                Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (t) in
                    
                    self.removeSpinner()
                    self.dismiss(animated: true, completion: nil)
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


