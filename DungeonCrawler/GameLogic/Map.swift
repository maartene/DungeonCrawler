//
//  Map.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 29/03/2025.
//

struct Map {
    private var walls = Set<Coordinate>()
    
    init(_ mapArray: [[Character]] = [[]]) {
        for row in 0 ..< mapArray.count {
            for column in 0 ..< mapArray[0].count {
                if mapArray[row][column] == "#" {
                    walls.insert(Coordinate(x: column, y: row))
                }
            }
        }
    }
    
    func hasWall(at coordinate: Coordinate) -> Bool {
        return walls.contains(coordinate)
    }
}
