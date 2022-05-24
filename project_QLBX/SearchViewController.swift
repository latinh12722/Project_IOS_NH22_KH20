//
//  SearchViewController.swift
//  project_QLBX
//
//  Created by Tinh12722 on 5/17/22.
//  Copyright © 2022 Tinh12722. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var btnsearch: UIButton!
    @IBOutlet weak var tfsearch: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnsearch.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismissSearch(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
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
