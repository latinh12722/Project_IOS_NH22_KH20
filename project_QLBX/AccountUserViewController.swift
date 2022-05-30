//
//  AccountUserViewController.swift
//  project_QLBX
//
//  Created by Tinh12722 on 5/30/22.
//  Copyright © 2022 Tinh12722. All rights reserved.
//

import UIKit

class AccountUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var lbsdt: UILabel!
    var danhsach:[String] = ["Đơn hàng đã mua","Đăng xuất"]
    @IBOutlet weak var tbdanhsach: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tbdanhsach.delegate = self
        tbdanhsach.dataSource = self
        tbdanhsach.register(UINib(nibName: "AdminTableViewCell", bundle: nil), forCellReuseIdentifier: "AdminTableViewCell")
        lbsdt.text = login_user
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return danhsach.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbdanhsach.dequeueReusableCell(withIdentifier: "AdminTableViewCell", for: indexPath) as! AdminTableViewCell
        cell.lbname.text = danhsach[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 1){
            login_user = ""
            dismiss(animated: true, completion: nil)
        }
    }
}
