//
//  Player.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 01/03/2025.
//

final class World {
    private(set) var partyPosition: Coordinate
    private(set) var partyHeading: CompassDirection
    private(set) var currentFloor = 0
    
    let map: Map
    
    init(map: Map, partyStartPosition: Coordinate = Coordinate(x: 0, y: 0), partyStartHeading: CompassDirection = CompassDirection.north) {
        self.map = map
        self.partyPosition = partyStartPosition
        self.partyHeading = partyStartHeading
    }
    
    func moveParty(_ direction: MovementDirection) {
        let newPosition = partyPosition + direction.toCompassDirection(facing: partyHeading).toCoordinate
        
        guard map.hasWall(at: newPosition) == false else {
            return
        }
        
        partyPosition = newPosition
    }
    
    func turnPartyClockwise() {
        partyHeading = partyHeading.rotatedClockwise()
    }
    
    func turnPartyCounterClockwise() {
        partyHeading = partyHeading.rotatedCounterClockwise()
    }
    
    func partyAscendStairs(in map: Map) {
        guard map.hasStairsUp(at: partyPosition) else {
            return
        }
        
        currentFloor += 1
    }
}
