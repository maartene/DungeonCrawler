//
//  Player.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 01/03/2025.
//

final class Player {
    var position = Coordinate(x: 0, y: 0)
    
    func move(_ direction: Direction) {
        position = Coordinate(x: 0, y: position.y + 1)
    }
}
