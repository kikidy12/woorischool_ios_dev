//
//  ChildTableViewCell.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/15.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class ChildTableViewCell: UITableViewCell {
    
    var child : UserData!
    
    var deleteClouser: (()->())!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteChild() {
        deleteClouser()
    }
    
    
    func initView(_ data: UserData) {
        child = data
        
        nameLabel.text = child.name
        infoLabel.text = "\(child.studentInfo?.grade ?? 1)학년 \(child.studentInfo?.classNumber ?? 0)반 \(child.studentInfo?.number ?? 0)번"
        
        pointLabel.text = "\(child.point.decimalString ?? "0") 원"
    }
}
