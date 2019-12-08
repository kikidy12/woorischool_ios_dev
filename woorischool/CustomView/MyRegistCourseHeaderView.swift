//
//  MyRegistCourseHeaderView.swift
//  woorischool
//
//  Created by 권성민 on 2019/12/05.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class MyRegistCourseHeaderView: UIView {
    
    var quater: QuaterData!

    private let xibName = "MyRegistCourseHeaderView"
    
    @IBOutlet weak var quaterNameLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    private func commonInit(){
        let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func initView(_ data: QuaterData) {
        quater = data
        layoutIfNeeded()
    }

    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        quaterNameLabel.text = "\(quater.years ?? 1900)년 \(quater.quarter ?? "미확인")"
        periodLabel.text = quater.quaterPeriodStr
    }
}
