//
//  CustomPageControl.swift
//  fifteensecond
//
//  Created by 권성민 on 08/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class CustomPageControl: UIPageControl {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard !subviews.isEmpty else { return }
        
        let spacing: CGFloat = 10
        
        let longWidth: CGFloat = 26
        
        let shortWidth: CGFloat = 8
        
        let height: CGFloat = 8
        
        var total: CGFloat = 0
        
        for view in subviews.enumerated() {
            view.element.layer.cornerRadius = 4
            if view.offset == self.currentPage {
                view.element.frame = CGRect(x: total, y: frame.size.height / 2 - height / 2, width: longWidth, height: height)
                total += longWidth + spacing
            }
            else {
                view.element.frame = CGRect(x: total, y: frame.size.height / 2 - height / 2, width: shortWidth, height: height)
                total += shortWidth + spacing
            }
        }
        
        total -= spacing
        
        frame.origin.x = frame.origin.x + frame.size.width / 2 - total / 2
        frame.size.width = total
    }
}
