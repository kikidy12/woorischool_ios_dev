//
//  MapViewController.swift
//  woorischool
//
//  Created by 권성민 on 2020/01/02.
//  Copyright © 2020 beanfactory. All rights reserved.
//

import UIKit
import NMapsMap

class MapViewController: UIViewController {
    
    var courseList = [AcademyCategory]() {
        didSet {
            pickerView.reloadAllComponents()
            title = courseList.first?.name
            self.getAcademys(id: courseList.first?.id)
        }
    }
    
    var markers = [NMFMarker]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.markers.forEach {
                    $0.mapView = self?.naverMapView.mapView
                }
            }
        }
    }
    
    var academyList = [AcademyData]() {
        didSet {
            mapTableView.reloadData()
            markers.forEach {
                $0.mapView = nil
            }
            DispatchQueue.global(qos: .default).async {
                self.markers = self.academyList.compactMap { academy in
                    let marker = NMFMarker(position: academy.location)
                    marker.captionText = academy.name
                    marker.zIndex = academy.id
                    marker.touchHandler = {[weak self] (overlay) -> Bool in
                        let marker = overlay as! NMFMarker
                        self?.moveCamera(marker.position, academy: academy)
                        return true
                    }
                    
                    return marker
                }
            }
        }
    }
    
    var selectedAcademy: AcademyData!
    
    var locManger = CLLocationManager()
    
    var textField = UITextField(frame: .zero)
    var pickerView = UIPickerView(frame: .zero)
    var accessaryView: UIToolbar!
    
    var naverMapView: NMFNaverMapView!
    
    @IBOutlet weak var mapContainerView: UIView!
    @IBOutlet weak var tableContainerView: UIView!
    @IBOutlet weak var academyInfoView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var mapSchoolNameBtn: UIButton!
    @IBOutlet weak var tableSchoolNameBtn: UIButton!
    
    @IBOutlet weak var showListBtn: UIButton!
    
    @IBOutlet weak var mapTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        accessaryView = UIToolbar()
        accessaryView.sizeToFit()
        let selectBtn = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(selectCourse))
        let spaceBar = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let closeBtn = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(closePickerView))
        
        accessaryView.items = [closeBtn, spaceBar, selectBtn]
        
        textField.inputView = pickerView
        textField.inputAccessoryView = accessaryView
        
        mapTableView.register(UINib(nibName: "MapTableViewCell", bundle: nil), forCellReuseIdentifier: "academyCell")
        
        mapTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1))
        mapTableView.tableFooterView?.backgroundColor = .veryLightPink
        
        view.addSubview(textField)
        let rightBtn = UIBarButtonItem(image: UIImage(named: "filterImage"), style: .plain, target: self, action: #selector(showFilterView))
        
        academyInfoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showAcademyInfoEvent(_:))))
        navigationItem.rightBarButtonItem = rightBtn
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        naverMapView = NMFNaverMapView(frame: mapContainerView.bounds)
        mapContainerView.addSubview(naverMapView)
        mapContainerView.sendSubviewToBack(naverMapView)
        naverMapView.mapView.delegate = self
        locManger.delegate = self
        if let school = GlobalDatas.currentUser?.childlen?.school {
            mapSchoolNameBtn.setTitle(school.name, for: .normal)
            tableSchoolNameBtn.setTitle(school.name, for: .normal)
            let marker = NMFMarker(position: school.location)
            marker.iconImage = NMF_MARKER_IMAGE_BLACK
            marker.zIndex = Int(INT_MAX)
            marker.captionText = school.name
            marker.touchHandler = {[weak self] (overlay) -> Bool in
                let marker = overlay as! NMFMarker
                self?.moveCamera(marker.position)
                return false
            }
            marker.mapView = naverMapView.mapView
            self.moveCamera(school.location)
            getCategory()
        }
    }
    
    @IBAction func changeMode(_ sender: UIButton) {
        if sender.tag == 0 {
            tableContainerView.isHidden = false
        }
        else {
            tableContainerView.isHidden = true
        }
    }
    
    @IBAction func moveToSchool(_ sender: UIButton) {
        if let location = GlobalDatas.currentUser.childlen?.school?.location {
            moveCamera(location)
        }
    }
    
    func moveCamera(_ nmgLatlng: NMGLatLng, academy: AcademyData? = nil) {
        let cameraUpdate = NMFCameraUpdate(scrollTo: nmgLatlng)
        cameraUpdate.animation = .easeIn
        naverMapView.mapView.moveCamera(cameraUpdate)
        if academy != nil {
            showListBtn.isHidden = true
            academyInfoView.isHidden = false
            nameLabel.text = academy?.name
            addressLabel.text = academy?.address
            categoryLabel.text = academy?.category.name
            if let distance = academy?.location.distance(to: GlobalDatas.currentUser.childlen.school.location) {
                distanceLabel.text = "\(distance.toFloorString() ?? "0")m"
            }
            else {
                
            }
            selectedAcademy = academy
        }
        else {
            academyInfoView.isHidden = true
            showListBtn.isHidden = false
        }
    }
    
    @objc func showFilterView() {
        textField.becomeFirstResponder()
    }
    
    @objc func selectCourse() {
        title = courseList[pickerView.selectedRow(inComponent: 0)].name
        textField.resignFirstResponder()
        self.getAcademys(id: courseList[pickerView.selectedRow(inComponent: 0)].id)
    }
    
    @objc func closePickerView() {
        textField.resignFirstResponder()
    }
    
    @objc func showAcademyInfoEvent(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            if let link = selectedAcademy.linkUrl, let url = URL(string: link), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            else {
                AlertHandler().showAlert(vc: self, message: "링크를 열 수 없습니다.", okTitle: "확인")
            }
        }
    }
}


extension MapViewController: NMFMapViewDelegate, CLLocationManagerDelegate {
    func didTapMapView(_ point: CGPoint, latLng latlng: NMGLatLng) {
        academyInfoView.isHidden = true
        showListBtn.isHidden = false
    }
    
}

extension MapViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return courseList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return courseList[row].name
    }
}

extension MapViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return academyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "academyCell", for: indexPath) as! MapTableViewCell
        
        cell.academy = academyList[indexPath.item]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let link = academyList[indexPath.item].linkUrl, let url = URL(string: link), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        else {
            AlertHandler().showAlert(vc: self, message: "링크를 열 수 없습니다.", okTitle: "확인")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }
    
}

extension MapViewController {
    func getCategory() {
        ServerUtil.shared.getAcademyCategory(self) { (success, dict, message) in
            guard success, let array = dict?["academy_category"] as? NSArray else {
                return
            }
            var tempArray = array.compactMap { AcademyCategory($0 as! NSDictionary) }
            tempArray.insert(AcademyCategory(name: "전체"), at: 0)
            self.courseList = tempArray
        }
    }
    
    func getAcademys(id: Int?) {
        let parameters = [
            "academy_category_id": id == nil ? 0 : id!
        ]
        ServerUtil.shared.getAcademy(self, parameters: parameters) { (success, dict, message) in
            guard success , let array = dict?["academy"] as? NSArray else {
                return
            }
            
            self.academyList = array.compactMap { AcademyData($0 as! NSDictionary) }
        }
    }
}
