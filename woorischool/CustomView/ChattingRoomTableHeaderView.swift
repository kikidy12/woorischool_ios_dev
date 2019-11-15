//
//  ChattingRoomTableHeaderView.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/08.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class ChattingRoomTableHeaderView: UIView {
    
    var manageColuser: (()->())!
    
    @IBOutlet weak var timeInfoLabel: UILabel!
    @IBOutlet weak var manageTimeBtn: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    private func commonInit(){
        let view = Bundle.main.loadNibNamed("ChattingRoomTableHeaderView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    @IBAction func showManageChattingTimeEvent() {
        manageColuser()
    }
}
