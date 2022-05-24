//
//  AdminViewController.swift
//  project_QLBX
//
//  Created by Tinh12722 on 5/19/22.
//  Copyright © 2022 Tinh12722. All rights reserved.
//

import UIKit

class AdminViewController: UIViewController , UITableViewDataSource , UITableViewDelegate{

    @IBOutlet weak var tbadmin: UITableView!
    @IBOutlet weak var lbnameadmin: UILabel!
    var danhsach:[String] = ["Bill","Motorbikes","Manufactures","Protypes","User"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbadmin.delegate = self
        tbadmin.dataSource = self
        lbnameadmin.text = "Admin: " + login_user
        // Do any additional setup after loading the view.
    }
    @IBAction func tapOnlogout(_ sender: Any) {
        login_admin = ""
        self.dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return danhsach.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbadmin.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = danhsach[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        clickitem(index: indexPath.row)
       
        
    }
    func clickitem(index:Int) {
        print(index)
    }
}
