//
//  ServerUtil.swift
//  fifteensecond
//
//  Created by 권성민 on 01/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit
import Alamofire
import Lottie

class ServerUtil: NSObject {
    
    static let shared = ServerUtil()
    
    fileprivate let liveServer:String = ""
    
    fileprivate let devServer:String = "http://ec2-52-78-148-252.ap-northeast-2.compute.amazonaws.com/"
    
    fileprivate let localServer:String = "http://172.30.1.17:5000/"
    
    fileprivate var serverAddress: String!
    
    var headers:HTTPHeaders = ["X-Http-Token": UserDefs.userToken]
    
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
        let lottie = AnimationView()
        let ani = Animation.named("loading")!
        
        lottie.animation = ani
        lottie.frame = .init(x: 0, y: 0, width: 150, height: 150)
        lottie.sizeToFit()
        lottie.loopMode = .loop
        lottie.contentMode = .scaleAspectFill
        serverAddress = devServer
//        serverAddress = localServer
//        loadingView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.376177226)
        loadingView.backgroundColor = .clear
        loadingView.frame = UIScreen.main.bounds
        lottie.center = loadingView.center
        loadingView.addSubview(lottie)
        lottie.play()
        progressLabel.numberOfLines = 1
        progressLabel.font = .systemFont(ofSize: 20, weight: .medium)
    }
    
    //global
    func postV2Announcement(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("v2_announcement", method: .post, parameters: parameters, completion: completion)
    }
    
    func getNotification(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("notification", method: .get, parameters: parameters, completion: completion)
    }
    
    func getV2Board(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("v2_board", method: .get, parameters: parameters, completion: completion)
    }
    
    func postv2BoardDetail(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("v2_board_detail", method: .post, parameters: parameters, completion: completion)
    }
    
    func postV2Board(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("v2_board", method: .post, parameters: parameters, completion: completion)
    }
    
    func postLike(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("like", method: .post, parameters: parameters, completion: completion)
    }
    
    func getLike(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("like", method: .get, parameters: parameters, completion: completion)
    }
    
    func deleteV2Board(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("v2_board", method: .delete, parameters: parameters, completion: completion)
    }
    
    func getV2Comment(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("v2_comment", method: .get, parameters: parameters, completion: completion)
    }
    
    func deleteV2Comment(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("v2_comment", method: .delete, parameters: parameters, completion: completion)
    }
    
    func postV2Comment(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("v2_comment", method: .post, parameters: parameters, completion: completion)
    }
    
    func getUserMyPost(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("user_my_post", method: .get, parameters: parameters, completion: completion)
    }
    
    func getV2Emoticon(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("v2_emoticon", method: .get, parameters: parameters, completion: completion)
    }
    
    func postNoteOne(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("note_one", method: .post, parameters: parameters, completion: completion)
    }
    
    func getSchoolQuarterInfo(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("school_quarter_info", method: .get, parameters: parameters, completion: completion)
    }
    
    func getNote(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("note", method: .get, parameters: parameters, completion: completion)
    }
    
    func postNote(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest(showLoading: false, "note", method: .post, parameters: parameters, completion: completion)
    }
    
    func postPasswordChange(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest(showLoading: false, "password_change", method: .post, parameters: parameters, completion: completion)
    }
    
    func getLectureDetail(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest(showLoading: false, "lecture_detail", method: .get, parameters: parameters, completion: completion)
    }
    
    func postUserService(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest(showLoading: false, "user_service", method: .post, parameters: parameters, completion: completion)
    }
    
    func getScheduleList(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest(showLoading: false, "schedule_list", method: .get, parameters: parameters, completion: completion)
    }
    
    //parents
    
    func getAcademyCategory(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("academy_category", method: .get, parameters: parameters, completion: completion)
    }
    
    func getAcademy(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("academy", method: .get, parameters: parameters, completion: completion)
    }
    
    func getMeInfo(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("me_info", method: .get, parameters: parameters, completion: completion)
    }
    
    func postPointLectureApply(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("point_lecture_apply", method: .post, parameters: parameters, completion: completion)
    }
    
    func postAuth(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("auth", method: .post, parameters: parameters, completion: completion)
    }
    
    func postPhoneAuth(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("phone_auth", method: .post, parameters: parameters, completion: completion)
    }
    
    func getParentStudent(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("parent_student", method: .get, parameters: parameters, completion: completion)
    }
    
    func deleteParentStudent(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("parent_student", method: .delete, parameters: parameters, completion: completion)
    }
    
    func patchParentStudent(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("parent_student", method: .patch, parameters: parameters, completion: completion)
    }
    
    func postParentStudent(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("parent_student", method: .post, parameters: parameters, completion: completion)
    }
    
    func getLecture(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("lecture", method: .get, parameters: parameters, completion: completion)
    }
    
    func getLectureAreas(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("lecture_areas", method: .get, parameters: parameters, completion: completion)
    }
    
    func postLecture(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("lecture", method: .post, parameters: parameters, completion: completion)
    }
    
    func postLectureWait(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("lecture_wait", method: .post, parameters: parameters, completion: completion)
    }
    
    func getLectureHistory(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("lecture_history", method: .get, parameters: parameters, completion: completion)
    }
    
    func getLectureApply(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("lecture_apply", method: .get, parameters: parameters, completion: completion)
    }
    
    func postLectureApply(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("lecture_apply", method: .post, parameters: parameters, completion: completion)
    }
    
    func deleteLectureApply(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("lecture_apply", method: .delete, parameters: parameters, completion: completion)
    }
    
    func patchLectureApply(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("lecture_apply", method: .patch, parameters: parameters, completion: completion)
    }
    
    func patchLectureRating(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("lecture_rating", method: .patch, parameters: parameters, completion: completion)
    }
    
    func putLectureRating(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("lecture_rating", method: .put, parameters: parameters, completion: completion)
    }
    
    func postLectureRating(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("lecture_rating", method: .post, parameters: parameters, completion: completion)
    }
    
    //v2
    func getV2Info(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("v2_info", method: .get, parameters: parameters, completion: completion)
    }
    
    func getV2MeInfo(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("v2_me_info", method: .get, parameters: parameters, completion: completion)
    }
    
    //teacher
    
    func putAuth(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("auth", method: .put, parameters: parameters, completion: completion)
    }
    
    func postPhoneAuthNumCheck(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("phone_auth_num_check", method: .post, parameters: parameters, completion: completion)
    }
    
    func postTeacherEmailCheck(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("teacher_email_check", method: .post, parameters: parameters, completion: completion)
    }
    
    func postTeacherPhoneAuth(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("teacher_phone_auth", method: .post, parameters: parameters, completion: completion)
    }
    
    func postStudentList(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("student_list", method: .post, parameters: parameters, completion: completion)
    }
    
    func getSchool(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("school", method: .get, parameters: parameters, completion: completion)
    }
    
    func postPushTest(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("push_test", method: .post, parameters: parameters, completion: completion)
    }
    
    func deleteAuth(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("auth", method: .delete, parameters: parameters, completion: completion)
    }
    
    func getLectureSchedule(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("lecture_schedule", method: .get, parameters: parameters, completion: completion)
    }
    
    func postLectureSchedule(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("lecture_schedule", method: .post, parameters: parameters, completion: completion)
    }
    
    func postLectureStatus(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("lecture_status", method: .post, parameters: parameters, completion: completion)
    }
    
    func getV2Announcement(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("v2_announcement", method: .get, parameters: parameters, completion: completion)
    }
    
    func deleteV2Announcement(_ vc: UIViewController, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        apiRequest("v2_announcement", method: .delete, parameters: parameters, completion: completion)
    }
    
    //upload
    func putAuth(vc: UIViewController, multipartFormData: @escaping (MultipartFormData) -> Void, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        uploadRequest("auth", method: .put, showUploadProgress: true, multipartFormData: multipartFormData, completion: completion)
    }
    
    func patchAuth(vc: UIViewController, multipartFormData: @escaping (MultipartFormData) -> Void, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        uploadRequest("auth", method: .patch, showUploadProgress: true, multipartFormData: multipartFormData, completion: completion)
    }
    
    func putV2Announcement(vc: UIViewController, multipartFormData: @escaping (MultipartFormData) -> Void, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        uploadRequest("v2_announcement", method: .put, showUploadProgress: true, multipartFormData: multipartFormData, completion: completion)
    }
    
    func patchV2Announcement(vc: UIViewController, multipartFormData: @escaping (MultipartFormData) -> Void, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        uploadRequest("v2_announcement", method: .patch, showUploadProgress: true, multipartFormData: multipartFormData, completion: completion)
    }
    
    func putV2Comment(vc: UIViewController, multipartFormData: @escaping (MultipartFormData) -> Void, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        uploadRequest("v2_comment", method: .put, showUploadProgress: true, multipartFormData: multipartFormData, completion: completion)
    }
    
    func putV2Board(vc: UIViewController, multipartFormData: @escaping (MultipartFormData) -> Void, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        uploadRequest("v2_board", method: .put, showUploadProgress: true, multipartFormData: multipartFormData, completion: completion)
    }
    
    func patchV2Board(vc: UIViewController, multipartFormData: @escaping (MultipartFormData) -> Void, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        uploadRequest("v2_board", method: .patch, showUploadProgress: true, multipartFormData: multipartFormData, completion: completion)
    }
    
    func putNote(vc: UIViewController, multipartFormData: @escaping (MultipartFormData) -> Void, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        currentVc = vc
        uploadRequest("note", method: .put, showUploadProgress: true, multipartFormData: multipartFormData, completion: completion)
    }
    
}

