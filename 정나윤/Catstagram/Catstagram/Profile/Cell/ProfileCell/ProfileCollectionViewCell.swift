//
//  ProfileCollectionViewCell.swift
//  Catstagram
//
//  Created by 정나윤 on 2023/05/10.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProfileCollectionViewCell"

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var addProfileImageView: UIImageView!
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var addFriendButton: UIButton!
    
    
    @IBOutlet weak var postingCountLabel: UILabel!
    @IBOutlet weak var followerCountlabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //ImageView에 대해서 이 코드가 실행됨
        setupAttribute()
    }
    private func setupAttribute(){
        profileImageView.layer.cornerRadius = 88 / 2
        addProfileImageView.layer.cornerRadius = 24 / 2
        
        profileImageView.layer.borderColor = UIColor.darkGray.cgColor
        profileImageView.layer.borderWidth = 1
        
        editButton.layer.cornerRadius = 5
        editButton.layer.borderColor = UIColor.lightGray.cgColor
        editButton.layer.borderWidth = 1
        
        addFriendButton.layer.cornerRadius = 3
        addFriendButton.layer.borderColor = UIColor.lightGray.cgColor
        addFriendButton.layer.borderWidth = 1
        
        [postingCountLabel, followerCountlabel, followingCountLabel].forEach { $0.text = "\(Int.random(in: 0...10))"}
    }
}
