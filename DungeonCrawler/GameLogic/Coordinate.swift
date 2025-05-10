//
//  Coordinate.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 01/03/2025.
//

struct Coordinate {
    var x: Int
    var y: Int

    static func +(lhs: Coordinate, rhs: Coordinate) -> Coordinate {
        Coordinate(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    static func +=(lhs: inout Coordinate, rhs: Coordinate) {
        lhs = lhs + rhs
    }
}

extension Coordinate: Equatable { }
extension Coordinate: Hashable { }
