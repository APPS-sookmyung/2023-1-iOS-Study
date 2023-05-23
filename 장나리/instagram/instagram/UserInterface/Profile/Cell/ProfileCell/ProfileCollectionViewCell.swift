//
//  ProfileCollectionViewCell.swift
//  instagram
//
//  Created by 장나리 on 2023/05/09.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProfileCollectionViewCell"
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var editButton: UIButton!

    @IBOutlet weak var addProfileImageView: UIImageView!
    
    @IBOutlet weak var addFriendButton: UIButton!
    
    
    @IBOutlet weak var postingCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!

    @IBOutlet weak var followingCountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupAttribute()
    }

    
    private func setupAttribute(){
        profileImageView.layer.cornerRadius = 88/2
        addProfileImageView.layer.cornerRadius = 24/2
        
        profileImageView.layer.borderColor = UIColor.darkGray.cgColor
        profileImageView.layer.borderWidth = 1
        
        editButton.layer.cornerRadius = 5
        editButton.layer.borderColor = UIColor.lightGray.cgColor // cgColor를 하는 이유는 UIKit 내부에 경계선이나 그림을 그리는 그래픽 관련해서는 core graphic이라는 로우레벨의 라이브러리가 있음 이를 통해 border color를 주는 것.
        editButton.layer.borderWidth = 1
        
        addFriendButton.layer.cornerRadius = 3
        addFriendButton.layer.borderColor = UIColor.lightGray.cgColor
        addFriendButton.layer.borderWidth = 1
        
        [postingCountLabel,followerCountLabel,followingCountLabel].forEach{$0.text = "\(Int.random(in: 0...10))"}
    }
}
