//
//  ReelsCell.swift
//  Catstagram
//
//  Created by Seo Cindy on 2023/05/25.
//

import UIKit
import SnapKit
import AVKit // for 영상

class ReelsCell : UICollectionViewCell{
    static let identifier = "ReelsCell"
    
    // videoplayer 등록
    var videoView: VideoPlayerView?
    
    // UI 추가
    // 릴스
    let cellTitleLabel = UILabel()
    
    // 카메라
    let cameraImageView = UIImageView()
    
    // 댓글
    let commentImageView = UIImageView()
    
    // 좋아요
    let likeImageView = UIImageView()
    
    // 공유하기
    let shareImageView = UIImageView()
    
    
    // 초기화 함수
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder : NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setUpURL(_ urlStr: String){
        self.videoView = VideoPlayerView(frame: .zero, urlStr: urlStr)
        
        setUpAttribute()
        setUpLayout()
    }
    
    private func setUpAttribute(){
        cellTitleLabel.text = "릴스"
        cellTitleLabel.font = .boldSystemFont(ofSize: 25)
        cellTitleLabel.textAlignment = .left
        cellTitleLabel.textColor = .white
        
        // 반복되는 코드 처리
        [cameraImageView, shareImageView, likeImageView, commentImageView].forEach{
            $0.contentMode = .scaleAspectFit
            $0.tintColor = .white
        }
        
        cameraImageView.image = UIImage(systemName: "camera")
        shareImageView.image = UIImage(systemName: "paperplane")
        commentImageView.image = UIImage(systemName: "message")
        likeImageView.image = UIImage(systemName: "suit.heart")
        
    
    }
    
    private func setUpLayout(){
        // SnapKit 사용
        guard let videoView = videoView else {return}
        contentView.addSubview(videoView)
        
        videoView.snp.makeConstraints { make in
            // make = videoView, 각 변을 현재 cell의 contentView에 맞춘다
            make.edges.equalToSuperview()
        }
        
        // content에 ui 추가
        [cellTitleLabel, cameraImageView,
        likeImageView,
        commentImageView,
         shareImageView]
            .forEach{contentView.addSubview($0)}
        
        cellTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20) // offset : 간격
            make.leading.equalToSuperview().offset(20)
        }
        
        cameraImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.width.height.equalTo(35)
        }
        
        shareImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.trailing.equalToSuperview().offset(-20)
            make.width.height.equalTo(35)
        }
        
        let space = CGFloat(15)
        
        commentImageView.snp.makeConstraints { make in
            make.bottom.equalTo(shareImageView.snp.top).offset(-space)
            make.centerX.equalTo(shareImageView)
            make.width.height.equalTo(35)
        }
        
        likeImageView.snp.makeConstraints { make in
            make.bottom.equalTo(commentImageView.snp.top).offset(-space)
            make.centerX.equalTo(shareImageView)
            make.width.height.equalTo(35)
        }
    }
}
