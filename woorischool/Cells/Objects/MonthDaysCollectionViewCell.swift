//
//  MonthDaysCollectionViewCell.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/28.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class MonthDaysCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weekDayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func initView(_ date: Date) {
        dateLabel.text = "\(Calendar.current.component(.day, from: date))"
        
        weekDayLabel.text = date.dayStringOfWeek()
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.subviews.first?.backgroundColor = .greenishTeal
                dateLabel.textColor = .white
                weekDayLabel.textColor = .white
            }
            else {
                contentView.subviews.first?.backgroundColor = .white
                dateLabel.textColor = .greyishBrown
                weekDayLabel.textColor = .greyishBrown
            }
        }
    }
}
