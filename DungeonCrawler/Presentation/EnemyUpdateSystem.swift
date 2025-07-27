//
//  EnemyUpdateSystem.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 27/07/2025.
//

import RealityKit
import SwiftUI

class EnemyUpdateSystem: System {
    var world: World!
    private var enemyAnchor = AnchorEntity(world: .zero)
    private var enemySpriteMap = [ObjectIdentifier: RealityKit.AnchorEntity]()

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
        scene.addAnchor(enemyAnchor)
    }

    func update(context: SceneUpdateContext) {
        renderEnemies(scene: context.scene)
    }

    private func renderEnemies(scene: RealityKit.Scene) {
        for enemy in world.enemiesOnCurrentFloor {
            renderEnemy(enemy)
        }
    }
    
    private func renderEnemy(_ enemy: Enemy) {
        if let sprite = enemySpriteMap[ObjectIdentifier(enemy)] {
            // don't do anything yet
            // we can do updates and stuff here
            sprite.transform.rotation = .init(angle: world.partyHeading.toFloatQuaternion.angle, axis: [0,1,0])
            
        } else {
            let textureResource = try! TextureResource.load(named: "Skeleton_Mage_Idle_0deg_0")
            let texture = MaterialParameters.Texture(textureResource)
            var spriteMaterial = UnlitMaterial()
            spriteMaterial.color = .init(tint: .white, texture: texture)
            spriteMaterial.blending = .transparent(opacity: 1.0)
            let plane = Entity(components: [ModelComponent(mesh: .generatePlane(width: 1, depth: 1), materials: [spriteMaterial])])
            plane.transform.rotation = .init(angle: Float.pi / 2, axis: [1,0,0])
            let spriteAnchor = AnchorEntity(world: [1, -0.2, -3])
            spriteAnchor.addChild(plane)
            enemyAnchor.addChild(spriteAnchor)
            
            enemySpriteMap[ObjectIdentifier(enemy)] = spriteAnchor
        }
    }
}
