//
//  MotorManagerTableViewCell.swift
//  project_QLBX
//
//  Created by Tinh12722 on 5/26/22.
//  Copyright © 2022 Tinh12722. All rights reserved.
//

import UIKit

class MotorManagerTableViewCell: UITableViewCell {

    @IBOutlet weak var lbpk: UILabel!
    @IBOutlet weak var lbprice: UILabel!
    @IBOutlet weak var lbloaixe: UILabel!
    @IBOutlet weak var lbhang: UILabel!
    @IBOutlet weak var lbname: UILabel!
    @IBOutlet weak var imagemotor: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setvalue_motor(moto: Motorbike){
        lbname.text = moto.name
        lbprice.text = df2so(Double(moto.price)) + " đ"
        lbhang.text = getnamemanu(id: moto.manu_id)
        lbloaixe.text = getnametype(id: moto.type_id)
        lbpk.text = String(moto.cubic_meter)
        imagemotor?.image = UIImage(named: moto.image)
        imagemotor.contentMode = .scaleAspectFill
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
}
