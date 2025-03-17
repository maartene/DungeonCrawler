//
//  Direction.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 01/03/2025.
//

enum Direction {
    case forward
    case backwards
    case left
    case right
    
    var toCoordinate: Coordinate {
        switch self {
        case .forward: return Coordinate(x: 0, y: 1)
        case .backwards:  return Coordinate(x: 0, y: -1)
        case .left:  return Coordinate(x: -1, y: 0)
        case .right:  return Coordinate(x: 1, y: 0)
        }
    }
}

enum CompassDirection {
    case north
    case east
    case south
    case west
    
    var rotatedClockwise: CompassDirection {
        switch self {
        case .north: return .east
        case .east: return .south
        case .south: return .west
        case .west: return .north
        }
    }
}
