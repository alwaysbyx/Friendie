//
//  Music.swift
//  Friendie
//
//  Created by Com on 2020/5/30.
//  Copyright © 2020 Com. All rights reserved.
//

import Foundation

// MARK: - MusicAction
enum MusicAction {
    case start
    case stop
}

// MARK: - MusicAction
enum MusicVolumeAction {
    case mute
    case unmute
}

extension MusicVolumeAction {

    func invert() -> MusicVolumeAction {

        if self == .mute { return .unmute
        } else { return .mute }
    }
}
