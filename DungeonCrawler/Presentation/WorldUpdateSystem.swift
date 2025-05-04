//
//  WorldUpdateSystem.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 22/02/2025.
//

import RealityKit
import SwiftUI

struct WorldComponent: Component {
    let world: World
}


class WorldUpdateSystem: System {
    var world: World!
    var cameraAnchor: AnchorEntity!
    private var currentRenderedFloor: Map?
    private var mapAnchor: AnchorEntity?
    private var modelCache = [String: Entity]()
    
    // Initializer is required. Use an empty implementation if there's no setup needed.
    required init(scene: RealityKit.Scene) {
        guard let worldEntity = scene.findEntity(named: "WorldEntity") else {
            fatalError("Can't find WorldEntity in scene.")
        }
        
        let worldComponents = worldEntity.components.compactMap { $0 as? WorldComponent }
        
        guard let worldComponent = worldComponents.first else {
            fatalError("No WorldComponent found on WorldEntity")
        }
        
        self.world = worldComponent.world
        
        guard let cameraAnchor = scene.findEntity(named: "CameraAnchor") as? AnchorEntity else {
            fatalError("Can't find CameraAnchor in scene.")
        }
        
        self.cameraAnchor = cameraAnchor
    }


    func update(context: SceneUpdateContext) {
        cameraAnchor.position = world.partyPosition.toSIMD3
        cameraAnchor.transform.rotation = world.partyHeading.toFloatQuaternion
        
        if currentRenderedFloor != world.currentFloor {
            renderMap(scene: context.scene)
        }
    }
    
    private func renderMap(scene: RealityKit.Scene) {
        if let mapAnchor {
            scene.removeAnchor(mapAnchor)
        }
        
        mapAnchor = AnchorEntity(world: .zero)
        scene.addAnchor(mapAnchor!)
        currentRenderedFloor = world.currentFloor
        
        for row in world.currentFloor.minY ... world.currentFloor.maxY {
            for col in world.currentFloor.minX ... world.currentFloor.maxX {
                let coordinate = Coordinate(x: col, y: row)
                switch world.currentFloor.tileAt(coordinate) {
                case .wall:
                    mapAnchor?.addChild(placeModelAt(model: "Wall", worldPosition: coordinate.toSIMD3))
                case .stairsUp:
                    mapAnchor?.addChild(placeModelAt(model: "stairsUp", worldPosition: coordinate.toSIMD3))
                case .stairsDown:
                    mapAnchor?.addChild(placeModelAt(model: "stairsDown", worldPosition: coordinate.toSIMD3))
                default:
                    mapAnchor?.addChild(placeModelAt(model: "FloorTile", worldPosition: coordinate.toSIMD3))
                }
            }
        }
    }
    
    private func createCube(worldPosition: SIMD3<Float>) -> AnchorEntity {
        let color = NSColor(hue: CGFloat.random(in: 0...1), saturation: 1, brightness: 1, alpha: 1)
        var cubeMaterial = SimpleMaterial(color: color, isMetallic: true)
        cubeMaterial.metallic = 0.2
        cubeMaterial.roughness = 0.7
        let cubeEntity = Entity(components: [ModelComponent(mesh: .generateBox(size: 1), materials: [cubeMaterial])])
        let cubeAnchor = AnchorEntity(world: worldPosition)
        cubeAnchor.addChild(cubeEntity)
        
        return cubeAnchor
    }
    
    private func placeModelAt(model: String, worldPosition: SIMD3<Float>) -> AnchorEntity {
        let entity = loadEntity(model: model)
        let anchor = AnchorEntity(world: worldPosition)
        anchor.addChild(entity.clone(recursive: true))
        
        return anchor
    }
    
    private func loadEntity(model: String) -> Entity {
        if let entity = modelCache[model] {
            return entity
        }
        
        guard let entity = try? Entity.load(named: model) else {
            fatalError("Failed to load model - \(model)")
        }
        
        modelCache[model] = entity
        return entity
    }
}
