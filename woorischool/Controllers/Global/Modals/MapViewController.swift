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
    
    var courseList = ["수학","영어","과학"] {
        didSet {
            
        }
    }
    
    var locManger = CLLocationManager()
    
    var currentLoc = NMGLatLng() {
        didSet {
            DispatchQueue.global(qos: .default).async {
                var markers = [NMFMarker]()
                for index in 0 ... 5 {
                    let marker = NMFMarker(position: NMGLatLng(lat: self.currentLoc.lat, lng: self.currentLoc.lng + (Double(index) * 0.01)))
                    marker.captionText = "\(index)번"
                    markers.append(marker)
                    
                    marker.touchHandler = {[weak self] (overlay) -> Bool in
                        let marker = overlay as! NMFMarker
                        print((overlay as? NMFMarker)?.captionText)
                        self?.title = (overlay as? NMFMarker)?.captionText ?? "없어"
                        self?.moveCamera(marker.position)
                        return true
                    }
                }
                DispatchQueue.main.async { [weak self] in
                    // 메인 스레드
                    markers.forEach {
                        $0.mapView = self?.naverMapView.mapView
                    }
                }
            }
        }
    }
    
    var textField = UITextField(frame: .zero)
    var pickerView = UIPickerView(frame: .zero)
    var accessaryView: UIToolbar!
    
    var naverMapView: NMFNaverMapView!
    
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
        
        view.addSubview(textField)
        let rightBtn = UIBarButtonItem(image: UIImage(named: "filterImage"), style: .plain, target: self, action: #selector(showFilterView))
        
        navigationItem.rightBarButtonItem = rightBtn
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        naverMapView = NMFNaverMapView(frame: view.bounds)
        view.addSubview(naverMapView)
        naverMapView.mapView.delegate = self
        locManger.delegate = self
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            locManger.requestWhenInUseAuthorization()
        }
        else {
            guard let coordinate = locManger.location?.coordinate else {
                return
            }
            currentLoc = NMGLatLng(from: coordinate)
            moveCamera(NMGLatLng(lat: currentLoc.lat, lng: currentLoc.lng))
        }
    }
    
    func moveCamera(_ nmgLatlng: NMGLatLng) {
        let cameraUpdate = NMFCameraUpdate(scrollTo: nmgLatlng)
        cameraUpdate.animation = .easeIn
        naverMapView.mapView.moveCamera(cameraUpdate)
    }
    
    @objc func showFilterView() {
        textField.becomeFirstResponder()
    }
    
    @objc func selectCourse() {
        title = courseList[pickerView.selectedRow(inComponent: 0)]
        textField.resignFirstResponder()
    }
    
    @objc func closePickerView() {
        textField.resignFirstResponder()
    }
}


extension MapViewController: NMFMapViewDelegate, CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            guard let coordinate = manager.location?.coordinate else {
                return
            }
            currentLoc = NMGLatLng(from: coordinate)
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: currentLoc.lat, lng: currentLoc.lng))
            cameraUpdate.animation = .easeIn
            naverMapView.mapView.moveCamera(cameraUpdate)
        }
    }
    func didTapMapView(_ point: CGPoint, latLng latlng: NMGLatLng) {
        print("hideView")
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
        return courseList[row]
    }
}
