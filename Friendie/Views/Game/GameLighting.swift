//
//  GameLighting.swift
//  Friendie
//
//  Created by Com on 2020/5/29.
//  Copyright © 2020 Com. All rights reserved.
//

import ARKit

// MARK: - GameLighting
struct GameLighting {

    // MARK: Constant
    private enum Constant {
        static let defaultFactor: CGFloat = 1.0
        static let neutralLight: CGFloat = 750
    }
}

// MARK: - Functions
extension GameLighting {

    static func blendFactor(lightEstimate: ARLightEstimate?) -> CGFloat {

        guard let lightEstimate = lightEstimate else { return Constant.defaultFactor }

        let ambientIntensity = min(lightEstimate.ambientIntensity, Constant.neutralLight)

        return Constant.defaultFactor - ambientIntensity/Constant.neutralLight
    }
}
