//
//  HomeScheduleTableViewCell.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/29.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class HomeScheduleTableViewCell: UITableViewCell {
    
    var classDayData: TestData!
    
    @IBOutlet weak var eduTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func initView(_ data: TestData) {
        classDayData = data
        let eduTimeStr = "11:30-13:00\n"
        let lectureNameStr = "창의교실"
        let locationStr = "\n\n2-1"
        let attributedString = NSMutableAttributedString(string: "\(eduTimeStr)\(lectureNameStr)\(locationStr)", attributes: [
          .font: UIFont(name: "NotoSansCJKkr-Regular", size: 8.0)!
        ])
        attributedString.addAttribute(.font, value: UIFont(name: "NotoSansCJKkr-Medium", size: 10.0)!, range: NSRange(location: 12, length: lectureNameStr.count))
        
        if classDayData.id == nil {
            backgroundColor = .white
            eduTimeLabel.isHidden = true
        }
        else {
            eduTimeLabel.isHidden = false
            eduTimeLabel.attributedText = attributedString
            
            let color = getRandomColor()
            backgroundColor = color.withAlphaComponent(0.2)
            eduTimeLabel.textColor = color
        }
    }
    
    func getRandomColor() -> UIColor {
            
            let randomRed:CGFloat = CGFloat(drand48())
            
            let randomGreen:CGFloat = CGFloat(drand48())
            
            let randomBlue:CGFloat = CGFloat(drand48())
            
            return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
}
