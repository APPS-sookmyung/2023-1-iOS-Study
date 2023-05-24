//
//  StoryCollectionViewCell.swift
//  Catstagram
//
//  Created by 정나윤 on 2023/04/30.
//

import UIKit

class StoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewImageViewBackground: UIView!
    @IBOutlet weak var viewUserProfileBackground: UIView!
    
    @IBOutlet weak var imageViewUserProfile: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewImageViewBackground.layer.cornerRadius = 24
        viewUserProfileBackground.layer.cornerRadius = 23.5
        imageViewUserProfile.layer.cornerRadius = 22.5
        imageViewUserProfile.clipsToBounds = true
    }

}
