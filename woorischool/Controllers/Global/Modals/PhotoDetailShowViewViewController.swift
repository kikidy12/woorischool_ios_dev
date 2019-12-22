//
//  PhotoDetailShowViewViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/12/13.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class PhotoDetailShowViewViewController: UIViewController {
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    var imageList = [ImageData]()
    var index = 0
    var isScrolled = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageCollectionView.register(UINib(nibName: "ImageDetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "imageCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        imageCollectionView.reloadData()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !isScrolled && imageCollectionView.visibleCells.count > 0 {
            isScrolled = true
            imageCollectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: false)
        }
    }
}

extension PhotoDetailShowViewViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageDetailCollectionViewCell
        cell.initView(imageList[indexPath.item].url)
//        cell.imageView.kf.setImage(with: imageList[indexPath.item].url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}
