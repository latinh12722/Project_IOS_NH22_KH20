//
//  ManuManagerTableViewCell.swift
//  project_QLBX
//
//  Created by Tinh12722 on 5/27/22.
//  Copyright © 2022 Tinh12722. All rights reserved.
//

import UIKit

class ManuManagerTableViewCell: UITableViewCell {
    @IBOutlet weak var imagemanu: UIImageView!
    
    @IBOutlet weak var lbmanuname: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func setvalue_manu(manu:manufacture) {
        lbmanuname.text = manu.manu_name
        if !manu.image.isEmpty {
            let imageData = Data(base64Encoded: manu.image, options: .ignoreUnknownCharacters)!
            imagemanu.image = UIImage(data: imageData)
        }
    }
}
