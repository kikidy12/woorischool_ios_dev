//
//  SelectCameraTypeViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/06.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class SelectCameraTypeViewController: UIViewController {
    
    var selectImagePickClouser: ((UIImage)->())!
    
    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func openCameraEvent() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = .camera
            self.imagePicker.allowsEditing = false
            
            self.present(self.imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func openCameraRollEvent() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.allowsEditing = false
            
            self.present(self.imagePicker, animated: true, completion: nil)
        }
    }
}

extension SelectCameraTypeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        imagePicker.dismiss(animated: true) {
            self.dismiss(animated: true) {
                self.selectImagePickClouser(image)
            }
        }
    }
}
