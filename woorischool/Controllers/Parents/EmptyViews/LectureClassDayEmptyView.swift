//
//  LectureClassDayEmptyView.swift
//  woorischool
//
//  Created by 권성민 on 2019/12/08.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class LectureClassDayEmptyView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    private func commonInit(){
        let view = Bundle.main.loadNibNamed("\(type(of: self))", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
}
