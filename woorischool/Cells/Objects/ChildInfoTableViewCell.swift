//
//  ChildInfoTableViewCell.swift
//  woorischool
//
//  Created by 권성민 on 2019/12/22.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class ChildInfoTableViewCell: UITableViewCell {
    
    var student: UserData!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var studentSchoolInfoLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func initView(_ data: UserData) {
        student = data
        layoutIfNeeded()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        if let urlStr = student.profileImage {
            profileImageView.kf.setImage(with: URL(string: urlStr), placeholder: UIImage(named: "profilePlaceHolder"))
        }
        else {
            profileImageView.image = UIImage(named: "profilePlaceHolder")
        }
        nameLabel.text = student.name
        studentSchoolInfoLabel.text = "\(student.studentInfo?.grade ?? 1)학년 \(student.studentInfo?.classNumber ?? 0)반 \(student.studentInfo?.number ?? 0)번"
        pointLabel.text = "\(student.point.decimalString ?? "0") 원"
    }
}
