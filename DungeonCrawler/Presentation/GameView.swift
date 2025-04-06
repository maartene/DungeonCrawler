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
    
    private func addFloorAndCeiling(_ arView: ARView) {
        // create floor
        let floorMaterial = SimpleMaterial(color: .gray, isMetallic: false)
        let floorEntity = ModelEntity(mesh: .generatePlane(width: 10, depth: 10), materials: [floorMaterial])
        let floorAnchor = AnchorEntity(world: SIMD3<Float>(x: 0, y: -0.5, z: 0))
        floorAnchor.addChild(floorEntity)
        arView.scene.addAnchor(floorAnchor)
        
        let ceilingEntity = ModelEntity(mesh: .generatePlane(width: 10, depth: 10), materials: [floorMaterial])
        let ceilingAnchor = AnchorEntity(world: SIMD3<Float>(x: 0, y: 0.5, z: 0))
        ceilingAnchor.transform.rotation = simd_quatf(angle: .pi, axis: [0, 0, 1])
        ceilingAnchor.addChild(ceilingEntity)
        arView.scene.addAnchor(ceilingAnchor)
    }
    
    private func setupView(_ arView: ARView) {
        for row in world.map.minX ... world.map.maxX {
            for col in world.map.minX ... world.map.maxX {
                let coordinate = Coordinate(x: col, y: row)
                if world.map.tileAt(coordinate) == .wall {
                    arView.scene.addAnchor(createCube(worldPosition: coordinate.toSIMD3))
                }
            }
        }
        
        guard let skyboxResource = try? EnvironmentResource.load(named: "ambientLight") else {
            fatalError("Unable to load skybox resource")
        }
        
        arView.environment.lighting.resource = skyboxResource
        
        let camera = PerspectiveCamera()
        let cameraAnchor = AnchorEntity(world: .zero)
        cameraAnchor.addChild(camera)
        cameraAnchor.name = "CameraAnchor"
        arView.scene.addAnchor(cameraAnchor)
        
        let lightEntity = PointLight()
        cameraAnchor.addChild(lightEntity)
        
        addFloorAndCeiling(arView)
        
        let worldEntity = Entity(components: [WorldComponent(world: world)])
        worldEntity.name = "WorldEntity"
        let worldAnchor = AnchorEntity(world: .zero)
        worldAnchor.addChild(worldEntity)
        arView.scene.addAnchor(worldAnchor)
    }
}
