//
//  EmoInputView.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/02.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

protocol EmoInputViewDelegate {
    func selectEmoticon(emoticon: ImageData)
}

class EmoInputView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {

    private let xibName = "EmoInputView"
    
    var delegate: EmoInputViewDelegate?
    
    var emoItemList = [ImageData]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    private func commonInit(){
        let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "EmoticonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "emoCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emoItemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emoCell", for: indexPath) as! EmoticonCollectionViewCell
        if let url = emoItemList[indexPath.item].url {
            cell.emoImageView.kf.setImage(with: url, placeholder: UIImage(named: "tempImage"))
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.selectEmoticon(emoticon: emoItemList[indexPath.item])
    }
}
