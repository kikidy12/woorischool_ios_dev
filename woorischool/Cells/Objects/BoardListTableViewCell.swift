//
//  BoardListTableViewCell.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/01.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class BoardListTableViewCell: UITableViewCell {
    
    var lectureClass: LectureClassData!

    @IBOutlet weak var isNewLabel: CustomLabel!
    @IBOutlet weak var teacherNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var userCountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initView(_ data: LectureClassData) {
        lectureClass = data
        if lectureClass.isTodayWrite {
            isNewLabel.isHidden = false
        }
        else {
            isNewLabel.isHidden = true
        }
        
        if let urlStr = lectureClass.boardIconUrl {
            titleImageView.kf.setImage(with: URL(string: urlStr))
        }
        else {
            titleImageView.image = UIImage(named: "tempEmptyImage")
        }
        
        nameLabel.text = "\(lectureClass.lecture?.name ?? "강의") \(lectureClass.name ?? "클래스")"
        teacherNameLabel.text = lectureClass.teacher?.name ?? "익명"
        userCountLabel.text = "\(lectureClass.confirmCount ?? 0)명"
    }
    
}
