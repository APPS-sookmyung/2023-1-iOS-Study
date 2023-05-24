//
//  PostCollectionViewCell.swift
//  Catstagram
//
//  Created by Suyeon Hwang on 2023/05/07.
//

import UIKit
import Kingfisher

class PostCollectionViewCell: UICollectionViewCell {
    static let identifier = "PostCollectionViewCell"
    
    @IBOutlet weak var postImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // 외부에서 이미지뷰의 이미지를 설정해야 하므로 public
    public func setupData(_ imageURLStr: String?){
        // 이미지뷰의 이미지 업로드
        
        guard let imageURLStr = imageURLStr else {
            return
        }
        
        if let url = URL(string: imageURLStr) {
            postImageView.kf.setImage(
                with: url,
                placeholder: UIImage(systemName: "photo"))
        }
    }

}
