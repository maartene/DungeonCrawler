//
//  DungeonCrawlerTests.swift
//  DungeonCrawlerTests
//
//  Created by Maarten Engels on 22/02/2025.
//

import Testing
@testable import DungeonCrawler

@Suite("Party movement should") struct PartyMovementTests {    
    @Test("get to the expected coordinate, when it moves in a specified direction", arguments: [
        (MovementDirection.forward, Coordinate(x: 0, y: 1)),
        (MovementDirection.backwards, Coordinate(x: 0, y: -1)),
        (MovementDirection.left, Coordinate(x: -1, y: 0)),
        (MovementDirection.right, Coordinate(x: 1, y: 0)),
    ]) func movePartyForward(testcase: (direction: MovementDirection, expectedPosition: Coordinate)) {
        let world = World(map: Map())
        
        world.move(testcase.direction)
        
        #expect(world.position == testcase.expectedPosition)
    }
    
    @Test("get to coordinate (0,2) when it moves forward twice") func movePlayerForwardTwice() {
        let world = World(map: Map())
        
        world.move(.forward)
        world.move(.forward)
        
        #expect(world.position == Coordinate(x: 0, y: 2))
    }
    
    @Test("stays in the same position, when you move forward first, then right, then back and finally left") func moveInACircle() {
        let world = World(map: Map())
        
        world.move(.forward)
        world.move(.right)
        world.move(.backwards)
        world.move(.left)
        
        #expect(world.position == Coordinate(x: 0, y: 0))
    }
    
    @Test("get to the expected coordinate when it moves in the designated direction while heading a certain way", arguments: [
        (Coordinate(x: 0, y: 0), CompassDirection.west, MovementDirection.forward, Coordinate(x: -1, y: 0)),
        (Coordinate(x: -4, y: 5), CompassDirection.south, MovementDirection.backwards, Coordinate(x: -4, y: 6)),
        (Coordinate(x: 11, y: -4), CompassDirection.east, MovementDirection.right, Coordinate(x: 11, y: -5)),
        (Coordinate(x: 24, y: 72), CompassDirection.north, MovementDirection.left, Coordinate(x: 23, y: 72)),
        (Coordinate(x: 24, y: 72), CompassDirection.south, MovementDirection.left, Coordinate(x: 25, y: 72)),
    ]) func movementTakesHeadingIntoAccount(testcase: (startPosition: Coordinate, heading: CompassDirection, movementDirection: MovementDirection, expectedPosition: Coordinate)) {
        let world = World(map: Map(), position: testcase.startPosition, heading: testcase.heading)
        
        world.move(testcase.movementDirection)
        
        #expect(world.position == testcase.expectedPosition)
    }
    
    @Test("not move through walls") func cannotMoveThroughWalls() {
        let map = Map([
            ["#","#","#","#"],
            ["#",".",".","#"],
            ["#","#","#","#"],
        ])
        let world = World(map: map, position: Coordinate(x: 0, y: 1))
        
        world.move(.forward)
        
        #expect(world.position == Coordinate(x: 0, y: 1))
    }
}

@Suite("Player rotation should") struct PlayerRotationTests {
    @Test("face north when the new player is created") func newPlayerFacesNorth() {
        let world = World(map: Map())
        
        #expect(world.heading == .north)
    }
    
    @Test("face east when it turns clockwise") func turnClockwiseOnce() {
        let world = World(map: Map())
        
        world.turnClockwise()
        
        #expect(world.heading == .east)
    }
    
    @Test("face west when it turns clockwise three times") func turnClockwiseThreeTimes() {
        let world = World(map: Map())
        
        world.turnClockwise()
        world.turnClockwise()
        world.turnClockwise()
        
        #expect(world.heading == .west)
    }
    
    @Test("face west when it turns counter clockwise once") func turnCounterClockwise() {
        let world = World(map: Map())
        
        world.turnCounterClockwise()
        
        #expect(world.heading == .west)
    }
}

@Suite("When moving from one floor to another") struct MultipleLevelTests {
    @Test("a new player starts at floornumber 0") func newPlayerStartsAtFloor0() {
        let world = World(map: Map())
        
        #expect(world.currentFloor == 0)
    }
    
    @Test("when a player moves up a staircase, the floornumber should increase by 1") func playerMovesUpStairs() {
        let map = Map([
            ["<"]
        ])
        let player = World(map: map)
        
        player.ascendStairs(in: map)
        
        #expect(player.currentFloor == 1)
    }
    
    @Test("when a player is not on a staircase leading up, and the player tries to ascend, the floornumber does not change") func playerCannotMoveUpStairsIfNotOnStairs() {
        let map = Map([
            ["."]
        ])
        let world = World(map: map)        
        
        world.ascendStairs(in: map)
        
        #expect(world.currentFloor == 0)
    }
}
