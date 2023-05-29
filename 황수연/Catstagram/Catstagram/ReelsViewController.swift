//
//  ReelsViewController.swift
//  Catstagram
//
//  Created by Suyeon Hwang on 2023/05/21.
//

import UIKit
import SnapKit

class ReelsViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let videoURLStrArr = ["dummyVideo01", "dummyVideo02"]
    private var curPage = 0  // 현재 어떤 페이지에 있는지
    
    // MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }

    // MARK: - Actions
    
    // MARK: - Helpers
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.decelerationRate = .fast  // 스크롤이 빨리 되도록
//        collectionView.register(UINib(nibName: "ReelsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ReelsCollectionViewCell.identifier)
        collectionView.register(ReelsCell.self, forCellWithReuseIdentifier: ReelsCell.identifier)
        
        startLoop()
    }
    
    private func startLoop() {
        // 2초마다 코드 블록 내의 메소드가 호출되도록
        let _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
            self.moveNextPage()
        }
    }
    
    private func moveNextPage() {
        let itemCount = collectionView.numberOfItems(inSection: 0)  // 몇 개의 아이템이 있는지
        
        curPage += 1
        
        if curPage >= itemCount {
            // 이 경우는 마지막 페이지인 경우임
            curPage = 0  // 처음으로 돌아가기
        }
        
        collectionView.scrollToItem(at: IndexPath(item: curPage, section: 0), at: .centeredVertically, animated: true)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ReelsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(
//            withReuseIdentifier: ReelsCollectionViewCell.identifier,
//            for: indexPath) as? ReelsCollectionViewCell else { fatalError() }
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ReelsCell.identifier,
            for: indexPath) as? ReelsCell else { return UICollectionViewCell() }
        cell.setupURL(videoURLStrArr.randomElement()!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ReelsCell {
            cell.videoView?.cleanup()
        }
    }
    
}

extension ReelsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: collectionView.frame.width,
            height: collectionView.frame.height
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
}
