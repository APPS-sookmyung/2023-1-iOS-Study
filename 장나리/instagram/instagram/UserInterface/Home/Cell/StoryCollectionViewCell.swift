//
//  StoryCollectionViewCell.swift
//  instagram
//
//  Created by 장나리 on 2023/05/03.
//

import UIKit

class StoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageViewUserProfile: UIImageView!
    @IBOutlet weak var viewUserProfileBackground: UIView!
    @IBOutlet weak var viewImageViewBackground: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewImageViewBackground.layer.cornerRadius = 24
        viewUserProfileBackground.layer.cornerRadius = 23.5
        imageViewUserProfile.layer.cornerRadius = 22.5
        imageViewUserProfile.clipsToBounds = true
    }

}
