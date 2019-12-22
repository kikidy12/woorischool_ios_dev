//
//  ImageDetailCollectionViewCell.swift
//  woorischool
//
//  Created by 권성민 on 2019/12/16.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class ImageDetailCollectionViewCell: UICollectionViewCell {
    
//    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        scrollView.maximumZoomScale = 2.0
        scrollView.minimumZoomScale = 1.0
        scrollView.delegate = self
    }

    func initView(_ url: URL) {
        imageView = UIImageView(image: nil)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = UIScreen.main.bounds
        imageView.kf.setImage(with: url)
        scrollView.subviews.forEach {
            $0.removeFromSuperview()
        }
        scrollView.addSubview(imageView)
        scrollView.contentSize = imageView.frame.size
    }
}

extension ImageDetailCollectionViewCell: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}
