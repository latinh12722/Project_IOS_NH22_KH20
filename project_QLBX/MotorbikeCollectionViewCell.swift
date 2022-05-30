//
//  MotorbikeCollectionViewCell.swift
//  project2
//
//  Created by TinhNe on 5/15/22.
//  Copyright © 2022 TinhNe. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class MotorbikeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var image_hang: UIImageView!
    
    @IBOutlet weak var name_motorbike: UILabel!
    @IBOutlet weak var nsx_motorbike: UILabel!
    @IBOutlet weak var price_motorbike: UILabel!
    var ref:DatabaseReference!
    
    
    func setup(with moto: Motorbike) {
        ref = Database.database().reference().child("manufactures")
        
        if !moto.image.isEmpty {
            let imageData = Data(base64Encoded: moto.image, options: .ignoreUnknownCharacters)!
            image.image = UIImage(data: imageData)
        }
        
        
        if !getmanu(id: moto.manu_id).image.isEmpty {
            let imageData = Data(base64Encoded: getmanu(id: moto.manu_id).image, options: .ignoreUnknownCharacters)!
            image_hang.image = UIImage(data: imageData)
        }
        name_motorbike.text = moto.name
        nsx_motorbike.text = " " + String(moto.nsx) + " "
        
        nsx_motorbike.layer.cornerRadius = 5
        
        
        price_motorbike.text = df2so(Double(moto.price)) + "đ"
        nsx_motorbike.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        nsx_motorbike.layer.borderWidth = 0.5
        nsx_motorbike.clipsToBounds = true
        
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
    func getmanu(id:String) -> manufacture {
        for manu in manus{
            if manu.manu_id.elementsEqual(id){
                return manu
            }
        }
        return manufacture(manu_id: "", manu_name: "", image: "")!
    }
}
