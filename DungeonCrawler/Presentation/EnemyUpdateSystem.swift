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
    private var textureCache = [String: MaterialParameters.Texture]()

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
            sprite.transform.rotation = .init(angle: world.partyHeading.toFloatQuaternion.angle, axis: [0,1,0])
            sprite.children[0].components[ModelComponent.self] = makeModelComponentFor(enemy)
        } else {
            let plane = Entity(components: [makeModelComponentFor(enemy)])
            plane.transform.rotation = .init(angle: Float.pi / 2, axis: [1,0,0])
            let spriteAnchor = AnchorEntity(world: enemy.position.toSIMD3 + SIMD3<Float>(0, -0.2, 0))
            spriteAnchor.addChild(plane)
            enemyAnchor.addChild(spriteAnchor)
            
            enemySpriteMap[ObjectIdentifier(enemy)] = spriteAnchor
        }
    }
    
    private func makeModelComponentFor(_ enemy: Enemy) -> ModelComponent {
        let textureName = determineTextureNameFor(enemy, partyHeading: world.partyHeading)
        let texture = loadSpriteTexture(textureName)
        var spriteMaterial = UnlitMaterial()
        let light = 1.0 / (world.partyPosition - enemy.position).magnitude
        spriteMaterial.color = .init(tint: .init(white: light, alpha: 1.0), texture: texture)
        spriteMaterial.blending = .transparent(opacity: 1.0)
        return ModelComponent(mesh: .generatePlane(width: 1, depth: 1), materials: [spriteMaterial])
    }
    
    private func loadSpriteTexture(_ name: String) -> MaterialParameters.Texture {
        if let texture = textureCache[name] {
            return texture
        }
        
        let textureResource = try! TextureResource.load(named: name)
        let texture = MaterialParameters.Texture(textureResource)
        textureCache[name] = texture
        return texture
    }
    
    private func determineTextureNameFor(_ enemy: Enemy, partyHeading: CompassDirection) -> String {
        var textureName = "Skeleton_Mage_Idle"
        
        let rotationSuffix = switch (enemy.heading, partyHeading) {
        case (.north, .north): "_180deg"
        case (.south, .north): "_0deg"
        case (.east, .north): "_270deg"
        case (.west, .north): "_90deg"
            
        case (.west, .west): "_180deg"
        case (.east, .west): "_0deg"
        case (.north, .west): "_270deg"
        case (.south, .west): "_90deg"
            
        case (.west, .east): "_0deg"
        case (.east, .east): "_180deg"
        case (.north, .east): "_90deg"
        case (.south, .east): "_270deg"
            
        case (.north, .south): "_90deg"
        case (.south, .south): "_180deg"
        case (.east, .south): "_90deg"
        case (.west, .south): "_270deg"
        }
        
        textureName += rotationSuffix
        textureName += "_0"
        
        return textureName
    }
}
