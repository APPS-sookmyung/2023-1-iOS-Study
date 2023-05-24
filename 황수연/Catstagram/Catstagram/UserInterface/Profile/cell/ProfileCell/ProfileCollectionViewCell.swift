//
//  ProfileCollectionViewCell.swift
//  Catstagram
//
//  Created by Suyeon Hwang on 2023/05/06.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProfileCollectionViewCell"
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var addProfileImageView: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var addFriendButton: UIButton!
    
    @IBOutlet weak var postingCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupAttribute()
    }

    private func setupAttribute(){
        profileImageView.layer.cornerRadius = 44  // 88/2
        addProfileImageView.layer.cornerRadius = 12  // 24/2
        
        profileImageView.layer.borderColor = UIColor.darkGray.cgColor
        profileImageView.layer.borderWidth = 1
        
        editButton.layer.cornerRadius = 5
        editButton.layer.borderColor = UIColor.lightGray.cgColor  // cgColor로 하는 이유는 UIKIT 내부에 보면 경계선이나 그림을 그리는 그래픽 관련해서는 core graphic이라는 로우 레벨의 라이브러리가 있음. 이를 통해서 보더 컬러를 주는 코드임
        editButton.layer.borderWidth = 1
        
        addFriendButton.layer.cornerRadius = 3
        addFriendButton.layer.borderColor = UIColor.lightGray.cgColor
        addFriendButton.layer.borderWidth = 1
        
        // $0에는 이번에 순회하게 되는 원소가 들어가게 됨
        [postingCountLabel, followerCountLabel, followingCountLabel]
            .forEach{ $0.text = "\(Int.random(in: 0...10))" }
    }
}