extension ServerUtil {
    
    func setToken(token: String) {
        headers = ["X-Http-Token": token]
    }
    
    var headerCheck: Bool {
        if headers["X-Http-Token"]!.isEmpty {
            AlertHandler().showAlert(vc: currentVc, message: "Token Error", okTitle: "확인")
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
    
    
    fileprivate func apiRequest(showLoading: Bool = true, version: String = "", _ api: String, method: HTTPMethod, parameters: Parameters? = nil, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        if showLoading {
            showLoadding()
        }
        var request: DataRequest!
//        switch method {
//        case .delete:
//            request = Alamofire.request(serverAddress + api, method: method, parameters: parameters, encoding: URLEncoding.httpBody , headers: headers)
//            break
//        default:
//            request = Alamofire.request(serverAddress + api, method: method, parameters: parameters, headers: headers)
//            break
//        }
        
        request = Alamofire.request(serverAddress + api, method: method, parameters: parameters, headers: headers)
        
        request.responseJSON { (response) in
            self.responseProcess(response: response, completion: completion)
        }
        
    }
    
    fileprivate func uploadRequest(version: String = "", _ api: String, method: HTTPMethod, showUploadProgress:Bool = false, multipartFormData: @escaping (MultipartFormData) -> Void, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        if showUploadProgress {
            self.currentVc.view.addSubview(self.progressLabel)
        }
        else {
            showLoadding()
        }
        Alamofire.upload(multipartFormData: multipartFormData, to: serverAddress + version + api, method: method, headers: headers) { (encodingResult) in
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
                    self.responseProcess(version: version, response: response, completion: completion)
                })
            case .failure(let error):
                print(error)
                self.loadingView.removeFromSuperview()
            }
        }
    }
    
    fileprivate func responseProcess(version: String = "", response: DataResponse<Any>, completion: @escaping (Bool, NSDictionary?, String?) -> Void) {
        
        loadingView.removeFromSuperview()
        progressLabel.removeFromSuperview()
        guard let result = response.result.value as? NSDictionary else {
            completion(false ,nil, nil)
            AlertHandler().showAlert(vc: currentVc, message: "Server Error", okTitle: "확인")
            return
        }
        
        if serverAddress != liveServer {
            print(response.request?.description ?? "ServerError")
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: result, options: .prettyPrinted)
                print(String(data: jsonData, encoding: .utf8)!)
            }
            catch {
                print(error.localizedDescription)
            }
        }
        
        guard let code = result["code"] as? Int else {
            completion(false ,nil, nil)
            AlertHandler().showAlert(vc: currentVc, message: "Server Error", okTitle: "확인")
            return
        }
        guard code == 200 || code == 201 else {
            if let message = result["message"] as? String {
                print(message)
                completion(false ,nil, message)
            }
            else {
                AlertHandler().showAlert(vc: currentVc, message: "Server Error", okTitle: "확인")
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

