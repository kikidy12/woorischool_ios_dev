//
//  StudentContactTableViewCell.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/27.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class StudentContactTableViewCell: UITableViewCell {
    
    var student: UserData!
    
    var contactParentClouser: (()->())!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var studentInfoLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func callParentEvnet() {
        contactParentClouser()
    }
    
    @IBAction func callStudentEvent() {
        guard let url = URL(string: "tel://\(student.phoneNum ?? "")") else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func initView(_ data: UserData) {
        student = data
        
        nameLabel.text = "\(student.name ?? "익명")"
        
        guard let info = student.studentInfo else { return }
        studentInfoLabel.text = "\(info.grade ?? 0)학년 \(info.classNumber ?? 0)반 \(info.number ?? 0)번"
    }
}
