//
//  VideoPlayerView.swift
//  Catstagram
//
//  Created by Suyeon Hwang on 2023/05/21.
//

import UIKit
import AVKit

class VideoPlayerView: UIView {
    
    var playerLayer: AVPlayerLayer?  // 영상의 레이어(크기) 담당하는 객체
    var playerLooper: AVPlayerLooper?  // 반복 재생 관련된 객체
    var queuePlayer: AVQueuePlayer?  // 영상의 순서 (먼저 들어온 것 먼저 재생)
    var urlStr: String  // 영상이 저장된 url
    
    init(frame: CGRect, urlStr: String) {
        self.urlStr = urlStr
        super.init(frame: frame)
        
        let videoFileURL = Bundle.main.url(forResource: urlStr, withExtension: "mp4")!
        let playItem = AVPlayerItem(url: videoFileURL)  // 위의 url을 아이템화
        
        self.queuePlayer = AVQueuePlayer(playerItem: playItem)
        playerLayer = AVPlayerLayer()
        
        playerLayer!.player = queuePlayer
        playerLayer!.videoGravity = .resizeAspectFill  // 비디오 사이즈를 어떻게 해서 보여줄지
        
        self.layer.addSublayer(playerLayer!)  // 현재 있는 뷰에 영상 레이어 추가
        
        playerLooper = AVPlayerLooper(player: queuePlayer!, templateItem: playItem)
        queuePlayer!.play()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func cleanup() {
        queuePlayer?.pause()
        queuePlayer?.removeAllItems()
        queuePlayer = nil  // -> 메모리에서 해제됨
    }
    
    // 레이아웃이 업데이트될 때마다 player의 프레임을 현재 프레임의 bounds와 맞추어주도록
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer!.frame = bounds
    }
}
