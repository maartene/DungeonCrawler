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
        ["#",".",".","#",">","#"],
        ["#",".",".",".",".","#"],
        ["#",".",".",".",".","#"],
        ["#","<","#",".",".","#"],
        ["#","#","#","#","#","#"],
    ]), partyStartPosition: Coordinate(x: 1, y: 1))
    
    var body: some View {
        ZStack {
            GameView(world: world)
            VStack {
                HStack {
                    Button("Turn CCW") {
                        world.turnPartyCounterClockwise()
                    }.keyboardShortcut("q", modifiers: [])
                    Button("Forward") {
                        world.moveParty(.forward)
                    }.keyboardShortcut("w", modifiers: [])
                    Button("Turn CW") {
                        world.turnPartyClockwise()
                    }.keyboardShortcut("e", modifiers: [])
                }
                
                HStack {
                    Button("Left") {
                        world.moveParty(.left)
                    }.keyboardShortcut("a", modifiers: [])
                    Button("Back") {
                        world.moveParty(.backwards)
                    }.keyboardShortcut("s", modifiers: [])
                    Button("Right") {
                        world.moveParty(.right)
                    }.keyboardShortcut("d", modifiers: [])
                    
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
