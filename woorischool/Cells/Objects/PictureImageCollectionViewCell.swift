//
//  PictureImageCollectionViewCell.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/06.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class PictureImageCollectionViewCell: UICollectionViewCell {
    
    var deleteClouser: (()->())!

    @IBOutlet weak var imageView: CustomImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func initView(_ data: UIImage) {
        imageView.image = data
    }

    @IBAction func deleteImageEvent(_ sender: Any) {
        deleteClouser()
    }
}
