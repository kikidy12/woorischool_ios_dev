//
//  ServerUtil.swift
//  fifteensecond
//
//  Created by 권성민 on 01/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit


import UIKit
import Alamofire
//import Lottie

class ServerUtil: NSObject {
    
    static let shared = ServerUtil()
    
    fileprivate let liveServer:String = ""
    
    fileprivate let devServer:String = "http://52.78.148.252/"
    
    fileprivate let localServer:String = ""
    
    fileprivate var serverAddress: String!
    
    fileprivate var headers:HTTPHeaders = ["X-Http-Token": UserDefs.userToken]
    
    fileprivate var progressLabel = UILabel()
    
    fileprivate var progressString:String = "" {
        didSet {
            progressLabel.text = progressString
            progressLabel.sizeToFit()
            progressLabel.center = .init(x: currentVc.view.center.x, y: currentVc.view.frame.height/2)
        }
    }
    
    fileprivate var loadingView = UIView()
    
    fileprivate var currentVc: UIViewController!
    
    override init() {
//        let lottie = AnimationView()
//        let ani = Animation.named("loading")!
        
//        lottie.animation = ani
//        lottie.frame = .init(x: 0, y: 0, width: 150, height: 150)
//        lottie.sizeToFit()
//        lottie.loopMode = .loop
//        lottie.contentMode = .scaleAspectFill
        serverAddress = devServer
        loadingView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.376177226)
        loadingView.frame = UIScreen.main.bounds
//        lottie.center = loadingView.center
//        loadingView.addSubview(lottie)
//        lottie.play()
        progressLabel.numberOfLines = 1
        print("UserToken: ", headers )
        progressLabel.font = .systemFont(ofSize: 20, weight: .medium)
    }
    
    func getInfo(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("info", method: .get, parameters: parameters, completion: completion)
    }
    
    func postAuth(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("auth", method: .post, parameters: parameters, completion: completion)
    }
    
    func postPhoneAuth(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("phone_auth", method: .post, parameters: parameters, completion: completion)
    }
    
    func postParentStudent(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("parent_student", method: .post, parameters: parameters, completion: completion)
    }
    
    //upload
    
    func putAuth(vc: UIViewController, multipartFormData: @escaping (MultipartFormData) -> Void, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        uploadRequest("auth", method: .put, showUploadProgress: true, multipartFormData: multipartFormData, completion: completion)
    }
}

extension ServerUtil {
    
    func setToken(token: String) {
        headers = ["X-Http-Token": token]
    }
    
    var headerCheck: Bool {
        if headers["X-Http-Token"]!.isEmpty {
            AlertHandler.shared.showAlert(vc: currentVc, message: "Token Error", okTitle: "확인")
            return false
        }
        else {
            return true
        }
    }
    
    //loading
    func showLoadding() {
        guard let window = UIApplication.shared.keyWindow else { return }
        window.addSubview(loadingView)
    }
    
    
    fileprivate func apiRequest(_ api: String, method: HTTPMethod, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        showLoadding()
        var request: DataRequest!
        switch method {
        case .delete:
            request = Alamofire.request(serverAddress + api, method: method, parameters: parameters, encoding: URLEncoding.httpBody , headers: headers)
            break
        default:
            request = Alamofire.request(serverAddress + api, method: method, parameters: parameters, headers: headers)
            break
        }
        
        request.responseJSON { (response) in
            self.responseProcess(response: response, completion: completion)
        }
        
    }
    
    fileprivate func uploadRequest(_ api: String, method: HTTPMethod, showUploadProgress:Bool = false, multipartFormData: @escaping (MultipartFormData) -> Void, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        if showUploadProgress {
            self.currentVc.view.addSubview(self.progressLabel)
        }
        else {
            showLoadding()
        }
        Alamofire.upload(multipartFormData: multipartFormData, to: serverAddress + api, method: method, headers: headers) { (encodingResult) in
            switch encodingResult {
            case .success(let upload,_,_):
                upload.uploadProgress(closure: { (progress) in
                    self.progressString = "\(progress.completedUnitCount)/\(progress.totalUnitCount)"
                    if progress.completedUnitCount == progress.totalUnitCount {
                        self.progressLabel.removeFromSuperview()
                        self.showLoadding()
                    }
                    print(self.progressString)
                })
                upload.responseJSON(completionHandler: { (response) in
                    self.responseProcess(response: response, completion: completion)
                })
            case .failure(let error):
                print(error)
                self.loadingView.removeFromSuperview()
            }
        }
    }
    
    fileprivate func responseProcess(response: DataResponse<Any>, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        if serverAddress != liveServer {
            print(response.request?.description ?? "ServerError")
            print(response.description)
        }
        
        loadingView.removeFromSuperview()
        progressLabel.removeFromSuperview()
        guard let result = response.result.value as? NSDictionary else {
            completion(false ,nil, nil)
            AlertHandler.shared.showAlert(vc: currentVc, message: "Server Error", okTitle: "확인")
            return
        }
        
        guard let code = result["code"] as? Int else {
            completion(false ,nil, nil)
            AlertHandler.shared.showAlert(vc: currentVc, message: "Server Error", okTitle: "확인")
            return
        }
        guard code == 200 || code == 201 else {
            if let message = result["message"] as? String {
                completion(false ,nil, message)
            }
            else {
                AlertHandler.shared.showAlert(vc: currentVc, message: "Server Error", okTitle: "확인")
                completion(false ,nil, nil)
            }
            return
        }
        
        if let data = result["data"] as? NSDictionary {
            if let message = result["message"] as? String {
                completion(true, data, message)
            }
            else {
                completion(true, data, nil)
            }
        }
        else {
            if let message = result["message"] as? String {
                completion(true, nil, message)
            }
            else {
                completion(false, nil, nil)
            }
        }
    }
}

