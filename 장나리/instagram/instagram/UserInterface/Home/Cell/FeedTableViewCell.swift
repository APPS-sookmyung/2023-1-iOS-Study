//
//  FeedTableViewCell.swift
//  instagram
//
//  Created by 장나리 on 2023/05/01.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    @IBOutlet weak var imageViewUserProfile: UIImageView!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var imageViewFeed: UIImageView!
    @IBOutlet weak var buttonIsHeart: UIButton!

    @IBOutlet weak var labelHowManyLike: UILabel!
    @IBOutlet weak var labelFeed: UILabel!
    @IBOutlet weak var imageViewMyProfile: UIImageView!
    
    @IBOutlet weak var buttonIsBookMark: UIButton!
    @IBAction func actionIsHeart(_ sender: Any) {
        if buttonIsHeart.isSelected{
            buttonIsHeart.isSelected = false
        }else{
            buttonIsHeart.isSelected = true
        }
    }
    
    @IBAction func actionIsBookMark(_ sender: Any) {
        if buttonIsBookMark.isSelected{
            buttonIsBookMark.isSelected = false
        }
        else{
            buttonIsBookMark.isSelected = true
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageViewUserProfile.layer.cornerRadius=12.5
        imageViewUserProfile.clipsToBounds = true
        imageViewMyProfile.layer.cornerRadius=12.5
        imageViewMyProfile.clipsToBounds = true
        
        let fontSize = UIFont.boldSystemFont(ofSize: 9)
        let attributeStr = NSMutableAttributedString(string: labelFeed.text ?? "")
        attributeStr.addAttribute(.font, value: fontSize, range:NSRange.init(location:0, length: 4))
        
        labelFeed.attributedText = attributeStr
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
