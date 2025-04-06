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
    private var tiles = [Coordinate: Tile]()
    
    var minX: Int {
        tiles.keys.map { $0.x }.min() ?? 0
    }
    
    var minY: Int {
        tiles.keys.map { $0.y }.min() ?? 0
    }
    
    var maxX: Int {
        tiles.keys.map { $0.x }.max() ?? 0
    }
    
    var maxY: Int {
        tiles.keys.map { $0.y }.max() ?? 0
    }
    
    init(_ mapArray: [[Character]] = [[]]) {
        var readTiles = [Coordinate: Tile]()
        for row in 0 ..< mapArray.count {
            for column in 0 ..< mapArray[0].count {
                readTiles[Coordinate(x: column, y: row)] = Tile.characterToTile(mapArray[row][column])
            }
        }
        
        self.tiles = readTiles.filter { $0.value != .floor }
    }
    
    func tileAt(_ coordinate: Coordinate) -> Tile {
        tiles[coordinate, default: .floor]
    }
}
