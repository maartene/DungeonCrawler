//
//  Player.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 01/03/2025.
//

final class Player {
    private(set) var position = Coordinate(x: 0, y: 0)
    private(set) var heading = CompassDirection.north
    
    func move(_ direction: Direction) {
        position += direction.toCompassDirection(facing: heading).toCoordinate
    }
    
    func turnClockwise() {
        heading = heading.rotatedClockwise
    }
    
    func turnCounterClockwise() {
        heading = heading.rotatedCounterClockwise
    }
}
