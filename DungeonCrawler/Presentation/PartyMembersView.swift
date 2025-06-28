//
//  PartyMembersView.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 28/06/2025.
//

import SwiftUI

struct PartyMembersView: View {
    let partyMembers: PartyMembers
    
    var body: some View {
        VStack {
            HStack {
                Text("HP: \(partyMembers[.frontLeft].health)")
                    .padding()
                Text("HP: \(partyMembers[.frontRight].health)")
                    .padding()
            }
            HStack {
                Text("HP: \(partyMembers[.backLeft].health)")
                    .padding()
                Text("HP: \(partyMembers[.backRight].health)")
                    .padding()
            }
        }
        .font(.headline)
        .foregroundStyle(.white)
        .background(Color.gray)
        .padding()
    }
}

#Preview {
    PartyMembersView(partyMembers: PartyMembers())
}
