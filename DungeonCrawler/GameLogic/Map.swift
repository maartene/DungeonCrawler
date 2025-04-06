//
//  Map.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 29/03/2025.
//

struct Map {
    private var walls = Set<Coordinate>()
    private var stairsUp = Set<Coordinate>()
    private var stairsDown = Set<Coordinate>()
    
    var minX: Int {
        walls.map { $0.x }.min() ?? 0
    }
    
    var minY: Int {
        walls.map { $0.y }.min() ?? 0
    }
    
    var maxX: Int {
        walls.map { $0.x }.max() ?? 0
    }
    
    var maxY: Int {
        walls.map { $0.y }.max() ?? 0
    }
    
    init(_ mapArray: [[Character]] = [[]]) {
        for row in 0 ..< mapArray.count {
            for column in 0 ..< mapArray[0].count {
                if mapArray[row][column] == "#" {
                    walls.insert(Coordinate(x: column, y: row))
                }
                
                if mapArray[row][column] == "<" {
                    stairsUp.insert(Coordinate(x: column, y: row))
                }
                
                if mapArray[row][column] == ">" {
                    stairsDown.insert(Coordinate(x: column, y: row))
                }
            }
        }
    }
    
    func hasWall(at coordinate: Coordinate) -> Bool {
        return walls.contains(coordinate)
    }
    
    func hasStairsUp(at coordinate: Coordinate) -> Bool {
        stairsUp.contains(coordinate)
    }
    
    func hasStairsDown(at coordinate: Coordinate) -> Bool {
        stairsDown.contains(coordinate)
    }
}
