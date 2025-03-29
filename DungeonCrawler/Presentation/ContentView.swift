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
                HStack {
                    Button("Turn CCW") {
                        world.player.turnCounterClockwise()
                    }.keyboardShortcut("q", modifiers: [])
                    Button("Forward") {
                        world.player.move(.forward, in: world.map)
                    }.keyboardShortcut("w", modifiers: [])
                    Button("Turn CW") {
                        world.player.turnClockwise()
                    }.keyboardShortcut("e", modifiers: [])
                }
                
                HStack {
                    Button("Left") {
                        world.player.move(.left, in: world.map)
                    }.keyboardShortcut("a", modifiers: [])
                    Button("Back") {
                        world.player.move(.backwards, in: world.map)
                    }.keyboardShortcut("s", modifiers: [])
                    Button("Right") {
                        world.player.move(.right, in: world.map)
                    }.keyboardShortcut("d", modifiers: [])
                    
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
