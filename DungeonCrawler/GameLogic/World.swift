//
//  World.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 01/03/2025.
//

import Foundation

final class World {
    private(set) var partyPosition: Coordinate
    private(set) var partyHeading: CompassDirection
    private var currentFloorIndex = 0
    private var enemies: [Enemy] = []
    
    private let floors: [Map]
    let partyMembers = PartyMembers()
    
    var currentFloor: Map {
        floors[currentFloorIndex]
    }
    
    var enemiesOnCurrentFloor: [Enemy] {
        enemies
    }
    
    var state: WorldState {
        if currentFloor.tileAt(partyPosition) == .winTarget {
            return .win
        }
        
        if partyMembers.alivePartyMembers.isEmpty {
            return .lose
        }
        
        return .undetermined
    }

    init(map: Map, partyStartPosition: Coordinate = Coordinate(x: 0, y: 0), partyStartHeading: CompassDirection = CompassDirection.north) {
        self.floors = [map]
        self.partyPosition = partyStartPosition
        self.partyHeading = partyStartHeading
    }

    init(floors: [Map], partyStartPosition: Coordinate = Coordinate(x: 0, y: 0), partyStartHeading: CompassDirection = CompassDirection.north) {
        self.floors = floors
        self.partyPosition = partyStartPosition
        self.partyHeading = partyStartHeading
    }
    
    func addEnemy(_ position: Coordinate) {
        enemies.append(Enemy(position: position))
    }
    
    func update(at time: Date) {
        for enemy in enemies {
            if enemy.position.manhattanDistanceTo(partyPosition) <= 1 {
                enemy.attack(partyMembers[.frontLeft], at: time)
            }
        }
    }
    
    func perform(_ command: PartyCommand) {
        guard canPerformAction else {
            return
        }
        
        switch command {
        case .move(direction: let direction):
            performMovement(direction)
        case .turnCounterClockwise:
            turnPartyCounterClockwise()
        case .turnClockwise:
            turnPartyClockwise()
        }
    }
    
    private var canPerformAction: Bool {
        state != .win && state != .lose
    }
    
    private func performMovement(_ direction: MovementDirection) {
        let newPosition = partyPosition + direction.toCompassDirection(facing: partyHeading).toCoordinate
        
        switch currentFloor.tileAt(newPosition) {
            
        case .wall:
            break
        case .stairsUp:
            currentFloorIndex += 1
            partyPosition = newPosition
        case .stairsDown:
            currentFloorIndex -= 1
            partyPosition = newPosition
        default:
            partyPosition = newPosition
        }
    }
    
    private func turnPartyClockwise() {
        partyHeading = partyHeading.rotatedClockwise()
    }

    private func turnPartyCounterClockwise() {
        partyHeading = partyHeading.rotatedCounterClockwise()
    }
}

enum WorldState {
    case undetermined
    case win
    case lose
}

enum PartyCommand {
    case move(direction: MovementDirection)
    case turnCounterClockwise
    case turnClockwise
}

func makeWorld(_ floorStrings: [String]) -> World {
    var enemies = [Coordinate]()
    var startingPosition = Coordinate(x: 0, y: 0)
    var floors = [Map]()
    
    for floorString in floorStrings {
        let lines = floorString.split(separator: "\n")
            .map { String($0) }
        
        let characters: [[Character]] = lines.map { line in
            line.map { stringElement in
                stringElement
            }
        }
        
        // lets try and find a starting position
        for y in 0 ..< characters.count {
            for x in 0 ..< characters[y].count {
                if characters[y][x] == "S"
                {
                    startingPosition = Coordinate(x: x, y: y)
                }
             }
        }
        
        for y in 0 ..< characters.count {
            for x in 0 ..< characters[y].count {
                if characters[y][x] == "e"
                {
                    enemies.append(Coordinate(x: x, y: y))
                }
             }
        }
        
        floors.append(Map(characters))
    }
    
    let world = World(floors: floors, partyStartPosition: startingPosition)
    
    for enemy in enemies {
        world.addEnemy(enemy)
    }
    
    return world
}
