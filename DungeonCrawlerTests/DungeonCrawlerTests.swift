//
//  DungeonCrawlerTests.swift
//  DungeonCrawlerTests
//
//  Created by Maarten Engels on 22/02/2025.
//

import Testing
@testable import DungeonCrawler

@Suite("Player movement should") struct PlayerMovementTests {
    @Test("get to the expected coordinate, when it moves in a specified direction", arguments: [
        (Direction.forward, Coordinate(x: 0, y: 1)),
        (Direction.backwards, Coordinate(x: 0, y: -1)),
        (Direction.left, Coordinate(x: -1, y: 0)),
        (Direction.right, Coordinate(x: 1, y: 0)),
    ]) func movePlayerForward(testcase: (direction: Direction, expectedPosition: Coordinate)) {
        let player = Player()
        
        player.move(testcase.direction)
        
        #expect(player.position == testcase.expectedPosition)
    }
    
    @Test("get to coordinate (0,2) when it moves forward twice") func movePlayerForwardTwice() {
        let player = Player()
        
        player.move(.forward)
        player.move(.forward)
        
        #expect(player.position == Coordinate(x: 0, y: 2))
    }
    
    @Test("stays in the same position, when you move forward first, then right, then back and finally left") func moveInACircle() {
        let player = Player()
        
        player.move(.forward)
        player.move(.right)
        player.move(.backwards)
        player.move(.left)
        
        #expect(player.position == Coordinate(x: 0, y: 0))
    }
    
    
}
