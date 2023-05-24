//
//  ReelsViewController.swift
//  Catstagram
//
//  Created by Seo Cindy on 2023/05/24.
//

import UIKit
import SnapKit

class ReelsViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // 비디오 등록
    private let videoURLStr = ["dummyVideo1", "dummyVideo2"]
    
    // 현재 어떤 페이지에 있는지
    private var nowPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()

        // Do any additional setup after loading the view.
    }
    
    private func setUpCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.decelerationRate = .fast // 스크롤이 빨리 되도록
//        collectionView.register(
//            UINib(nibName: "ReelsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ReelsCollectionViewCell.identifier
//        )
        collectionView.register(ReelsCell.self, forCellWithReuseIdentifier: ReelsCell.identifier)
        startLoop()
    }
    
    private func startLoop(){
        // 타이머 사용 : 2초마다 반복재생
        let _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
            self.moveNextPage()
        }
    }
    
    private func moveNextPage(){
        let itemCount = collectionView.numberOfItems(inSection: 0)
        
        nowPage += 1
        
        if (nowPage >= itemCount){
            // 마지막 페이지인 경우 -> 다시 처음으로
            nowPage = 0
        }
        
        // collectionView가 처음으로 돌아가도록
        collectionView.scrollToItem(
            at: IndexPath(item: nowPage, section: 0),
            at: .centeredVertically,
            animated: true)
    }
}

extension ReelsViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(
//            withReuseIdentifier: ReelsCollectionViewCell.identifier,
//            for: indexPath) as? ReelsCollectionViewCell else {fatalError()}
//
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ReelsCell.identifier,
            for: indexPath) as? ReelsCell else { return UICollectionViewCell()}
        
        // 비디오 url 전달 : 랜덤으로 전달
        cell.setUpURL(videoURLStr.randomElement()!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ReelsCell {
            // 해당 cell 접근 성공 시
            cell.videoView?.cleanUp()
        }
    }
    
}

extension ReelsViewController : UICollectionViewDelegateFlowLayout{
    // cell 사이즈 조절
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: collectionView.frame.width,
            height: collectionView.frame.height)
    }
    
    // cell 여백 조정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
}
