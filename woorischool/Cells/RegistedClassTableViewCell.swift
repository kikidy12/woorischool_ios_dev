//
//  RegistedClassTableViewCell.swift
//  woorischool
//
//  Created by 권성민 on 04/10/2019.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class RegistedClassTableViewCell: UITableViewCell {
    @IBOutlet weak var applyBtn: CustomButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func initView(_ isWating: Bool) {
        if isWating {
            applyBtn.isHidden = true
        }
        else {
            applyBtn.isHidden = false
        }
    }
}
