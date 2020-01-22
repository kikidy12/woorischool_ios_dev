//
//  RatingMessagePopupViewController.swift
//  woorischool
//
//  Created by 권성민 on 2020/01/20.
//  Copyright © 2020 beanfactory. All rights reserved.
//

import UIKit

class RatingMessagePopupViewController: UIViewController {
    
    var lectureClass: LectureClassData!
    var rating: RatingData!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = "\(lectureClass.lecture.name ?? "강의명") \(lectureClass.name ?? "클래스명")"
        contentTextView.text = rating.content
    }
}
