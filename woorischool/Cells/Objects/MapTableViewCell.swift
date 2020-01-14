//
//  MapTableViewCell.swift
//  woorischool
//
//  Created by 권성민 on 2020/01/14.
//  Copyright © 2020 beanfactory. All rights reserved.
//

import UIKit

class MapTableViewCell: UITableViewCell {
    
    var academy: AcademyData! {
        didSet {
            nameLabel.text = academy.name
            addressLabel.text = academy.address
            categoryLabel.text = academy.category.name
            if let distance = academy.location?.distance(to: GlobalDatas.currentUser.childlen.school.location) {
                distanceLabel.text = "\(distance.toFloorString() ?? "0")m"
            }
            else {
                
            }
        }
    }

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
