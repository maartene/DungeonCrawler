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
        (MovementDirection.forward, Coordinate(x: 0, y: 1)),
        (MovementDirection.backwards, Coordinate(x: 0, y: -1)),
        (MovementDirection.left, Coordinate(x: -1, y: 0)),
        (MovementDirection.right, Coordinate(x: 1, y: 0)),
    ]) func movePlayerForward(testcase: (direction: MovementDirection, expectedPosition: Coordinate)) {
        let player = Player()
        
        player.move(testcase.direction, in: Map())
        
        #expect(player.position == testcase.expectedPosition)
    }
    
    @Test("get to coordinate (0,2) when it moves forward twice") func movePlayerForwardTwice() {
        let player = Player()
        
        player.move(.forward, in: Map())
        player.move(.forward, in: Map())
        
        #expect(player.position == Coordinate(x: 0, y: 2))
    }
    
    @Test("stays in the same position, when you move forward first, then right, then back and finally left") func moveInACircle() {
        let player = Player()
        
        player.move(.forward, in: Map())
        player.move(.right, in: Map())
        player.move(.backwards, in: Map())
        player.move(.left, in: Map())
        
        #expect(player.position == Coordinate(x: 0, y: 0))
    }
    
    @Test("get to the expected coordinate when it moves in the designated direction while heading a certain way", arguments: [
        (Coordinate(x: 0, y: 0), CompassDirection.west, MovementDirection.forward, Coordinate(x: -1, y: 0)),
        (Coordinate(x: -4, y: 5), CompassDirection.south, MovementDirection.backwards, Coordinate(x: -4, y: 6)),
        (Coordinate(x: 11, y: -4), CompassDirection.east, MovementDirection.right, Coordinate(x: 11, y: -5)),
        (Coordinate(x: 24, y: 72), CompassDirection.north, MovementDirection.left, Coordinate(x: 23, y: 72)),
        (Coordinate(x: 24, y: 72), CompassDirection.south, MovementDirection.left, Coordinate(x: 25, y: 72)),
    ]) func movementTakesHeadingIntoAccount(testcase: (startPosition: Coordinate, heading: CompassDirection, movementDirection: MovementDirection, expectedPosition: Coordinate)) {
        let player = Player(position: testcase.startPosition, heading: testcase.heading)
        
        player.move(testcase.movementDirection, in: Map())
        
        #expect(player.position == testcase.expectedPosition)
    }
    
    @Test("not move through walls") func cannotMoveThroughWalls() {
        let map = Map([
            ["#","#","#","#"],
            ["#",".",".","#"],
            ["#","#","#","#"],
        ])
        let player = Player(position: Coordinate(x: 0, y: 1))
        
        player.move(.forward, in: map)
        
        #expect(player.position == Coordinate(x: 0, y: 1))
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

@Suite("When moving from one floor to another") struct MultipleLevelTests {
    @Test("when a player moves up a staircase, the floornumber should increase by 1") func playerMovesUpStairs() {
        let player = Player()
        
        player.ascendStairs()
        
        #expect(player.currentFloor == 1)
    }
}
