//
//  ProfileViewController.swift
//  Catstagram
//
//  Created by Suyeon Hwang on 2023/05/06.
//

import UIKit

class ProfileViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var profileCollectionView: UICollectionView!
    
    var userPosts: [GetUserPosts]? {
        didSet {
            self.profileCollectionView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupData()
    }
    
    // MARK: - Actions
    
    // MARK: - Helpers
    private func setupCollectionView() {
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        
        // collection view에 프로필 정보 셀 등록
        profileCollectionView.register(
            UINib(nibName: "ProfileCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ProfileCollectionViewCell.identifier)
        
        // collection view에 피드 셀 등록
        profileCollectionView.register(
            UINib(nibName: "PostCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: PostCollectionViewCell.identifier)
    }
    
    private func setupData() {
        UserFeedDataManager().getUserFeed(self)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    // 섹션의 개수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
        // 첫번째 섹션은 프로필 화면, 두번째 섹션은 게시글들
    }
    
    // 섹션 당 아이템의 개수 (셀 개수)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
             return 1
        default:
            return userPosts?.count ?? 0
        }
    }
    
    // 재사용 cell에 데이터를 넣어주는 메소드 (셀을 생성)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = indexPath.section
        switch section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.identifier, for: indexPath) as? ProfileCollectionViewCell else{
                return UICollectionViewCell()  // ProfileCollectionViewCell로 타입캐스팅 실패한 경우
                // 혹은  fatalError("셀 타입 캐스팅 실패...")
            }
            
            return cell
            
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.identifier, for: indexPath) as? PostCollectionViewCell else{
                return UICollectionViewCell()  // ProfileCollectionViewCell로 타입캐스팅 실패한 경우
                // 혹은  fatalError("셀 타입 캐스팅 실패...")
            }
            
            let itemIndex = indexPath.item
            
            // self의 userPosts라는 데이터가 있다면
            if let cellData = self.userPosts {
                // 데이터가 있는 경우 cell의 데이터를 전달
                cell.setupData(cellData[itemIndex].postImgUrl)
            }
            
            
            return cell
        }
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout{
    // cell의 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let section = indexPath.section
        
        switch section {
        case 0:
            // 프로필 화면의 경우 너비는 컬렉션뷰에 꽉 차게
            return CGSize(width: collectionView.frame.width, height: CGFloat(159))
            
        default:
            let width = CGFloat((collectionView.frame.width - 4) / 3)
            return CGSize(width: width, height: width)
        }
    }
    
    // 아이템 간 간격을 지정하기 위해 메소드 작성 (열 간 간격)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0:
            return CGFloat(0)
        default:
            return CGFloat(1)
        }
    }
    
    // 아이템으로 이루어진 행 간 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0:
            return CGFloat(0)
        default:
            return CGFloat(1)
        }
    }
}

// MARK: - API 통신 메소드
extension ProfileViewController {
    func successFeedAPI(_ result: UserFeedModel){
        //self.userPosts = result.userPosts
        self.userPosts = result.result?.userPosts
    }
}
