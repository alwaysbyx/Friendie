//
//  Porvider.swift
//  Friendie
//
//  Created by Com on 2020/5/30.
//  Copyright © 2020 Com. All rights reserved.
//

import AVKit
import Foundation

// MARK: - PersistenceProvidable
protocol PersistenceProvidable {

    // MARK: Properties
    var highestScore: Int { get }

    // MARK: Functions
    func isHighestScore(_ score: Int) -> Bool
}

// MARK: - PersistenceProvider
final class PersistenceProvider: PersistenceProvidable {

    // MARK: Constant
    private enum Constant {
        static let highestScoreKey = "ARbuster_highestScore"
    }

    // MARK: Properties
    var highestScore: Int {
        get { return userDefaults.integer(forKey: Constant.highestScoreKey) }
    }

    func isHighestScore(_ score: Int) -> Bool {

        if score < highestScore {
            userDefaults.set(score, forKey: Constant.highestScoreKey)
            return true
        }

        return false
    }

    // MARK: Private Properties
    private let userDefaults: UserDefaults

    // MARK: Initializer
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
}


// MARK: - MusicProvidable
protocol MusicProvidable {
    func apply(_ action: MusicAction)
    func apply(_ volumeAction: MusicVolumeAction)
}

// MARK: - MusicProvider
final class MusicProvider {

    // MARK: Constant
    private enum Constant {
        static let volume: Float = 0.1
    }

    // MARK: Properties
    private var player: AVPlayer

    // MARK: Initializer
    init() {

        player = AVPlayer()
    }
}

extension MusicProvider: MusicProvidable {

    func apply(_ action: MusicAction) {

        switch action {

        case .start: start()
        case .stop: stop()
        }
    }

    func apply(_ volumeAction: MusicVolumeAction) {

        switch volumeAction {

        case .mute: mute()
        case .unmute: unmute()
        }
    }
}

private extension MusicProvider {

    func start() {
        guard let backgroundPlayer = AVPlayer(name: Music.theme, extension: Extension.mp3) else { return }

        player = backgroundPlayer

        player.volume = Constant.volume
        player.playLoop()
    }

    func stop() {
        player.volume = 0
        player.endLoop()
    }

    func mute() {
        player.volume = 0
    }

    func unmute() {
        player.volume = Constant.volume
    }
}
