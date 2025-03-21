//
//  Direction.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 01/03/2025.
//

enum MovementDirection {
    case forward
    case backwards
    case left
    case right
    
    private var toCompassDirectionWhenFacingNorth: CompassDirection {
        switch self {
        case .forward: .north
        case .right: .east
        case .backwards: .south
        case .left: .west
        }
    }
    
    func toCompassDirection(facing: CompassDirection = .north) -> CompassDirection {
        let numberOfQuarterTurns = facing.numberOfQuarterTurnsToNorth
        return toCompassDirectionWhenFacingNorth.rotatedClockwise(numberOfQuarterTurns)
    }
}

enum CompassDirection {
    case north
    case east
    case south
    case west
    
    var numberOfQuarterTurnsToNorth: Int {
        switch self {
        case .north: 0
        case .east:  1
        case .south: 2
        case .west:  3
        }
    }
    
    func rotatedClockwise(_ times: Int = 0) -> CompassDirection {
        var rotatedDirection = self
        
        for _ in 0 ..< times {
            rotatedDirection = rotatedDirection.rotatedClockwise
        }
        
        return rotatedDirection
    }
    
    var rotatedClockwise: CompassDirection {
        switch self {
        case .north: return .east
        case .east: return .south
        case .south: return .west
        case .west: return .north
        }
    }
    
    var rotatedCounterClockwise: CompassDirection {
        switch self {
        case .north: return .west
        case .east: return .north
        case .south: return .east
        case .west: return .south
        }
    }
    
    var toCoordinate: Coordinate {
        switch self {
        case .north: return Coordinate(x: 0, y: 1)
        case .south:  return Coordinate(x: 0, y: -1)
        case .west:  return Coordinate(x: -1, y: 0)
        case .east:  return Coordinate(x: 1, y: 0)
        }
    }
}
