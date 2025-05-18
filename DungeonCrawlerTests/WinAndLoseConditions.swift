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
    
    @Test("When the party reaches the target, the world should be in the 'win' state") func partyReachesTarget() {
        let world = World(map: Map([
            [".","T"]
        ]))
        
        world.perform(.move(direction: .right))
        
        #expect(world.state == .win)
    }
    
    @Test("When the party reaches the target, they should no longer be able to move") func dontMoveAfterWin() {
        let world = World(map: Map([
            [".","T"]
        ]))
        
        world.perform(.move(direction: .right))
        world.perform(.move(direction: .left))
        
        #expect(world.partyPosition == Coordinate(x: 1, y: 0))
    }
    
    @Test("When the party reaches the target, they should no longer be able to turn") func dontTurnAfterWin() {
        let world = World(map: Map([
            [".","T"]
        ]))
        
        world.perform(.move(direction: .right))
        world.perform(.turnClockwise)
        
        #expect(world.partyHeading == .north)
    }
}
