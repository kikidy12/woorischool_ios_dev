//
//  PSDailyNoteViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/22.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class PSDailyNoteViewController: UIViewController {
    
    var schedule: LectureScheduleData!
    
    var dailyNote: DailyNoteData! {
        didSet {
            
            guard dailyNote != nil else {
                self.dismiss(animated: true, completion: nil)
                return
            }
            dateLabel.text = dailyNote.writeTime
            titleLabel.text = schedule.date.dateToString(formatter: "MM월 dd일자 알림장")
            contentLabel.text = dailyNote.content
            materialLabel.text = dailyNote.materials ?? "없음"
            homeworkLabel.text = dailyNote.homework ?? "없음"
            
            if dailyNote.imageList.count == 0 {
                imageContainerView.isHidden = true
                imageCountLabel.isHidden = true
            }
            else if dailyNote.imageList.count == 1 {
                imageContainerView.isHidden = false
                imageCountLabel.isHidden = true
            }
            else {
                imageContainerView.isHidden = false
                imageCountLabel.text = "\(1)/\(dailyNote.imageList.count)"
                imageCountLabel.isHidden = false
            }
            
            noteImageCollectionView.reloadData()
        }
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var materialLabel: UILabel!
    @IBOutlet weak var homeworkLabel: UILabel!
    @IBOutlet weak var imageCountLabel: UILabel!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var noteImageCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard schedule != nil else {
            dismiss(animated: true, completion: nil)
            return
        }
        
        noteImageCollectionView.register(UINib(nibName: "ImagePagingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "imageCell")
        getDailyNote()
    }
}

extension PSDailyNoteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyNote == nil ? 0 : dailyNote.imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImagePagingCollectionViewCell
        cell.boardImageView.kf.setImage(with: dailyNote.imageList[indexPath.item].url, placeholder: UIImage(named: "tempImage"))
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        noteImageCollectionView.visibleCells.forEach {
            imageCountLabel.text = "\(noteImageCollectionView.indexPath(for: $0)!.item + 1)/\(dailyNote.imageList.count)"
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return (collectionView.frame.width - 304)
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return .init(width: 304, height: collectionView.frame.height)
        return .init(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        let padding = (collectionView.frame.width - 304) / 2
//        return .init(top: 0, left: padding, bottom: 0, right: padding)
        return .init(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension PSDailyNoteViewController {
    func getDailyNote() {
        let parameters = [
            "lecture_schedule_id": schedule.id!
            ] as [String:Any]
        
        ServerUtil.shared.postV2Announcement(self, parameters: parameters) { (success, dict, message) in
            guard success, let note = dict?["announcement"] as? NSDictionary else {
                return
            }
            
            self.dailyNote = DailyNoteData(note)
        }
    }
}
