//
//  CourseCollectionViewCell.swift
//  woorischool
//
//  Created by 권성민 on 03/10/2019.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class CourseCollectionViewCell: UICollectionViewCell {
    
    var course: LectureAreaData!
    
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var containerView: CustomView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func initView(_ data: LectureAreaData) {
        course = data
        courseLabel.text = course.name
        if course.isSelected {
            courseLabel.textColor = .white
            containerView.backgroundColor = .greenishTeal
            containerView.borderWidth = 0
        }
        else {
            courseLabel.textColor = .greyishBrown
            containerView.backgroundColor = .white
            containerView.borderWidth = 1
        }
    }

}