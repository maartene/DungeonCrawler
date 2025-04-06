//
//  Map.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 29/03/2025.
//

enum Tile {
    case floor
    case wall
    case stairsUp
    case stairsDown
    
    static func characterToTile(_ character: Character) -> Tile {
        switch character {
        case "#": return .wall
        case "<": return .stairsUp
        case ">": return .stairsDown
        default: return .floor
        }
    }
}

struct Map {
    private var walls = Set<Coordinate>()
    private var stairsUp = Set<Coordinate>()
    private var stairsDown = Set<Coordinate>()
    private var tiles = [Coordinate: Tile]()
    
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
                
                tiles[Coordinate(x: column, y: row)] = Tile.characterToTile(mapArray[row][column])
            }
        }
    }
    
    func tileAt(_ coordinate: Coordinate) -> Tile? {
       tiles[coordinate]
    }
    
    func hasWall(at coordinate: Coordinate) -> Bool {
        tileAt(coordinate) == .wall
    }
    
    func hasStairsUp(at coordinate: Coordinate) -> Bool {
        tileAt(coordinate) == .stairsUp
    }
    
    func hasStairsDown(at coordinate: Coordinate) -> Bool {
        tileAt(coordinate) == .stairsDown
    }
}
