//
//  DailyNoteTableViewCell.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/14.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit
import Kingfisher

class DailyNoteTableViewCell: UITableViewCell {
    
    var note: DailyNoteData!

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var createTimeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var prepareLabel: UILabel!
    @IBOutlet weak var homeworkLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initView(_ data: DailyNoteData) {
        note = data
        guard let schdule = note.lectureSchedule else {
            return
        }
        dateLabel.text = schdule.date.dateToString(formatter: "MM월 dd일자 알림장")
        createTimeLabel.text = note.writeTime ?? "미확인"
        contentLabel.text = note.content ?? "없음"
        
        if let imageURL = note.imageList.first?.url {
            mainImageView.isHidden = false
            mainImageView.kf.setImage(with: imageURL, placeholder: UIImage(named: "tempImage"), options: [.transition(.fade(1))])
        }
        else {
            mainImageView.isHidden = true
        }
        
        prepareLabel.text = note.materials ?? "없음"
        homeworkLabel.text = note.homework ?? "없음"
    }
}
