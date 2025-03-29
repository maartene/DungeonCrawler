//
//  World.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 22/02/2025.
//

class World {
    let player = Player(position: Coordinate(x: 1, y: 1))
    let map = Map([
        ["#","#","#","#","#","#"],
        ["#",".",".",".",".","#"],
        ["#",".","#",".",".","#"],
        ["#",".",".","#",".","#"],
        ["#",".",".",".",".","#"],
        ["#","#","#","#","#","#"],
    ])
}
