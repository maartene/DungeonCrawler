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
    
    init(world: World) {
        self.world = world
        worldState = world.state
        
        let displayLink = NSScreen.main?.displayLink(target: self, selector: #selector(update))
        displayLink?.add(to: .current, forMode: .common)
    }
    
    @objc func update() {
        worldState = world.state
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
