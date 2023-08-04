//
//  YoutubeIosHelperView.swift
//  QuitMate
//
//  Created by Саша Василенко on 14.07.2023.
//

import UIKit
import YoutubeKit

class YoutubePlayer: UIViewController, YTSwiftyPlayerDelegate {
    var player: YTSwiftyPlayer!
    var videoID: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let videoID = videoID else { return }
        player = YTSwiftyPlayer(
            frame: .zero,
            playerVars: [
                .playsInline(false),
                .videoID(videoID),
                .loopVideo(false),
                .showRelatedVideo(false),
                .autoplay(true)
            ])
        
        view = player
        player.delegate = self
        
        // Load video player
        
        player.loadDefaultPlayer()
    }
}

extension YoutubePlayer {
    func player(_ player: YTSwiftyPlayer, didChangeState state: YTSwiftyPlayerState) {
        switch state {
        case .ended:
            navigationController?.popViewController(animated: true)
        default:
            break
        }
    }
}


