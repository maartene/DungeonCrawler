//
//  PartyMembersView.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 28/06/2025.
//

import SwiftUI

struct PartyMembersView: View {
    let partyStats: PartyStats
    
    var body: some View {
        VStack {
            HStack {
                Text("HP: \(partyStats[.frontLeft].currentHP)")
                    .padding()
                Text("HP: \(partyStats[.frontRight].currentHP)")
                    .padding()
            }
            HStack {
                Text("HP: \(partyStats[.backLeft].currentHP)")
                    .padding()
                Text("HP: \(partyStats[.backRight].currentHP)")
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
    PartyMembersView(partyStats: PartyStats(partyMembers: PartyMembers()))
}
