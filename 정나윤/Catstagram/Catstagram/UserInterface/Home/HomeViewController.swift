//
//  HomeViewController.swift
//  Catstagram
//
//  Created by 정나윤 on 2023/04/30.
//

import UIKit
import Kingfisher


class HomeViewController: UIViewController{
    
   

    @IBOutlet weak var tableView: UITableView!
    
    var arrayCat : [FeedModel] = []
    
    let imagePickerViewController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        let feedNib = UINib(nibName: "FeedTableViewCell", bundle: nil)
        tableView.register(feedNib, forCellReuseIdentifier: "FeedTableViewCell")
        let storyNib = UINib(nibName: "StoryTableViewCell", bundle: nil)
        tableView.register(storyNib, forCellReuseIdentifier: "StoryTableViewCell")
        
        
        
        let input = FeedAPIInput (limit: 5, page: 0, api_key:"live_Dg3jt2SwxaIjtMVPEFGv18EXEppDgcjlMBfJJhXmDyKFN7KA8XkmHZs49Kb8xLnx")
        
        FeedDataManager().feedDataManager(input, self)
        
        imagePickerViewController.delegate = self
    }

    @IBAction func buttonGoAlbum(_ sender: Any) {
        self.imagePickerViewController.sourceType = .photoLibrary
        self.present(imagePickerViewController, animated: true, completion: nil)
    }
}
extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCat.count + 1 // 스토리 셀이니까 배열의 크기보다 1만큼 셀 존재
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoryTableViewCell", for: indexPath) as? StoryTableViewCell
            else {
                return UITableViewCell()
            }
            return cell
        } else {
            guard let  cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as? FeedTableViewCell else {
                return UITableViewCell()
            }
            if let urlString = arrayCat[indexPath.row - 1].url{
                let url = URL(string: urlString)
                // 받아온 서버의 사진을  셀 안에 있는 imageViewFeed에 넣음
                //UIImage에는 사진을 받아 오기로 했던 변수의 stringd이 없음 => Kingfisher : UIImage에 string 만들어줌
                cell.imageViewFeed.kf.setImage(with: url)
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 80
        } else {
            return 600
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? StoryTableViewCell else {
            return
        }
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 스토리 프로필 개수
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCollectionViewCell", for: indexPath) as? StoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 60)
    }
}
extension HomeViewController {
    //서버 연동 했을 떄 함수
    func successAPI(_ result : [FeedModel]) {
        arrayCat = result
        tableView.reloadData()
    }
}

extension HomeViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let imageString = "https://firebasestorage.googleapis.com/v0/b/catstargram-d7fbf.appspot.com/o/Cat?alt=media&token=a7e69494-443f-425d-a86a-59be45d75a43"
            let input = FeedUploadInput(content: "저희 고양이입니다. 귀엽지 않나요?", postImgsUrl: [imageString])
            FeedUploadDataManager().posts(self, input)
            
            self.dismiss(animated: true, completion: nil)
        }
    }
}
