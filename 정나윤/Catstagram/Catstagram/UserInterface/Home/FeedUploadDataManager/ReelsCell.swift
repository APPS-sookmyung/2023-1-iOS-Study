//
//  ReelsCell.swift
//  Catstagram
//
//  Created by 정나윤 on 2023/05/20.
//

import UIKit
import SnapKit
import AVKit // 영상용이니까

class ReelsCell: UICollectionViewCell {
    static let identifier = "ReelsCell"
    
    var videoView: VideoPlayerView?

    //UI라벨
    let cellTitleLabel = UILabel()
    
    //카메라
    let cameraImageView = UIImageView()
    //댓글
    let commentImageView = UIImageView()
    
    // 좋아요
    let likeImageView = UIImageView()
    
    //공유하기
    let shareImageView = UIImageView()

    //초기화 함수
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //url(string) 받아서 전달 후 어트리뷰트와 레이아웃 설정
    public func setupURL(_ urlStr: String){
        //객체 전달
        //self에 있는 videoView에 
        self.videoView = VideoPlayerView(frame: .zero, urlStr: urlStr)
        setupAttribute()
        setupLayout()
    }
    //어트리뷰트 셋업 메소드
    private func setupAttribute() {
        cellTitleLabel.text = "릴스"
        cellTitleLabel.font = .boldSystemFont(ofSize: 25)
        cellTitleLabel.textAlignment = .left
        cellTitleLabel.textColor = .white
        
        
        // 반복되는 코드 처리
        [cameraImageView, shareImageView, likeImageView, commentImageView]
            .forEach{
                // UIImageView의 크기
                $0.contentMode = .scaleAspectFit
                $0.tintColor = .white
            }
        
        cameraImageView.image = UIImage(systemName: "camera")
        shareImageView.image = UIImage(systemName: "paperplane")
        commentImageView.image = UIImage(systemName: "message")
        likeImageView.image = UIImage(systemName: "suit.heart")

        
    }
    //레이아웃 셋업 메소드
    private func setupLayout(){
        //만약 videoView에 대한 값이 있다면 코드 실행
        guard let videoView = videoView else { return }
        contentView.addSubview(videoView)
        
        //비디오 뷰의 상하좌우 모서리에 대해 현재 있는 컨텐트 뷰에 맞춤
        // makeConstraints => constraints 추가
        videoView.snp.makeConstraints { make in make.edges.equalToSuperview()
            
        }
        //반복되는 코드 처리
        [cellTitleLabel, cameraImageView,likeImageView,commentImageView,shareImageView]
            .forEach{contentView.addSubview($0)}
        
        cellTitleLabel.snp.makeConstraints {make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        //오토레이아웃
        cameraImageView.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.width.height.equalTo(35)

        }
        
        shareImageView.snp.makeConstraints{make in
            make.bottom.equalToSuperview().offset(-50)
            make.trailing.trailing.equalToSuperview().offset(-20)
            make.width.height.equalTo(35)
        }
        
        let space = CGFloat(20)
        
        commentImageView.snp.makeConstraints{make in
            make.bottom.equalTo(shareImageView.snp.top).offset(-space)
            make.trailing.trailing.equalTo(shareImageView)
            make.width.height.equalTo(35)
        }
        likeImageView.snp.makeConstraints{make in
            make.bottom.equalTo(commentImageView.snp.top).offset(-space)
            make.trailing.trailing.equalTo(shareImageView)
            make.width.height.equalTo(35)
        }
    }
}
