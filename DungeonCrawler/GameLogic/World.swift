//
//  World.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 01/03/2025.
//

final class World {
    private(set) var partyPosition: Coordinate
    private(set) var partyHeading: CompassDirection
    private var currentFloorIndex = 0

    private let floors: [Map]
    
    
    var currentFloor: Map {
        floors[currentFloorIndex]
    }
    
    var state: WorldState {
        if currentFloor.tileAt(partyPosition) == .winTarget {
            return .win
        }
        
        return .undetermined
    }

    init(map: Map, partyStartPosition: Coordinate = Coordinate(x: 0, y: 0), partyStartHeading: CompassDirection = CompassDirection.north) {
        self.floors = [map]
        self.partyPosition = partyStartPosition
        self.partyHeading = partyStartHeading
    }

    init(floors: [Map], partyStartPosition: Coordinate = Coordinate(x: 0, y: 0), partyStartHeading: CompassDirection = CompassDirection.north) {
        self.floors = floors
        self.partyPosition = partyStartPosition
        self.partyHeading = partyStartHeading
    }

    func moveParty(_ direction: MovementDirection) {
        guard state != .win else {
            return
        }
        
        let newPosition = partyPosition + direction.toCompassDirection(facing: partyHeading).toCoordinate

        switch currentFloor.tileAt(newPosition) {
        
        case .wall:
            break
        case .stairsUp:
            currentFloorIndex += 1
            partyPosition = newPosition
        case .stairsDown:
            currentFloorIndex -= 1
            partyPosition = newPosition
        default:
            partyPosition = newPosition
        }
    }

    func turnPartyClockwise() {
        guard state != .win else {
            return
        }
        
        partyHeading = partyHeading.rotatedClockwise()
    }

    func turnPartyCounterClockwise() {
        guard state != .win else {
            return
        }
        
        partyHeading = partyHeading.rotatedCounterClockwise()
    }
}

enum WorldState {
    case undetermined
    case win
    case lose
}
