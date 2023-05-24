//
//  ProfileViewController.swift
//  Catstagram
//
//  Created by Seo Cindy on 2023/05/10.
//

import UIKit

class ProfileViewController: UIViewController, UIGestureRecognizerDelegate {

    // MARK: - Properties
    @IBOutlet weak var profileCollectionView: UICollectionView!
    
    var userPosts : [GetUserPosts]?{
        // 데이터 전달 해준 다음에 UI 만들도록
        didSet{self.profileCollectionView.reloadData()}
    }
    
    // 삭제된 index
    var deletedIndex: Int?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        
        /* TEST */
        UserFeedDataManager().getUserFeed(self)
        
        // 네트워크 통신
        setUpData()
        
    }
    
    // MARK: -Actions
    @objc
    func didLongPressCell(gestureRecognizer : UILongPressGestureRecognizer){
        if gestureRecognizer.state != .began {return} // 시작한 상태가 아니라면 종료(오래 눌렀을 때만 동작하도록하는 방어 코드)
        let position = gestureRecognizer.location(in: profileCollectionView)
        
        if let indexPath = profileCollectionView?.indexPathForItem(at: position){
            print("DEBUG: ", indexPath.item) // 오래 누른 부분의 위치(어떤 cell)인지 확인
            
            guard let userPosts = self.userPosts else {return}
            let cellData = userPosts[indexPath.item]
            self.deletedIndex = indexPath.item
            if let postIdx = cellData.postIdx{
                // 삭제 API 호출(서버 데이터 삭제)
                UserFeedDataManager().deleteUserFeed(self, postIdx)
                
                // 로컬도 동시에 삭제(삭제된 API 다시 가져오는 것보다 데이터 사용량 줄일 수 있음) -> issue 발생 시 데이터 불일치 발생 가능
                
            }
            
            
        }
    }
    
    // MARK: -Properties
    
    // MARK: -Helpers
    private func setUpCollectionView(){
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        
        // cell 등록
        profileCollectionView.register(
            UINib(nibName: "ProfileCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: ProfileCollectionViewCell.identifier)
        
        profileCollectionView.register(
            UINib(nibName: "PostCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: PostCollectionViewCell.identifier)
        
        // gesture 생성
        let gesture = UILongPressGestureRecognizer(
            target: self, action: #selector(didLongPressCell(gestureRecognizer:))
        )
        
        // gesture 속성 설정
        gesture.minimumPressDuration = 0.66
        gesture.delegate = self
        gesture.delaysTouchesBegan = true
        profileCollectionView.addGestureRecognizer(gesture)
    }
    
    // 데이터 가져옴
    private func setUpData(){
        UserFeedDataManager().getUserFeed(self)
    }

}

// MARK: - 프로토콜 채택(UICollectionViewDelegate, UICollectionViewDataSource)
extension ProfileViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    // section 개수 설정
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    // cell 개수 -> 프로필 / 피드에 따라 다르게 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 데이터 개수만큼 지정
        switch section{
        case 0:
            return 1
        default:
            return userPosts?.count ?? 0
        }
    }
    
    // Cell 생성
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = indexPath.section
        switch section{
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as? ProfileCollectionViewCell else{
                // return UICollectionViewCell()
                fatalError("셀 타입캐스팅 실패")
            }
            return cell
            
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCollectionViewCell", for: indexPath) as? PostCollectionViewCell else{
                // return UICollectionViewCell()
                fatalError("셀 타입캐스팅 실패")
            }
            
            // cell.setUpData() <-- 데이터 전달
            let itemIndex = indexPath.item
            if let cellData = self.userPosts{
                // 데이터가 있는 경우 cell에 데이터 전달
                cell.setUpData(cellData[itemIndex].postImgUrl)
            }
            return cell
            
        }
        
    
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = indexPath.section
        switch section{
        case 0:
            return CGSize(width: collectionView.frame.width, height: CGFloat(159))
        default:
            // post 하나의 길이
            let side = CGFloat((collectionView.frame.width - 4) / 3) // 중간 여백 제외
            return CGSize(width: side, height: side)
            
        }
    }
    
    // post간의 좌/우 간격 설정 (열간 간격)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch section{
        case 0:
            return CGFloat(0)
        default:
            return CGFloat(1)
            
        }
    }
    // post 간의 위/아래 간격 설정(행간 간격)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch section{
        case 0:
            return CGFloat(0)
        default:
            return CGFloat(1)
            
        }
    }
    
}

// 호출 성공시의 메소드 : API 통신 메소드
extension ProfileViewController {
    func successFeedAPI(_ result : UserFeedModel){
        
        self.userPosts = result.result?.getUserPosts // 받아온 데이터 전달
    }
    
    // 로컬에서도 직접 삭제
    func successDeletePostAPI(_ isSuccess : Bool){
        guard isSuccess else { return}
        
        if let deletedIndex = self.deletedIndex{
            self.userPosts?.remove(at: deletedIndex)
        }
    }
}
