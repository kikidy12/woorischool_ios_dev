//
//  RegistClassTableViewCell.swift
//  woorischool
//
//  Created by 권성민 on 04/10/2019.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class RegistClassTableViewCell: UITableViewCell {
    @IBOutlet weak var countLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func initView(_ count: Int) {
        let totalCount = 20
        let userCount = count
        let attributedString = NSMutableAttributedString(string: "\(userCount)/\(totalCount)", attributes: [
            .font: UIFont(name: "NotoSansCJKkr-Medium", size: 17.0)!,
            .foregroundColor: UIColor.greyishBrown,
            .kern: 0.0
            ])
        attributedString.addAttribute(.foregroundColor, value: UIColor.grapefruit, range: NSRange(location: 0, length: "\(userCount)".count))
        
        countLabel.attributedText = attributedString
    }
}
