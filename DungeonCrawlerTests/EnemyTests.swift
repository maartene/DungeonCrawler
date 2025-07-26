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
        
        @Test("given the party is far away from the enemy, the party does not take damage") func shouldNotTakeDamage() {
            let world = World(floors: [Map()])
            world.addEnemy(Coordinate(x: 10, y: 5))
            let originalHP = world.partyMembers[.frontLeft].currentHP
            
            world.update(at: Date())
            
            #expect(world.partyMembers[.frontLeft].currentHP == originalHP)
        }
        
        @Test("given the party is next to the enemy and cooldown is still in effect, the party does not take damage") func shouldNotTakeDamage_duringCooldown() {
            let world = World(floors: [Map()])
            world.addEnemy(Coordinate(x: 0, y: 1))
            world.update(at: Date())
            
            let originalHP = world.partyMembers[.frontLeft].currentHP

            world.update(at: Date().addingTimeInterval(0.5))
            
            #expect(world.partyMembers[.frontLeft].currentHP == originalHP)
        }
    }
}
