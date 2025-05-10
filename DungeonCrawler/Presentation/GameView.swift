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

    private func setupView(_ arView: ARView) {
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
