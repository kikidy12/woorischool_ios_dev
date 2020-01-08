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
    
    var locManger = CLLocationManager()
    
    var currentLoc = NMGLatLng() {
        didSet {
            sleep(3)
            DispatchQueue.global(qos: .default).async {
                var markers = [NMFMarker]()
                for index in 0 ... 5 {
                    let marker = NMFMarker(position: NMGLatLng(lat: self.currentLoc.lat, lng: self.currentLoc.lng + (Double(index) * 0.001)))
                    marker.captionText = "\(index)번"
                    markers.append(marker)
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
    
    @IBOutlet weak var naverMapView: NMFNaverMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: currentLoc.lat, lng: currentLoc.lng))
            cameraUpdate.animation = .easeIn
            naverMapView.mapView.moveCamera(cameraUpdate)
        }
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
    
    
}
