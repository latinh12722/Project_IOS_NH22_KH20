//
//  MotorDetailViewController.swift
//  project_QLBX
//
//  Created by Tinh12722 on 5/27/22.
//  Copyright © 2022 Tinh12722. All rights reserved.
//

import UIKit

class MotorDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func account(_ sender: Any) {
        if login_user != "" {
        //            let navigation = UINavigationController(rootViewController: logincontroller)
        //            self.view.addSubview(navigation.view)
        //            self.addChild(navigation)
        //            navigation.didMove(toParent: self)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
