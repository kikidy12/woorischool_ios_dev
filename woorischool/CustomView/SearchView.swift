//
//  SearchView.swift
//  woorischool
//
//  Created by 권성민 on 2019/12/02.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

protocol SearchViewDelegate {
    func chageText(_ text: String)
}

class SearchView: UIView {

    var delegate:SearchViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    func initView() {
        let view = Bundle.main.loadNibNamed("SearchView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    @IBAction func chageTextEvent(_ sender: UITextField) {
        delegate.chageText(sender.text ?? "")
    }
}
