//
//  ContentView.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 22/02/2025.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    let world = World(map: Map([
        ["#","#","#","#","#","#"],
        ["#",".",".",".",".","#"],
        ["#",".","#",".",".","#"],
        ["#",".",".","#",".","#"],
        ["#",".",".",".",".","#"],
        ["#","#","#","#","#","#"],
    ]))
    
    var body: some View {
        ZStack {
            GameView(world: world)
            VStack {
                HStack {
                    Button("Turn CCW") {
                        world.turnCounterClockwise()
                    }.keyboardShortcut("q", modifiers: [])
                    Button("Forward") {
                        world.move(.forward)
                    }.keyboardShortcut("w", modifiers: [])
                    Button("Turn CW") {
                        world.turnClockwise()
                    }.keyboardShortcut("e", modifiers: [])
                }
                
                HStack {
                    Button("Left") {
                        world.move(.left)
                    }.keyboardShortcut("a", modifiers: [])
                    Button("Back") {
                        world.move(.backwards)
                    }.keyboardShortcut("s", modifiers: [])
                    Button("Right") {
                        world.move(.right)
                    }.keyboardShortcut("d", modifiers: [])
                    
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
