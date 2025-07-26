//
//  EnemyTests.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 26/07/2025.
//

import Foundation
import Testing
@testable import DungeonCrawler

@Suite("Enemies should") struct EnemyTests {
    @Suite("when update is called") struct UpdateCalled {
        @Test("given the party is next to the enemy, the party takes damage") func shouldTakeDamage() {
            let world = World(floors: [Map()])
            world.addEnemy(Coordinate(x: 1, y: 0))
            let originalHP = world.partyMembers[.frontLeft].currentHP
            
            world.update(at: Date())
            
            #expect(world.partyMembers[.frontLeft].currentHP < originalHP)
        }
        
        
    }
}
