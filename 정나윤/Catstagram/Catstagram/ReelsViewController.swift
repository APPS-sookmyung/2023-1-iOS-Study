//
//  ReelsViewController.swift
//  Catstagram
//
//  Created by 정나윤 on 2023/05/20.
//

import UIKit


class ReelsViewController: UIViewController {
    //MARK: - Properties
    
    @IBOutlet weak var collectionView: UICollectionView!
        private var nowPage = 0
    
    private let videoURLStrArr = ["IMG_7887", "IMG_7890"] //영상 이름에 맞게
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    

    
    // MARK: - Helpers

    private func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        //스크롤 속도 조정
        collectionView.decelerationRate = .fast
        collectionView.register(ReelsCell.self, forCellWithReuseIdentifier: ReelsCell.identifier)
        
        starloop()
    }
    private func starloop(){
        //2초마다 반복
        // 매개변수 사용 안 함
        let _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) {_ in
            self.moveNextPage()
        }
    }
    //메소드 구현
    private func moveNextPage() {
        let itemCount = collectionView.numberOfItems(inSection: 0) // 0번째있는 섹션의 개수
        
        nowPage+=1
        if(nowPage >= itemCount){
            //마이페이지인 경우
            //처음으로 돌아감
            nowPage=0
        }
        //스크롤이 처음으로 돌아감
        //수직 이동
        collectionView.scrollToItem(at: IndexPath(item: nowPage, section: 0), at: .centeredVertically, animated: true)
    }
}
extension ReelsViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        12
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReelsCell.identifier, for: indexPath) as? ReelsCell else { return UICollectionViewCell() }
        cell.setupURL(videoURLStrArr.randomElement()!) //랜덤으로 전달
        return cell
    }
    //메모리 관리
    internal func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt inedexPath: IndexPath){
        if let cell = collectionView.cellForItem(at: inedexPath) as? ReelsCell {
            cell.videoView?.cleanup()
        }
    }
    
}
// 사이즈 조정
extension ReelsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
}
