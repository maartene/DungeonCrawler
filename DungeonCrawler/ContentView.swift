//
//  ContentView.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 22/02/2025.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    let world = World()
    
    var body: some View {
        ZStack {
            GameView(world: world)
            VStack {
                Button("Move forward") {
                    world.moveForward()
                }
                
                Button("Move back") {
                    world.moveBack()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
