//
//  StudentChattingRoomListViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/22.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class StudentChattingRoomListViewController: UIViewController {
    
    @IBOutlet weak var customInputView: CustomInputView!
    @IBOutlet weak var chatTextViewBottomConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        customInputView.parentsVc = self
        customInputView.chatTextViewBottomConstraint = chatTextViewBottomConstraint
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}

extension StudentChattingRoomListViewController: CustomInputViewDelegate {
    func sendMessage(message: String, image: UIImage?) {
        
    }
}
