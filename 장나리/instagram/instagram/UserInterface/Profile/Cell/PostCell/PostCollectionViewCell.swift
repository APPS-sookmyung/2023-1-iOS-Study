//
//  PostCollectionViewCell.swift
//  instagram
//
//  Created by 장나리 on 2023/05/10.
//

import UIKit
import Kingfisher

class PostCollectionViewCell: UICollectionViewCell {

    static let identifier = "PostCollectionViewCell"
    
    
    @IBOutlet weak var postImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    public func setupData(_ imageURLStr : String?){
        //이미지뷰의 이미지를 업로드 한다.
        
        guard let imageURLStr = imageURLStr else{return}
        
//        if let imageURL = URL(string: imageURLStr){
//
//        }
        if let url = URL(string: imageURLStr){
            postImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo"))
        }
        
    }
}
