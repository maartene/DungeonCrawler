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
        let characters = toCharacterMatrix(floorString)
        let startingAndEnemyPositions = findStartingAndEnemyPositions(characters)
        
        startingPosition = startingAndEnemyPositions.startingPosition ?? startingPosition
        enemies.append(contentsOf: startingAndEnemyPositions.enemies)
        
        floors.append(Map(characters))
    }
    
    let world = World(floors: floors, partyStartPosition: startingPosition)
    
    for enemy in enemies {
        world.addEnemy(enemy)
    }
    
    return world
    
    func toCharacterMatrix(_ string: String) -> [[Character]] {
        let lines = string.split(separator: "\n")
            .map { String($0) }
        
        let characters: [[Character]] = lines.map { line in
            line.map { stringElement in
                stringElement
            }
        }
        
        return characters
    }
    
    func findStartingAndEnemyPositions(_ characterMatrix: [[Character]]) -> (startingPosition: Coordinate?, enemies: [Coordinate]) {
        // lets try and find a starting position
        var enemies = [Coordinate]()
        var startingPosition: Coordinate?
        
        for y in 0 ..< characterMatrix.count {
            for x in 0 ..< characterMatrix[y].count {
                switch characterMatrix[y][x] {
                case "e": enemies.append(Coordinate(x: x, y: y))
                case "S": startingPosition = Coordinate(x: x, y: y)
                default:
                    break
                }
             }
        }
                
        return (startingPosition, enemies)
    }
}
