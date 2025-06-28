//
//  PartyMembers.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 28/06/2025.
//

final class PartyMembers {
    private let members = [
        PartyMember(),
        PartyMember(),
        PartyMember(),
        PartyMember()
    ]
    
    subscript(partyPosition: PartyPosition) -> PartyMember {
        switch partyPosition {
        case .frontLeft:
            members[0]
        case .frontRight:
            members[1]
        case .backLeft:
            members[2]
        case .backRight:
            members[3]
        }
    }
    
    var alivePartyMembers: [PartyMember] {
        members.filter { $0.isAlive }
    }
}

enum PartyPosition {
    case frontLeft
    case frontRight
    case backLeft
    case backRight
}

final class PartyMember {
    private var health = 10
    
    func takeDamage(_ amount: Int) {
        health -= amount
    }
    
    var isAlive: Bool {
        health > 0
    }
}
