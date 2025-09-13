//
//  Enemy.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 26/07/2025.
//

import Foundation

final class Enemy {
    let position: Coordinate
    let heading: CompassDirection = .east
    private var cooldownExpires = Date()
    static let cooldown: TimeInterval = 1
    
    init(position: Coordinate) {
        self.position = position
    }
    
    func attack(_ partyMember: PartyMember, at time: Date) {
        if time >= cooldownExpires {
            partyMember.takeDamage(1)
            cooldownExpires = time.addingTimeInterval(Enemy.cooldown)
        }
    }
}
