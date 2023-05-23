//
//  ProfileViewController.swift
//  instagram
//
//  Created by 장나리 on 2023/05/09.
//

import UIKit

class ProfileViewController: UIViewController, UIGestureRecognizerDelegate {
    //MARK: - Properties
    @IBOutlet weak var profileCollectionView: UICollectionView!
    var userPosts: [GetUserPosts]? {
        didSet{self.profileCollectionView.reloadData()}
    }
    
    var deleteIndex : Int?
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
//        UserFeedDataManager().getUserFeed(self)
        
        setupData()
    }
    
    //MARK: - Actions
    @objc
    func didLongPressCell(gestureRecognizer: UILongPressGestureRecognizer){
        if gestureRecognizer.state != .began{return} // 오래 눌렀을 때만 동작
        
        let position = gestureRecognizer.location(in: profileCollectionView)
        if let indexPath = profileCollectionView?.indexPathForItem(at: position) {
            print("DEBUG: ", indexPath.item)
            
            guard let userPosts = self.userPosts else {return}
            let cellData = userPosts[indexPath.item]
            self.deleteIndex = indexPath.item
            if let postIdx = cellData.postIdx{
                //삭제 API 호출
                UserFeedDataManager().deleteUserFeed(self, postIdx)
            }
        }
    }
    
    //MARK: - Helpers
    private func setupCollectionView(){
        //delegate 연결
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        
        //cell 등록
        profileCollectionView.register(UINib(
            nibName: "ProfileCollectionViewCell",
            bundle: nil),
            forCellWithReuseIdentifier: ProfileCollectionViewCell.identifier)
        
        profileCollectionView.register(UINib(
            nibName: "PostCollectionViewCell",
            bundle: nil),
            forCellWithReuseIdentifier: PostCollectionViewCell.identifier)
        
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(didLongPressCell(gestureRecognizer: )))
        gesture.minimumPressDuration = 0.66
        gesture.delegate = self
        gesture.delaysTouchesBegan = true
        profileCollectionView.addGestureRecognizer(gesture)
    }
    
    private func setupData(){
        UserFeedDataManager().getUserFeed(self)
    }
}

//MARK: - UICollectionViewDelegate,UICollectionViewDataSource
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //cell의 개수
        switch section {
        case 0:
            return 1
        default:
            return userPosts?.count ?? 0
        }
    }
    //cell 생성
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = indexPath.section
        switch section {
        case 0: // Profile
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.identifier, for: indexPath) as? ProfileCollectionViewCell else{
    //            return UICollectionViewCell()
                fatalError("셀 타입 캐스팅 실패")
            }
            return cell
        default: // Post
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.identifier, for: indexPath) as? PostCollectionViewCell else{
    //            return UICollectionViewCell()
                fatalError("셀 타입 캐스팅 실패")
            }
            let itemIndex = indexPath.item
            if let cellData = self.userPosts{
                // 데이터가 있는 경우, cell 데이터를 전달
                cell.setupData(cellData[itemIndex].postImgUrl)
            }
             // <- 데이터 전달
            return cell
        }
        
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = indexPath.section
        switch section {
        case 0:
            return CGSize(width: collectionView.frame.width, height: 159)
        default:
            let side = CGFloat((collectionView.frame.width/3)-(4/3))
            return CGSize(width: side, height: side)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { //아이템간(열간) spacing
        switch section {
        case 0:
            return CGFloat(0)
        default:
            return CGFloat(1)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { // 행간 spacing
        switch section {
        case 0:
            return CGFloat(0)
        default:
            return CGFloat(1)
        }
    }
}

// MARK: - API 통신 메소드
extension ProfileViewController{
    func successFeedAPI(_ result: UserFeedModel){
        self.userPosts = result.result?.getUserPosts
    }
    func successDeletePostAPI(_ isSuccess: Bool) { // 서버에서 성공했다고 하면 로컬에서도 삭제
        guard isSuccess else{return}
        
        if let deleteIndex = self.deleteIndex{
            self.userPosts?.remove(at: deleteIndex)
        }
        
    }
}
