//
//  CreateWorldTests.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 21/08/2025.
//

import Testing
@testable import DungeonCrawler

@Suite("makeWorld should") struct MakeWorldTests {
    @Test("create a world with a single floor based on a multiline string") func singleFloorTest() throws {
        let world = makeWorld([
            """
            ######
            #S.#.#
            #....#
            #..e.#
            #<#..#
            ######
            """
        ])
        
        #expect(world.partyPosition == Coordinate(x: 1, y: 1))
        #expect(world.currentFloor.tileAt(Coordinate(x: 2, y: 2)) == .floor)
        #expect(world.currentFloor.tileAt(Coordinate(x: 3, y: 3)) == .floor)
        #expect(world.currentFloor.tileAt(Coordinate(x: 1, y: 4)) == .stairsUp)
        #expect(world.currentFloor.tileAt(Coordinate(x: 3, y: 1)) == .wall)
        #expect(world.currentFloor.minX == 0)
        #expect(world.currentFloor.minY == 0)
        #expect(world.currentFloor.maxX == 5)
        #expect(world.currentFloor.maxY == 5)
        #expect(world.enemiesOnCurrentFloor.count == 1)
        
        let enemy = try #require(world.enemiesOnCurrentFloor.first)
        #expect(enemy.position == Coordinate(x: 3, y: 3))
        
    }
    
    @Test("create a world with two floors based on a multiline strings") func multipleFloorTest() {
        let world = makeWorld([
            """
            .<
            """,
            """
            ..#
            ###
            """
        ])
        
        world.perform(.move(direction: .right))
        
        #expect(world.currentFloor.maxX == 2)
        #expect(world.currentFloor.maxY == 1)
    }
}
