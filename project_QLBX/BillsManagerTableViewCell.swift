//
//  BillsManagerTableViewCell.swift
//  project_QLBX
//
//  Created by Tinh12722 on 5/30/22.
//  Copyright © 2022 Tinh12722. All rights reserved.
//

import UIKit

class BillsManagerTableViewCell: UITableViewCell {

    @IBOutlet weak var lbtime: UILabel!
    @IBOutlet weak var lbsdt: UILabel!
    @IBOutlet weak var lbmotorname: UILabel!
    @IBOutlet weak var lbname: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func setvaluecell(bill: Bill) {
        lbname.text = bill.name
        lbmotorname.text = getmotor_byid(motor_id: bill.motor_id).name
        lbsdt.text = bill.phone
        lbtime.text = convertTimestamp(serverTimestamp: bill.timestamp)
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
