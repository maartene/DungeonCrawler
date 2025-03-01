//
//  DungeonCrawlerTests.swift
//  DungeonCrawlerTests
//
//  Created by Maarten Engels on 22/02/2025.
//

import Testing
@testable import DungeonCrawler

@Suite("Player movement should") struct PlayerMovementTests {
    @Test("move forward when we instruct the player to move forward") func movePlayerForward() {
        let player = Player()
        
        player.move(.forward)
        
        #expect(player.position == Coordinate(x: 0, y: 1))
    }
    
    @Test("get to coordinate (0,2) when it moves forward twice") func movePlayerForwardTwice() {
        let player = Player()
        
        player.move(.forward)
        player.move(.forward)
        
        #expect(player.position == Coordinate(x: 0, y: 2))
    }
}
