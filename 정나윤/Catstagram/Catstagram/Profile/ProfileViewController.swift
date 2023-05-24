//
//  ProfileViewController.swift
//  Catstagram
//
//  Created by 정나윤 on 2023/05/10.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    //MARK : -Properties
    @IBOutlet weak var profileCollectionView: UICollectionView!
    
    var userPosts : [GetUserPosts]? {
        didSet { self.profileCollectionView.reloadData() }
    }
    //MARK : -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupData()
    }
    //MARK : -Actions
    //MARK : -Helpers
    private func setupCollectionView(){
        // delegate 연결
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        //cell 등록
        profileCollectionView.register(UINib(nibName: "ProfileCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ProfileCollectionViewCell.identifier)
        
        //PostCollectionViewCell
        profileCollectionView.register(UINib(nibName: "PostCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: PostCollectionViewCell.identifier)
    }
    // 이미지 뷰의 이미지 업롣
    private func setupData(){
        UserFeedDataManager().getUserFeed(self)
    }
}
//MARK : -UICollectionViewDelegate, UICollectionViewDataSource
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    //섹션의 갯수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    //Cell의 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default : //1
            return userPosts?.count ?? 0
        }
    }
    // cell 생성
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = indexPath.section
        switch section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.identifier, for: indexPath) as? ProfileCollectionViewCell else {
                //return UICollectionViewCell()
                fatalError("셀 타입 캐스팅 실패..")
            }
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.identifier, for: indexPath) as? PostCollectionViewCell else {
                //return UICollectionViewCell()
                fatalError("셀 타입 캐스팅 실패..")
            }
            let itemIndex = indexPath.item
            if let cellData = self.userPosts {
                //데이터가 있는 경우, cell 데이터를 전달
                cell.setupData(cellData[itemIndex].postImgUrl)

            }
           
            return cell
            
        }
        
    }
}
extension ProfileViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //코어 그래픽 사이즈 리턴
        let section = indexPath.section
        switch section {
        case 0:
            return CGSize(width: collectionView.frame.width, height: CGFloat(159))
        default:
            let side = (CGFloat(collectionView.frame.width / 3) - (4/3))
            return CGSize(width : side, height: side)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        //열 간 간격
        switch section{
        case 0:
            return CGFloat(0)
        default:
            return CGFloat(1)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //행 간 간격
        switch section{
        case 0:
            return CGFloat(0)
        default:
            return CGFloat(1)
        }
    }
}

extension ProfileViewController{
    func successFeedAPI(_ result: UserFeedModel) {
        self.userPosts = result.result?.getUserPosts
    }
}
