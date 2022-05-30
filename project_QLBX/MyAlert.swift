//
//  MyAlert.swift
//  project_QLBX
//
//  Created by Tinh12722 on 5/29/22.
//  Copyright © 2022 Tinh12722. All rights reserved.
//

import UIKit
class MyAlert {
    
    struct Constants {
        static let backgroundAlphaTo: CGFloat = 0.6
    }
    
    private let backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0
        return backgroundView
    }()
    
    private let alertView: UIView = {
        let alert = UIView()
        alert.backgroundColor = .white
        alert.layer.masksToBounds = true
        alert.layer.cornerRadius = 12
        return alert
        
    }()
    
    private var mytargetView: UIView?
    
    func shopAlert(with title: String, message: String, on ViewController: UIViewController){
        guard let targetView = ViewController.view else {
            return
        }
        mytargetView = targetView
        backgroundView.frame =  targetView.bounds
        targetView.addSubview(backgroundView)
        targetView.addSubview(alertView)
    alertView.frame = CGRect(x: 40, y: -300, width: targetView.frame.size.width - 80, height: 300)
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: alertView.frame.size.width, height: 80))
        
        
        titleLabel.text = title
        titleLabel.textAlignment = .center
        alertView.addSubview(titleLabel)
        
        
        let messsgeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: alertView.frame.size.width, height: 170))
        
        messsgeLabel.numberOfLines = 0
        messsgeLabel.text = message
        messsgeLabel.textAlignment = .left
        
        alertView.addSubview(messsgeLabel)
        
        let button = UIButton(frame: CGRect(x: 0, y: alertView.frame.size.height - 50, width: alertView.frame.width, height: 50))
        
        
        
        button.setTitle("OK", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        alertView.addSubview(button)
        
        
        UIView.animate(withDuration: 0.25, animations: {
            self.backgroundView.alpha = Constants.backgroundAlphaTo
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.25, animations: {
                    self.alertView.center = targetView.center
                })
            }
        })
    }
    
    @objc func dismissAlert(){
        guard let targetView = mytargetView else {
            return
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            self.alertView.frame = CGRect(x: 40, y: targetView.frame.size.height, width: targetView.frame.size.width - 80, height: 300)
            
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.25, animations: {
                    self.alertView.center = targetView.center
                },completion: { done in
                    if done {
                        self.alertView.removeFromSuperview()
                        self.backgroundView.removeFromSuperview()
                    }
                })
            }
        })
    }
}
