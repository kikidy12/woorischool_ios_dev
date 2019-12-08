//
//  SchoolTableViewCell.swift
//  woorischool
//
//  Created by 권성민 on 2019/12/02.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class SchoolTableViewCell: UITableViewCell {
    
    var school: SchoolData!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func initView(_ data: SchoolData) {
        school = data
        layoutIfNeeded()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        nameLabel.text = school.name
    }
}
