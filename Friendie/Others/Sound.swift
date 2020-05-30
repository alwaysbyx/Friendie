//
//  Sound.swift
//  Friendie
//
//  Created by Com on 2020/5/29.
//  Copyright © 2020 Com. All rights reserved.
//

import SpriteKit

enum Sound {
    static let shot = SKAction.playSoundFileNamed("shot", waitForCompletion: false)
    static let hit = SKAction.playSoundFileNamed("hit", waitForCompletion: false)
    static let buff = SKAction.playSoundFileNamed("buff", waitForCompletion: false)
}

enum Music {
    static let theme = "theme"
}

enum Extension {
    static let mp3 = "mp3"
}
