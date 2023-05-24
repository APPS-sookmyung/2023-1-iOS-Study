
import UIKit
import Kingfisher

class PostCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    
    static let identifier = "PostCollectionViewCell"

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setupData(_ imageURLStr: String?) {
        guard let imageURLStr = imageURLStr else { return }
        if let url = URL(string: imageURLStr){
            postImageView.kf.setImage(
                with: url,
                placeholder: UIImage(systemName: "photo"))
        }
            
    }

}
