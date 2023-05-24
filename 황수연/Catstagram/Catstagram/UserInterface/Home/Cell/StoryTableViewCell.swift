//
//  StoryTableViewCell.swift
//  Catstagram
//
//  Created by Suyeon Hwang on 2023/04/13.
//

import UIKit

class StoryTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDelegate & UICollectionViewDataSource, forRow row: Int){
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        
        // story collection view cell 등록해주기
        let storyNib = UINib(nibName: "StoryCollectionViewCell", bundle: nil)
        collectionView.register(storyNib, forCellWithReuseIdentifier: "StoryCollectionViewCell")
        
        // collectionview의 스크롤 방향, 아이템 간 간격
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)  // collection view 전체에서 마진값..?
        flowLayout.minimumLineSpacing = 12
        
        // 설정 다 마친 flow layout을 collectionview의 레이아웃으로 설정해주기
        collectionView.collectionViewLayout = flowLayout
        
        // 위의 과정에서 등록이 되었을 때 collection view를 reload
        collectionView.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
