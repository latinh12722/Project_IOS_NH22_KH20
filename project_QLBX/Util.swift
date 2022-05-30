//
//  Util.swift
//  project_QLBX
//
//  Created by Tinh12722 on 5/27/22.
//  Copyright © 2022 Tinh12722. All rights reserved.
//

import UIKit


fileprivate var aView : UIView?
extension UIViewController {
    func showSpinner() {
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView(style: .whiteLarge)
        ai.center = aView!.center
        ai.startAnimating()
        aView?.addSubview(ai)
        self.view.addSubview(aView!)
    }
    func removeSpinner(){
        aView?.removeFromSuperview()
        aView = nil
    }
    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func getnamemanu(id:String) -> String {
        for manu in manus{
            if manu.manu_id.elementsEqual(id){
                return manu.manu_name
            }
        }
        return ""
    }
    func getnametype(id:String) -> String {
        for type in types{
            if type.type_id == id{
                return type.type_name
            }
        }
        return ""
    }
    func df2so(_ price: Double) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.decimalSeparator = "."
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: price as NSNumber)!
    }
    func checknumber_kam(x:String) -> Bool {
        if x.isNumber(){
            if Int(x)! > 0 {
                return true
            }
        }
        return false
    }
    func getmanu(id:String) -> manufacture {
        for manu in manus{
            if manu.manu_id.elementsEqual(id){
                return manu
            }
        }
        return manufacture(manu_id: "", manu_name: "", image: "")!
    }
    func getmotor_byid(motor_id:String) -> Motorbike {
        for moto in motorbikes {
            if motor_id == moto.id{
                return moto
            }
        }
    return Motorbike(id: "", name: "", price: 1, type_id: "", manu_id: "", brake: "", fuel: "", transmission: "", engine: "", cubic_meter: 1, image: "", nsx: 1)
    }
    func convertTimestamp(serverTimestamp: Double) -> String {
        let x = serverTimestamp / 1000
        let date = NSDate(timeIntervalSince1970: x)
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium

        return formatter.string(from: date as Date)
    }
}
public extension String {
func isNumber() -> Bool {
    return !self.isEmpty && self.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil && self.rangeOfCharacter(from: CharacterSet.letters) == nil
}}
extension String {
   var isValidPhone: Bool {
      let regularExpressionForPhone = "^\\d{3}\\d{3}\\d{4}$"
      let testPhone = NSPredicate(format:"SELF MATCHES %@", regularExpressionForPhone)
      return testPhone.evaluate(with: self)
   }
}
