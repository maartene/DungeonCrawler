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
        (MovementDirection.right, Coordinate(x: 1, y: 0))
    ]) func movePartyForward(testcase: (direction: MovementDirection, expectedPosition: Coordinate)) {
        let world = World(map: Map())

        world.perform(.move(direction: testcase.direction))

        #expect(world.partyPosition == testcase.expectedPosition)
    }

    @Test("get to coordinate (0,2) when it moves forward twice") func movePartyForwardTwice() {
        let world = World(map: Map())

        world.perform(.move(direction: .forward))
        world.perform(.move(direction: .forward))

        #expect(world.partyPosition == Coordinate(x: 0, y: 2))
    }

    @Test("stays in the same position, when you move forward first, then right, then back and finally left") func moveInACircle() {
        let world = World(map: Map())

        world.perform(.move(direction: .forward))
        world.perform(.move(direction: .right))
        world.perform(.move(direction: .backwards))
        world.perform(.move(direction: .left))

        #expect(world.partyPosition == Coordinate(x: 0, y: 0))
    }

    @Test("get to the expected coordinate when it moves in the designated direction while heading a certain way", arguments: [
        (Coordinate(x: 0, y: 0), CompassDirection.west, MovementDirection.forward, Coordinate(x: -1, y: 0)),
        (Coordinate(x: -4, y: 5), CompassDirection.south, MovementDirection.backwards, Coordinate(x: -4, y: 6)),
        (Coordinate(x: 11, y: -4), CompassDirection.east, MovementDirection.right, Coordinate(x: 11, y: -5)),
        (Coordinate(x: 24, y: 72), CompassDirection.north, MovementDirection.left, Coordinate(x: 23, y: 72)),
        (Coordinate(x: 24, y: 72), CompassDirection.south, MovementDirection.left, Coordinate(x: 25, y: 72))
    ]) func movementTakesHeadingIntoAccount(testcase: (startPosition: Coordinate, heading: CompassDirection, movementDirection: MovementDirection, expectedPosition: Coordinate)) {
        let world = World(map: Map(), partyStartPosition: testcase.startPosition, partyStartHeading: testcase.heading)

        world.perform(.move(direction: testcase.movementDirection))

        #expect(world.partyPosition == testcase.expectedPosition)
    }

    @Test("not move through walls") func cannotMoveThroughWalls() {
        let map = Map([
            ["#", "#", "#", "#"],
            ["#", ".", ".", "#"],
            ["#", "#", "#", "#"]
        ])
        let world = World(map: map, partyStartPosition: Coordinate(x: 0, y: 1))

        world.perform(.move(direction: .forward))

        #expect(world.partyPosition == Coordinate(x: 0, y: 1))
    }
}

@Suite("Party rotation should") struct PartyRotationTests {
    @Test("face north when the new world is created") func partyInNewWorldFacesNorth() {
        let world = World(map: Map())

        #expect(world.partyHeading == .north)
    }

    @Test("face east when it turns clockwise") func turnClockwiseOnce() {
        let world = World(map: Map())

        world.perform(.turnClockwise)

        #expect(world.partyHeading == .east)
    }

    @Test("face west when it turns clockwise three times") func turnClockwiseThreeTimes() {
        let world = World(map: Map())

        world.perform(.turnClockwise)
        world.perform(.turnClockwise)
        world.perform(.turnClockwise)

        #expect(world.partyHeading == .west)
    }

    @Test("face west when it turns counter clockwise once") func turnCounterClockwise() {
        let world = World(map: Map())

        world.perform(.turnCounterClockwise)

        #expect(world.partyHeading == .west)
    }
}

@Suite("When moving from one floor to another") struct MultipleLevelTests {
    let floor1 = Map([
        [".", "<"]
    ])

    let floor2 = Map([
        [".", ">"]
    ])

    @Test("a new party starts at the first floor") func newPartyStartsAtFirstFloor() {
        let world = World(floors: [floor1, floor2])

        #expect(world.currentFloor == floor1)
    }

    @Test("when a party moves into a staircase, they should end up on the second floor") func partyMovesUpStairs() {
        let world = World(floors: [floor1, floor2])

        world.perform(.move(direction: .right))

        #expect(world.currentFloor == floor2)
    }

    @Test("when a party moves into a staircase leading down when they are on the second floor, they should end up on the first floor") func partyMovesDownStairs() {
        let world = World(floors: [floor1, floor2])
        world.perform(.move(direction: .right)) // end up on floor 2

        world.perform(.move(direction: .left))
        world.perform(.move(direction: .right))

        #expect(world.currentFloor == floor1)
    }
}
