//
//  ParentsHomeRenewViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/28.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class TestData: NSObject {
    var id: Int!
    var start: Int!
    var end: Int!
    
    override init() {
        
    }
    
    init(id: Int, start: Int, end: Int) {
        self.id = id
        self.start = start
        self.end = end
    }
}

class ParentsHomeRenewViewController: UIViewController {
    
    var selectedDate = Date()
    var selectMonthDateIndex: IndexPath?
    var lastDate: Date = Date()
    
    var mondayData: [TestData] = [TestData(id: 0, start: 1, end: 2), TestData(id: 1, start: 3, end: 4), TestData(id: 2, start: 7, end: 8)]
    
    var sortMondayData = [[TestData:Int]]()
    
    var tuesdayData: [TestData] = [TestData(id: 0, start: 2, end: 2), TestData(id: 1, start: 4, end: 5), TestData(id: 2, start: 8, end: 9)]
    
    var sortTuesdayData = [[TestData:Int]]()
    
    var wendsdayData: [TestData] = [TestData(id: 0, start: 1, end: 2), TestData(id: 1, start: 3, end: 4), TestData(id: 2, start: 7, end: 8)]
    
    var sortWendsdayData = [[TestData:Int]]()
    
    var thursdayData: [TestData] = [TestData(id: 0, start: 2, end: 2), TestData(id: 1, start: 4, end: 5), TestData(id: 2, start: 8, end: 9)]
    
    var sortThursdayData = [[TestData:Int]]()
    
    var fridayData: [TestData] = [TestData(id: 0, start: 1, end: 2), TestData(id: 1, start: 3, end: 4), TestData(id: 2, start: 7, end: 8)]
    
    var sortFridayData = [[TestData:Int]]()
    
    var saturdayData: [TestData] = [TestData(id: 0, start: 2, end: 2), TestData(id: 1, start: 4, end: 5), TestData(id: 2, start: 8, end: 9)]
    
