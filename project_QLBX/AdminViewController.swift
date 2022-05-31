//
//  AdminViewController.swift
//  project_QLBX
//
//  Created by Tinh12722 on 5/26/22.
//  Copyright © 2022 Tinh12722. All rights reserved.
//

import UIKit

class AdminViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    

    @IBOutlet weak var tbvadmin: UITableView!
    @IBOutlet weak var lbnameadmin: UILabel!
    var danhsach:[String] = ["Đơn hàng","Xe","Hãng xe","Loại xe"]
    var btn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        lbnameadmin.text = "Admin: " + login_user
        danhsach = ["Đơn hàng","Xe","Hãng xe","Loại xe"]
        tbvadmin.delegate = self
        tbvadmin.dataSource = self
        let nib = UINib(nibName: "AdminTableViewCell", bundle: nil)
        tbvadmin.register(nib, forCellReuseIdentifier: "AdminTableViewCell")
        
        // Do any additional setup after loading the view.
    }
    @IBAction func logout(_ sender: Any) {
        login_admin = ""
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return danhsach.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbvadmin.dequeueReusableCell(withIdentifier: "AdminTableViewCell", for: indexPath)as! AdminTableViewCell
        cell.lbname.text = danhsach[indexPath.row]
        cell.layer.cornerRadius = 10
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row == 1{
//            let vc = MotorbikeManagerViewController()
//            vc.modalPresentationStyle = .fullScreen
//            self.present(vc, animated: true, completion: nil)
//        }
//        if indexPath.row == 3 {
//            let vc = ProtypesManagerViewController()
//            vc.modalPresentationStyle = .fullScreen
//            self.present(vc, animated: true, completion: nil)
//        }
        switch indexPath.row {
        case 0:
            let vc = BillsManagerViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        case 1:
            let vc = MotorbikeManagerViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        case 2:
            let vc = ManufactureManagerViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        case 3:
            let vc = ProtypesManagerViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        default:
            print(indexPath.row)
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
