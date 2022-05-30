//
//  SearchViewController.swift
//  project_QLBX
//
//  Created by Tinh12722 on 5/17/22.
//  Copyright © 2022 Tinh12722. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate,UISearchBarDelegate{

    @IBOutlet weak var btnsearch: UIButton!
    @IBOutlet weak var tfsearch: UISearchBar!
    var keyword:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        btnsearch.layer.cornerRadius = 10
        
        tfsearch.delegate = self
        tfsearch.returnKeyType = .done
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    @IBAction func dismissSearch(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        self.tfsearch.endEditing(true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let btn = sender as? UIButton {
            if btn === btnsearch {
                keyword = tfsearch.text!
            }
        }
    }
  

}
