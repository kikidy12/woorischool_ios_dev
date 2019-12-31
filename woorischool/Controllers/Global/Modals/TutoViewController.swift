//
//  TutoViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/12/31.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class TutoViewController: UIViewController {
    
    @IBOutlet weak var tutoStackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var preBtn: UIButton!
    @IBOutlet weak var endTutoBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.numberOfPages = tutoStackView.subviews.count
        pageControl.currentPage = 0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        pageControl.subviews.enumerated().forEach {
            if $0.offset == pageControl.currentPage {
                $0.element.layer.borderWidth = 0
            }
            else {
                $0.element.layer.borderWidth = 1
            }
            $0.element.layer.borderColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1).cgColor
        }
    }

    @IBAction func nextEvnet(_ sender: UIButton) {
        pageControl.currentPage = pageControl.currentPage + 1
        
        pageControl.subviews.enumerated().forEach {
            if $0.offset == pageControl.currentPage {
                $0.element.layer.borderWidth = 0
            }
            else {
                $0.element.layer.borderWidth = 1
            }
        }
        
        scrollView.setContentOffset(CGPoint(x: CGFloat(pageControl.currentPage) * UIScreen.main.bounds.width, y: 0), animated: true)
        
        if tutoStackView.subviews.count - 1 == pageControl.currentPage {
            nextBtn.isHidden = true
            endTutoBtn.isHidden = false
        }
        preBtn.isHidden = false
    }
    
    @IBAction func preEvnet(_ sender: UIButton) {
        pageControl.currentPage = pageControl.currentPage - 1
        
        pageControl.subviews.enumerated().forEach {
            if $0.offset == pageControl.currentPage {
                $0.element.layer.borderWidth = 0
            }
            else {
                $0.element.layer.borderWidth = 1
            }
        }
        
        scrollView.setContentOffset(CGPoint(x: CGFloat(pageControl.currentPage) * UIScreen.main.bounds.width, y: 0), animated: true)
        
        if pageControl.currentPage == 0 {
            preBtn.isHidden = true
        }
        nextBtn.isHidden = false
    }
    
    @IBAction func endTutoEvent() {
        UserDefs.setOpenedApp(true)
        let navi = UINavigationController(rootViewController: SelectUserTypeViewController())
        navi.navigationBar.tintColor = .black
        navi.navigationBar.barTintColor = .white
        navi.navigationBar.shadowImage = UIImage()
        UIApplication.shared.keyWindow?.rootViewController = navi
    }
}
