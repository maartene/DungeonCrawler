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
                HStack {
                    Spacer()
                    PartyMembersView(partyStats: viewModel.partyStats)
                }
                Button("DAMAGE") {
                    world.partyMembers[.frontLeft].takeDamage(1)
                }
                .foregroundStyle(.white)
                Spacer()
            }
            VStack {
                VStack {
                    Text("State: \(viewModel.worldState)")
                }
                .background(Color.gray.opacity(0.2))
                    .foregroundStyle(.white)
                
                HStack {
                    Button("Turn CCW") {
                        world.perform(.turnCounterClockwise)
                    }.keyboardShortcut("q", modifiers: [])
                    Button("Forward") {
                        world.perform(.move(direction: .forward))
                    }.keyboardShortcut("w", modifiers: [])
                    Button("Turn CW") {
                        world.perform(.turnClockwise)
                    }.keyboardShortcut("e", modifiers: [])
                }

                HStack {
                    Button("Left") {
                        world.perform(.move(direction: .left))
                    }.keyboardShortcut("a", modifiers: [])
                    Button("Back") {
                        world.perform(.move(direction: .backwards))
                    }.keyboardShortcut("s", modifiers: [])
                    Button("Right") {
                        world.perform(.move(direction: .right))
                    }.keyboardShortcut("d", modifiers: [])

                }
            }
        }
    }
}

#Preview {
    ContentView()
}
