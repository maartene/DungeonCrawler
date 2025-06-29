//
//  ViewModel.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 29/03/2025.
//

import simd
import Combine
import QuartzCore
import Foundation
import AppKit

final class ViewModel: ObservableObject {
    let world: World
    @Published var worldState: WorldState
    @Published var partyStats: PartyStats
    
    init(world: World) {
        self.world = world
        worldState = world.state
        self.partyStats = PartyStats(partyMembers: world.partyMembers)
        
        let displayLink = NSScreen.main?.displayLink(target: self, selector: #selector(update))
        displayLink?.add(to: .current, forMode: .common)
    }
    
    @objc func update() {
        worldState = world.state
        partyStats = PartyStats(partyMembers: world.partyMembers)
        self.objectWillChange.send()
    }
}

extension Coordinate {
    var toSIMD3: SIMD3<Float> {
        .init(Float(x), 0, -Float(y))
    }
}

extension CompassDirection {
    var toFloatQuaternion: simd_quatf {
        let angleAroundYAxis: Float = switch self {
        case .north:
            0
        case .east:
            .pi * 1.5
        case .south:
            .pi
        case .west:
            .pi * 0.5
        }

        return simd_quatf(angle: angleAroundYAxis, axis: [0, 1, 0])
    }
}

struct PartyStats {
    let members: [PartyMemberStats]
    
    init(partyMembers: PartyMembers) {
        members = partyMembers.allPartyMembers.map { PartyMemberStats(partyMember: $0) }
    }
    
    subscript(partyPosition: PartyPosition) -> PartyMemberStats {
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
}

struct PartyMemberStats {
    let currentHP: Int
    
    init(partyMember: PartyMember) {
        self.currentHP = partyMember.currentHP
    }
}
