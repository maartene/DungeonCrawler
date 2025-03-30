//
//  Player.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 01/03/2025.
//

final class World {
    private(set) var position: Coordinate
    private(set) var heading: CompassDirection
    
    private(set) var currentFloor = 0
    
    let map: Map
    
    init(map: Map, position: Coordinate = Coordinate(x: 0, y: 0), heading: CompassDirection = CompassDirection.north) {
        self.map = map
        self.position = position
        self.heading = heading
    }
    
    func move(_ direction: MovementDirection) {
        let newPosition = position + direction.toCompassDirection(facing: heading).toCoordinate
        
        guard map.hasWall(at: newPosition) == false else {
            return
        }
        
        position = newPosition
    }
    
    func turnClockwise() {
        heading = heading.rotatedClockwise()
    }
    
    func turnCounterClockwise() {
        heading = heading.rotatedCounterClockwise()
    }
    
    func ascendStairs(in map: Map) {
        guard map.hasStairsUp(at: position) else {
            return
        }
        
        currentFloor += 1
    }
}
