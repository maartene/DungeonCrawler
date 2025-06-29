//
//  PartyMember.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 28/06/2025.
//

final class PartyMember {
    private(set) var currentHP = 10
    
    func takeDamage(_ amount: Int) {
        currentHP -= amount
    }
    
    var isAlive: Bool {
        currentHP > 0
    }
}
