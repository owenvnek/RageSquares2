//
//  MainViewController.swift
//  Rage Squares 2
//
//  Created by Owen Vnek on 7/3/18.
//  Copyright © 2018 Nio. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        //playVideo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //playVideo()
    }
    
    private func playVideo() {
        guard let path = Bundle.main.path(forResource: "video", ofType:"mov") else {
            debugPrint("video.mp4 not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true) {
            player.play()
        }
    }
    
}
