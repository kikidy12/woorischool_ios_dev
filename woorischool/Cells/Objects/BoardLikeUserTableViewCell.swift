//
//  BoardLikeUserTableViewCell.swift
//  woorischool
//
//  Created by 권성민 on 2019/12/24.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class BoardLikeUserTableViewCell: UITableViewCell {
    var user: UserData! {
        didSet {
            profileImageView.image = user.profileImage
            nameLabel.text = user.name
        }
    }
    
    @IBOutlet weak var profileImageView: CustomImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
