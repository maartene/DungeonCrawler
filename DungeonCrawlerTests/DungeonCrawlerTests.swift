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
        (HeadingDirection.forward, Coordinate(x: 0, y: 1)),
        (HeadingDirection.backwards, Coordinate(x: 0, y: -1)),
        (HeadingDirection.left, Coordinate(x: -1, y: 0)),
        (HeadingDirection.right, Coordinate(x: 1, y: 0)),
    ]) func movePlayerForward(testcase: (direction: HeadingDirection, expectedPosition: Coordinate)) {
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
    
    @Test("get to the expected coordinate when it moves in the designated direction while heading a certain way", arguments: [
        (Coordinate(x: 0, y: 0), CompassDirection.west, HeadingDirection.forward, Coordinate(x: -1, y: 0)),
        (Coordinate(x: -4, y: 5), CompassDirection.south, HeadingDirection.backwards, Coordinate(x: -4, y: 6)),
        (Coordinate(x: 11, y: -4), CompassDirection.east, HeadingDirection.right, Coordinate(x: 11, y: -5)),
        (Coordinate(x: 24, y: 72), CompassDirection.north, HeadingDirection.left, Coordinate(x: 23, y: 72)),
        (Coordinate(x: 24, y: 72), CompassDirection.south, HeadingDirection.left, Coordinate(x: 25, y: 72)),
    ]) func movementTakesHeadingIntoAccount(testcase: (startPosition: Coordinate, heading: CompassDirection, movementDirection: HeadingDirection, expectedPosition: Coordinate)) {
        let player = Player(position: testcase.startPosition, heading: testcase.heading)
        
        player.move(testcase.movementDirection)
        
        #expect(player.position == testcase.expectedPosition)
    }
    
}

@Suite("Player rotation should") struct PlayerRotationTests {
    @Test("face north when the new player is created") func newPlayerFacesNorth() {
        let player = Player()
        
        #expect(player.heading == .north)
    }
    
    @Test("face east when it turns clockwise") func turnClockwiseOnce() {
        let player = Player()
        
        player.turnClockwise()
        
        #expect(player.heading == .east)
    }
    
    @Test("face west when it turns clockwise three times") func turnClockwiseThreeTimes() {
        let player = Player()
        
        player.turnClockwise()
        player.turnClockwise()
        player.turnClockwise()
        
        #expect(player.heading == .west)
    }
    
    @Test("face west when it turns counter clockwise once") func turnCounterClockwise() {
        let player = Player()
        
        player.turnCounterClockwise()
        
        #expect(player.heading == .west)
    }
}
