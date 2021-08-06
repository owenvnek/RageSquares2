//
//  VideoPlayer.swift
//  Rage Squares 2
//
//  Created by Owen Vnek on 7/5/18.
//  Copyright © 2018 Nio. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation

class VideoPlayer: UIViewController {
    
    private var player: AVPlayer!
    private var playerLayer: AVPlayerLayer!
    
    override func viewDidLoad() {
        guard let path = Bundle.main.path(forResource: "video", ofType:"mov") else {
            debugPrint("video.mp4 not found")
            return
        }
        let videoURL = URL(fileURLWithPath: path)
        player = AVPlayer(url: videoURL)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        self.view.layer.addSublayer(playerLayer)
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player.currentItem, queue: .main) { _ in
            self.player?.seek(to: kCMTimeZero)
            self.player?.play()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        playVideo()
        NotificationCenter.default.addObserver(self, selector: #selector(resume_video), name: NSNotification.Name(rawValue: "App Resumed"), object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    private func playVideo() {
        player.play()
    }
    
    @objc func resume_video() {
        player.play()
    }
    
}