    var sortSaturdayData = [[TestData:Int]]()
    
    
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
                self.monthDatesCollectionView.scrollToItem(at: self.selectMonthDateIndex!, at: .centeredHorizontally, animated: false)
                self.getInfo(dateStr: DateFormatter().dateToString(self.monthDateList[selectIndex]))
            }
        }
    }
    
    var isShowFirst = true
    var month: Int = 1
    var year: Int = 1900
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var notiBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var monthDatesCollectionView: UICollectionView!
    @IBOutlet weak var dayClassInfoCollectionView: UICollectionView!
    
    @IBOutlet weak var mondayTableView: UITableView!
    @IBOutlet weak var tuesdayTableView: UITableView!
    @IBOutlet weak var wendsdayTableView: UITableView!
    @IBOutlet weak var thursdayTableView: UITableView!
    @IBOutlet weak var fridayTableView: UITableView!
    @IBOutlet weak var saturdayTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        monthDatesCollectionView.register(UINib(nibName: "MonthDaysCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "dateCell")
        dayClassInfoCollectionView.register(UINib(nibName: "SPHomeClassInfoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "dayclassCell")
        setDate()
        
        sortMondayData = sortWeekday(array: mondayData)
        sortTuesdayData = sortWeekday(array: tuesdayData)
        sortWendsdayData = sortWeekday(array: wendsdayData)
        sortThursdayData = sortWeekday(array: thursdayData)
        sortFridayData = sortWeekday(array: fridayData)
        sortSaturdayData = sortWeekday(array: saturdayData)
        
        mondayTableView.register(UINib(nibName: "HomeScheduleTableViewCell", bundle: nil), forCellReuseIdentifier: "scheduleCell")
        tuesdayTableView.register(UINib(nibName: "HomeScheduleTableViewCell", bundle: nil), forCellReuseIdentifier: "scheduleCell")
        wendsdayTableView.register(UINib(nibName: "HomeScheduleTableViewCell", bundle: nil), forCellReuseIdentifier: "scheduleCell")
        thursdayTableView.register(UINib(nibName: "HomeScheduleTableViewCell", bundle: nil), forCellReuseIdentifier: "scheduleCell")
        fridayTableView.register(UINib(nibName: "HomeScheduleTableViewCell", bundle: nil), forCellReuseIdentifier: "scheduleCell")
        saturdayTableView.register(UINib(nibName: "HomeScheduleTableViewCell", bundle: nil), forCellReuseIdentifier: "scheduleCell")
        setUserInfo()
    }
    
    @objc func showSettingEvent() {
        
    }
    
    @IBAction func showChildrenListEvent() {
        let vc = ManageChildrenViewController()
        self.show(vc, sender: nil)
    }
    
    func setUserInfo() {
        let user = GlobalDatas.currentUser
        nameLabel.text = "\(user?.childlen?.name ?? "아무개") 학부모님\n안녕하세요"
        var count = 0
        
        if !GlobalDatas.noticeList.isEmpty {
            self.notiBtn.setTitle("[공지] " + GlobalDatas.noticeList[0].title, for: .normal)
            Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (timer) in
                if count < GlobalDatas.noticeList.count - 1 {
                    count += 1
                }
                else {
                    count = 0
                }
                self.notiBtn.setTitle("[공지] " + GlobalDatas.noticeList[count].title, for: .normal)
            }
        }
    }
    
    func sortWeekday(array: [TestData]) -> [[TestData:Int]] {
        var sortData = [[TestData:Int]]()
        array.enumerated().forEach {
            if $0.element == array.first {
                if $0.element.start != 1 {
                    sortData.append([TestData() : $0.element.start - 1])
                }
                sortData.append([$0.element : $0.element.end - $0.element.start + 1])
            }
            else {
                
                let lastData = array[$0.offset - 1]
                
                if lastData.end + 1 != $0.element.start {
                    for _ in 0 ..< $0.element.start - lastData.end - 1 {
                        sortData.append([TestData() : 1])
                    }
                }
                sortData.append([$0.element : $0.element.end - $0.element.start + 1])
                                
                
                if $0.element == array.last, $0.element.end != 10 {
                    
                    for _ in 0 ..< 10 - $0.element.end {
                        sortData.append([TestData() : 1])
                    }
                }
            }
        }
        
        return sortData
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
    
    @IBAction func showNotiListViewEvent() {
        let vc = NotiListViewController()
        self.show(vc, sender: nil)
    }
}

extension ParentsHomeRenewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == mondayTableView {
            return sortMondayData.count
        }
        else if tableView == tuesdayTableView {
            return sortTuesdayData.count
        }
        else if tableView == wendsdayTableView {
            return sortWendsdayData.count
        }
        else if tableView == thursdayTableView {
            return sortThursdayData.count
        }
        else if tableView == fridayTableView {
            return sortFridayData.count
        }
        else if tableView == saturdayTableView {
            return sortSaturdayData.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as! HomeScheduleTableViewCell
        if tableView == mondayTableView {
            cell.initView(sortMondayData[indexPath.item].keys.first!)
            
        }
        else if tableView == tuesdayTableView {
            cell.initView(sortTuesdayData[indexPath.item].keys.first!)
        }
        else if tableView == wendsdayTableView {
            cell.initView(sortWendsdayData[indexPath.item].keys.first!)
        }
        else if tableView == thursdayTableView {
            cell.initView(sortThursdayData[indexPath.item].keys.first!)
        }
        else if tableView == fridayTableView {
            cell.initView(sortFridayData[indexPath.item].keys.first!)
        }
        else if tableView == saturdayTableView {
            cell.initView(sortSaturdayData[indexPath.item].keys.first!)
        }
        else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        var count = 0
        if tableView == mondayTableView {
            count = sortMondayData[indexPath.item].values.first!
        }
        else if tableView == tuesdayTableView {
            count = sortTuesdayData[indexPath.item].values.first!
        }
        else if tableView == wendsdayTableView {
            count = sortWendsdayData[indexPath.item].values.first!
        }
        else if tableView == thursdayTableView {
            count = sortThursdayData[indexPath.item].values.first!
        }
        else if tableView == fridayTableView {
            count = sortFridayData[indexPath.item].values.first!
        }
        else if tableView == saturdayTableView {
            count = sortSaturdayData[indexPath.item].values.first!
        }
        else {
            return 0
        }
        
        return CGFloat(integerLiteral: count) * tableView.frame.height/9.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var count = 0
        if tableView == mondayTableView {
            count = sortMondayData[indexPath.item].values.first!
        }
        else if tableView == tuesdayTableView {
            count = sortTuesdayData[indexPath.item].values.first!
        }
        else if tableView == wendsdayTableView {
            count = sortWendsdayData[indexPath.item].values.first!
        }
        else if tableView == thursdayTableView {
            count = sortThursdayData[indexPath.item].values.first!
        }
        else if tableView == fridayTableView {
            count = sortFridayData[indexPath.item].values.first!
        }
        else if tableView == saturdayTableView {
            count = sortSaturdayData[indexPath.item].values.first!
        }
        else {
            return 0
        }
        
        return CGFloat(integerLiteral: count) * tableView.frame.height/9.0
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
            selectedDate = monthDateList[indexPath.item]
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
            cell.dateLabel.text = selectedDate.dateToString(formatter: "MM월 dd일") + "자 알림장"
            cell.showDailyNotiColouser = { isDailyNote in
                if !isDailyNote {
                    self.navigationController?.showToast(message: "등록된 알림장이 없습니다.", font: .systemFont(ofSize: 15))
                }
                else {
                    let vc = PSDailyNoteViewController()
                    vc.schedule = self.classDayList[indexPath.item].lectureClass.lectureSchedule
                    self.showPopupView(vc: vc)
                }
            }
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
        ServerUtil.shared.getV2MeInfo(self, parameters: parameters) { (success, dict, message) in
            guard success, let array = dict?["lecture_class_day"] as? NSArray else {
                return
            }
            
            self.classDayList = array.compactMap { LectureClassDayData($0 as! NSDictionary) }
        }
    }
}
