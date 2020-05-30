//
//  NodeType.swift
//  Friendie
//
//  Created by Com on 2020/5/29.
//  Copyright © 2020 Com. All rights reserved.
//

import ARKit

enum NodeType: String {
    case ghost = "ghost"
    case sight = "sight"
    case boss = "boss"
    case antiBossBuff = "antiBossBuff"
}

extension NodeType {
    func asSprite() -> SKSpriteNode {
        return SKSpriteNode(imageNamed: self.rawValue)
    }
}

// MARK: - Anchor
class Anchor: ARAnchor {

    var type: NodeType?
}
