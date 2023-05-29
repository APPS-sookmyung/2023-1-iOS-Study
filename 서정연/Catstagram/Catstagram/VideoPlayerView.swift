//
//  VideoPlayerView.swift
//  Catstagram
//
//  Created by Seo Cindy on 2023/05/25.
//

import UIKit
import AVKit

class VideoPlayerView: UIView{
    
    // 객체 선언
    var playerLayer:AVPlayerLayer?
    var playerLooper:AVPlayerLooper?
    var queuePlayer:AVQueuePlayer?
    var urlStr:String
    
    // 초기화 함수
    init(frame: CGRect, urlStr: String) {
        self.urlStr = urlStr
        super.init(frame: frame)
        
        
        // 객체에 값 넣기
        let videoFileURL = Bundle.main.url(forResource: urlStr, withExtension: "mp4")!
        let playItem = AVPlayerItem(url: videoFileURL) // 아이템화
        
        // 아이템 주입
        self.queuePlayer = AVQueuePlayer(playerItem: playItem)
        playerLayer = AVPlayerLayer()
        
        playerLayer!.player = queuePlayer
        playerLayer!.videoGravity = .resizeAspectFill // 화면 가득 채움
        
        // layer 추가
        self.layer.addSublayer(playerLayer!)
        
        // looper 생성
        playerLooper = AVPlayerLooper(player: queuePlayer!, templateItem: playItem)
        
        // play 실행
        queuePlayer!.play()
        
    }
    
    required init(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func cleanUp(){
        queuePlayer?.pause()
        queuePlayer?.removeAllItems()
        queuePlayer = nil // 메모리에서 해제
    }
    
    // layout 업데이트 될 때마다 player 프레임을 현재 뷰의 프레임 bounds와 맞추도록
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer!.frame = bounds
    }
}
