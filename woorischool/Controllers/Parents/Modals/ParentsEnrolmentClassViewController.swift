//
//  ParentsEnrolmentClassViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/01.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit
import Alamofire

class ParentsEnrolmentClassViewController: UIViewController {
    
    var quater: QuaterData! {
        didSet {
            quaterNameLabel.text = "\(quater.quarter ?? "미확인") 방과후 학교 수강신청 기간"
            registPeriodLabel.text = quater.applyPeriodStr
            dueDateLabel.text = "지금은 수강신청기간입니다.(\(quater.applyEndDate.dateToString(formatter: "yyyy.MM.dd 까지")))"
        }
    }
    
    @IBOutlet weak var quaterNameLabel: UILabel!
    @IBOutlet weak var registPeriodLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        getQuater()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        priceLabel.text = "\(numberFormatter.string(for: GlobalDatas.currentUser?.childlen?.point) ?? "0")원"
    }
    @IBAction func showRegistViewEvent() {
        let vc = CourseRegistrationViewController()
        self.show(vc, sender: nil)
    }

    @IBAction func showRegistedClassViewEvent() {
        let vc = RegistedClassMainViewController()
        self.show(vc, sender: nil)
    }
    
    @IBAction func showPdfFileEvent() {
        if let urlStr = quater.fileURL?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        else {
            AlertHandler().showAlert(vc: self, message: "통신문을 열 수 없습니다.", okTitle: "확인")
        }
    }
}

extension ParentsEnrolmentClassViewController {
    func getQuater() {
        
        ServerUtil.shared.getSchoolQuarterInfo(self) { (success, dict, message) in
            guard success, let quater = dict?["school_quarter"] as? NSDictionary else {
                return
            }
            
            self.quater = QuaterData(quater)
        }
    }
}
