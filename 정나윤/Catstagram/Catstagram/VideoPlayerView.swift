//
//  VideoPlayerView.swift
//  Catstagram
//
//  Created by 정나윤 on 2023/05/20.
//

import UIKit
import AVKit

class VideoPlayerView: UIView {
    //객체 선언
    var playerLayer: AVPlayerLayer? //재생될 때 레이어(크기) 잡아줌
    var playerLooper: AVPlayerLooper? // 영상의 반복
    var queuePlayer: AVQueuePlayer? // 영상순서(먼저 들어온 영상은 먼저, 나중에 들어온 영상은 나중에)
    var urlStr: String
    
    init(frame: CGRect, urlStr: String){
        self.urlStr = urlStr
        super.init(frame: frame)
        
        // 비디오가 있는 위치
        let videoFileURL = Bundle.main.url(forResource: urlStr, withExtension: "MOV")!
        //아이템화 시킴
        let playItem = AVPlayerItem(url: videoFileURL)
        
        self.queuePlayer = AVQueuePlayer(playerItem: playItem)
        playerLayer = AVPlayerLayer()
        
        playerLayer!.player = queuePlayer
        playerLayer!.videoGravity = .resizeAspectFill //가득 채움
        
        self.layer.addSublayer(playerLayer!)
        
        playerLooper = AVPlayerLooper(player: queuePlayer!, templateItem: playItem)
        queuePlayer!.play()
    }
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemenented")
    }
    // 영상을 다룰 때는 메모리 관계에 유의
    public func cleanup(){
        queuePlayer?.pause()
        queuePlayer?.removeAllItems()
        queuePlayer = nil
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer!.frame = bounds
    }

}
