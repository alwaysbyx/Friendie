//
//  Dependency.swift
//  Friendie
//
//  Created by Com on 2020/5/30.
//  Copyright © 2020 Com. All rights reserved.
//

import Foundation

// MARK: - DependencyContainer
final class DependencyContainer: PersistenceDependency & MusicDependency {

    // MARK: Properties
    let persistenceProvider: PersistenceProvidable
    let musicProvider: MusicProvidable

    // MARK: Init
    init() {
        self.persistenceProvider = PersistenceProvider()
        self.musicProvider = MusicProvider()
    }
}


// MARK: - PersistenceDependency
protocol PersistenceDependency {
    var persistenceProvider: PersistenceProvidable { get }
}

// MARK: - MusicDependency
protocol MusicDependency {
    var musicProvider: MusicProvidable { get }
}
