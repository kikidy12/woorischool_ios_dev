//
//  MyClassRecordTableViewCell.swift
//  woorischool
//
//  Created by 권성민 on 2019/12/05.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class MyClassRecordTableViewCell: UITableViewCell {
    
    var lectureClass: LectureClassData!

    @IBOutlet weak var classNameLabel: UILabel!
    @IBOutlet weak var teacherNameLabel: UILabel!
    
    
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
        
        layoutIfNeeded()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        classNameLabel.text = "\(lectureClass.lecture?.name ?? "강의명") \(lectureClass.name ?? "클래스명")"
        teacherNameLabel.text = "\(lectureClass.teacher?.name ?? "익명")"
    }
}
