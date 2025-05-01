//
//  GameView.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 22/02/2025.
//

import SwiftUI
import RealityKit

struct GameView: NSViewRepresentable {
    let world: World
    
    func makeNSView(context: Context) -> ARView {
        let view = ARView()
        
        setupView(view)
        
        WorldUpdateSystem.registerSystem()
        
        return view
        
    }
    
    func updateNSView(_ nsView: NSViewType, context: Context) {
        // doesn't need anything yet
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
        guard let entity = try? Entity.load(named: model) else {
            fatalError("Failed to load model - \(model)")
        }
        let anchor = AnchorEntity(world: worldPosition)
        anchor.addChild(entity)
        
        return anchor
    }
    
    private func setupView(_ arView: ARView) {
        for row in world.map.minX ... world.map.maxX {
            for col in world.map.minX ... world.map.maxX {
                let coordinate = Coordinate(x: col, y: row)
                switch world.map.tileAt(coordinate) {
                case .wall:
                    arView.scene.addAnchor(placeModelAt(model: "Wall", worldPosition: coordinate.toSIMD3))
                case .stairsUp:
                    arView.scene.addAnchor(placeModelAt(model: "stairsUp", worldPosition: coordinate.toSIMD3))
                case .stairsDown:
                    arView.scene.addAnchor(placeModelAt(model: "stairsDown", worldPosition: coordinate.toSIMD3))
                default:
                    arView.scene.addAnchor(placeModelAt(model: "FloorTile", worldPosition: coordinate.toSIMD3))
                }
            }
        }
        
        guard let skyboxResource = try? EnvironmentResource.load(named: "ambientLight") else {
            fatalError("Unable to load skybox resource")
        }
        
        arView.environment.background = .color(.black)
        arView.environment.lighting.resource = skyboxResource
        
        let camera = PerspectiveCamera()
        let cameraAnchor = AnchorEntity(world: .zero)
        cameraAnchor.addChild(camera)
        cameraAnchor.name = "CameraAnchor"
        arView.scene.addAnchor(cameraAnchor)
        
        let lightEntity = PointLight()
        cameraAnchor.addChild(lightEntity)
        
        let worldEntity = Entity(components: [WorldComponent(world: world)])
        worldEntity.name = "WorldEntity"
        let worldAnchor = AnchorEntity(world: .zero)
        worldAnchor.addChild(worldEntity)
        arView.scene.addAnchor(worldAnchor)
    }
}
