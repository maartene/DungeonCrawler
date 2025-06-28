//
//  PartyMember.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 28/06/2025.
//

final class PartyMember {
    private(set) var health = 10
    
    func takeDamage(_ amount: Int) {
        health -= amount
    }
    
    var isAlive: Bool {
        health > 0
    }
}
