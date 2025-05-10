//
//  WinAndLoseConditions.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 10/05/2025.
//

import Testing
@testable import DungeonCrawler

@Suite("Win and Lose conditions") struct WinAndLoseConditionsTests {
    @Test("When a new world is created, it should have an 'undetermined' win or lose state") func newWorldState() {
        let world = World(map: Map())
        
        #expect(world.state == .undetermined)
    }
}
