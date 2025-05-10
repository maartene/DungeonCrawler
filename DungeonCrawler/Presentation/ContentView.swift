//
//  ContentView.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 22/02/2025.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    let world: World
    @ObservedObject var viewModel: ViewModel
    
    init() {
        world = World(floors: [
                Map([
                ["#", "#", "#", "#", "#", "#"],
                ["#", ".", ".", "#", ".", "#"],
                ["#", ".", ".", ".", ".", "#"],
                ["#", ".", ".", ".", ".", "#"],
                ["#", "<", "#", ".", ".", "#"],
                ["#", "#", "#", "#", "#", "#"]
                ]),
                Map([
                ["#", "#", "#", "#", "#", "#"],
                ["#", ".", ".", ".", ".", "#"],
                ["#", ".", ".", ".", ".", "#"],
                ["#", "#", "#", ".", ".", "#"],
                ["#", ">", "#", ".", ".", "#"],
                ["#", "T", ".", ".", ".", "#"],
                ["#", "#", "#", "#", "#", "#"]
            ])
        ], partyStartPosition: Coordinate(x: 1, y: 1))

        viewModel = ViewModel(world: world)
    }
    
    var body: some View {
        ZStack {
            GameView(world: world)
            VStack {
                VStack {
                    Text("State: \(viewModel.worldState)")
                }
                .background(Color.gray.opacity(0.2))
                    .foregroundStyle(.white)
                
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
