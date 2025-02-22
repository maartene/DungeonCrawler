//
//  World.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 22/02/2025.
//

import simd

class World {
    var playerPosition: SIMD3<Float> = .zero
    
    func moveForward() {
        playerPosition = [playerPosition.x, playerPosition.y, playerPosition.z - 1]
        print("New player position: \(playerPosition)")
    }
    
    func moveBack() {
        playerPosition = [playerPosition.x, playerPosition.y, playerPosition.z + 1]
        print("New player position: \(playerPosition)")
    }
}
