//
//  ParentContractTableViewCell.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/27.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class ParentContractTableViewCell: UITableViewCell {
    
    var chatClouser: (()->())!
    var callClouser: (()->())!
    
    
    @IBOutlet weak var phoneNumLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func callEvent() {
        callClouser()
    }
    
    @IBAction func showChatEvent() {
        chatClouser()
    }
    
}
