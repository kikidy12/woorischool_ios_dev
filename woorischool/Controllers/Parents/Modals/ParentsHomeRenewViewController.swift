//
//  ParentsHomeRenewViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/28.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class ParentsHomeRenewViewController: UIViewController {
    
    var selectMonthDateIndex: IndexPath?
    var lastDate: Date = Date()
    
    var classDayList = [LectureClassDayData]() {
        didSet {
            if classDayList.isEmpty {
                
            }
            else {
                
            }
            pageControl.numberOfPages = classDayList.count
            dayClassInfoCollectionView.reloadData()
        }
    }
    
    var monthDateList = [Date]() {
        didSet {
            var selectIndex = 0
            if self.isShowFirst, let index = self.monthDateList.firstIndex(where: {
                let currentDay = Calendar.current.component(.day, from: Date())
                let tempDay = Calendar.current.component(.day, from: $0)
                let tempMonth = Calendar.current.component(.month, from: $0)
                let tempYear = Calendar.current.component(.year, from: $0)
                
                if currentDay == tempDay, month == tempMonth, year == tempYear {
                    return true
                }
                else {
                    return false
                }
            }) {
                self.isShowFirst = false
                selectIndex = index
                selectMonthDateIndex = IndexPath(item: index, section: 0)
            }
            else {
                selectIndex = 0
                selectMonthDateIndex = IndexPath(item: 0, section: 0)
            }
            monthDatesCollectionView.reloadData()
            monthDatesCollectionView.performBatchUpdates(nil) { (result) in
                self.monthDatesCollectionView.scrollToItem(at: self.selectMonthDateIndex!, at: .centeredHorizontally, animated: true)
                self.getInfo(dateStr: DateFormatter().dateToString(self.monthDateList[selectIndex]))
            }
        }
    }
    
    var isShowFirst = true
    var month: Int = 1
    var year: Int = 1900
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var monthDatesCollectionView: UICollectionView!
    @IBOutlet weak var dayClassInfoCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        monthDatesCollectionView.register(UINib(nibName: "MonthDaysCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "dateCell")
        dayClassInfoCollectionView.register(UINib(nibName: "SPHomeClassInfoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "dayclassCell")
        setDate()
    }
    
    func setUserInfo() {
        let user = GlobalDatas.currentUser
        
        nameLabel.text = "\(user?.childlen?.name ?? "아무개") 학부모님\n안녕하세요"
        
    }

    func setDate(byAdding: Int = 0) {
        
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .month, value: byAdding, to: lastDate)!
        lastDate = date
        year = calendar.component(.year, from: date)
        month = calendar.component(.month, from: date)

        let range = calendar.range(of: .day, in: .month, for: date)!
        monthLabel.text = "\(month)월"
        monthDateList = range.compactMap {
            DateComponents(calendar: calendar, year: year, month: month, day: $0, hour: 9, minute: 0, second: 0).date!
        }
    }
    
    @IBAction func preMonthSelectEvent() {
        setDate(byAdding: -1)
    }

    @IBAction func nextMonthSelectEvent() {
        setDate(byAdding: 1)
    }
}

extension ParentsHomeRenewViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == dayClassInfoCollectionView, pageControl.currentPage == indexPath.row {
            pageControl.currentPage = collectionView.indexPath(for: collectionView.visibleCells.first!)!.row
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == monthDatesCollectionView {
            
            collectionView.performBatchUpdates(nil) { (result) in
                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                self.getInfo(dateStr: DateFormatter().dateToString(self.monthDateList[indexPath.item]))
            }
            if let lastSelectIndex = selectMonthDateIndex {
                selectMonthDateIndex = indexPath
                collectionView.reloadItems(at: [lastSelectIndex])
            }
            else {
                selectMonthDateIndex = indexPath
            }
            
            
        }
        else if collectionView == dayClassInfoCollectionView {
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == monthDatesCollectionView {
            return UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        }
        else if collectionView == dayClassInfoCollectionView {
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
        else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == monthDatesCollectionView {
            return monthDateList.count
        }
        else if collectionView == dayClassInfoCollectionView {
            return classDayList.count
        }
        else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == monthDatesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dateCell", for: indexPath) as! MonthDaysCollectionViewCell
            cell.initView(monthDateList[indexPath.item])
            cell.isSelected = (selectMonthDateIndex == indexPath)
            
            return cell
        }
        else if collectionView == dayClassInfoCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayclassCell", for: indexPath) as! SPHomeClassInfoCollectionViewCell
            cell.initView(classDayList[indexPath.item])
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == monthDatesCollectionView {
            return CGSize(width: 41, height: 41)
        }
        else if collectionView == dayClassInfoCollectionView {
            return CGSize(width: UIScreen.main.bounds.width - 40, height: 152)
        }
        else {
            return CGSize(width: 1, height: 1)
        }
    }
}

extension ParentsHomeRenewViewController {
    func getInfo(dateStr: String) {
        let parameters = [
            "date": dateStr,
            "device_token": GlobalDatas.deviceToken,
            "os": "iOS"
        ] as [String:Any]
        print(UserDefs.userToken)
        print(parameters)
        ServerUtil.shared.getMeInfo(self, parameters: parameters) { (success, dict, message) in
            guard success, let array = dict?["lecture_list"] as? NSArray, let user = dict?["user"] as? NSDictionary else {
                return
            }
            
            GlobalDatas.currentUser = UserData(user)
            UserDefs.setHasChildren(true)
            UserDefs.setLastUserType(type: UserType.parents.rawValue)
            self.classDayList = array.compactMap { LectureClassDayData($0 as! NSDictionary) }
            self.setUserInfo()
            
        }
    }
}
