//
//  Player.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 01/03/2025.
//

final class Player {
    private(set) var position: Coordinate
    private(set) var heading: CompassDirection
    
    init(position: Coordinate = Coordinate(x: 0, y: 0), heading: CompassDirection = CompassDirection.north) {
        self.position = position
        self.heading = heading
    }
    
    func move(_ direction: MovementDirection, in map: Map) {
        let newPosition = position + direction.toCompassDirection(facing: heading).toCoordinate
        
        guard map.hasWall(at: newPosition) == false else {
            return
        }
        
        position = newPosition
    }
    
    func turnClockwise() {
        heading = heading.rotatedClockwise
    }
    
    func turnCounterClockwise() {
        heading = heading.rotatedCounterClockwise
    }
}
