//
//  Direction.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 01/03/2025.
//

enum Direction {
    case forward
    case backwards
    
    var toCoordinate: Coordinate {
        switch self {
        case .forward: return Coordinate(x: 0, y: 1)
        case .backwards:  return Coordinate(x: 0, y: -1)
        }
    }
}
