//
//  AVPlayer.swift
//  Friendie
//
//  Created by Com on 2020/5/30.
//  Copyright © 2020 Com. All rights reserved.
//

import AVKit

extension AVPlayer {

    convenience init?(name: String, extension ext: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: ext) else { return nil }

        self.init(url: url)
    }

    func playLoop() {
        playFromStart()
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.currentItem, queue: nil) { notification in
            if self.timeControlStatus == .playing {
                self.playFromStart()
            }
        }
    }

    func endLoop() {
        pause()
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self)
    }

    private func playFromStart() {
        seek(to: CMTimeMake(value: 0, timescale: 1))
        play()
    }
}
