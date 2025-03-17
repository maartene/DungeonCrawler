//
//  Coordinate.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 01/03/2025.
//

struct Coordinate {
    var x: Int
    var y: Int
        
    static func +=(lhs: inout Coordinate, rhs: Coordinate) {
        lhs.y += rhs.y
        lhs.x += rhs.x
    }
}

extension Coordinate: Equatable { }
