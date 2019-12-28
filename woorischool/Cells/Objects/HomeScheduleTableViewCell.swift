//
//  HomeScheduleTableViewCell.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/29.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class HomeScheduleTableViewCell: UITableViewCell {
    
    var classDayData: ScheduleData!
    
    @IBOutlet weak var eduTimeLabel: UILabel!
    @IBOutlet weak var lectureNameLabel: UILabel!
    @IBOutlet weak var classNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func initView(_ data: ScheduleData) {
        classDayData = data
        guard let lectureClass = classDayData.lectureClass else {
            backgroundColor = .white
            
            contentView.subviews.forEach {
                $0.isHidden = true
            }
            
            return
        }
        
        let color = getRandomColor()
        backgroundColor = color.withAlphaComponent(0.2)
        eduTimeLabel.textColor = color
        
        contentView.subviews.forEach {
            if let label = $0 as? UILabel {
                label.textColor = color
                label.isHidden = false
            }
        }
        
        eduTimeLabel.text = "\(classDayData.eduTime ?? "00:00-00:00")"
        lectureNameLabel.text = "\(lectureClass.lecture?.name ?? "강좌")"
        classNameLabel.text = "\(lectureClass.name ?? "강의실")"
        
        
    }
    
    func getRandomColor() -> UIColor {
            
            let randomRed:CGFloat = CGFloat(drand48())
            
            let randomGreen:CGFloat = CGFloat(drand48())
            
            let randomBlue:CGFloat = CGFloat(drand48())
            
            return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
}
