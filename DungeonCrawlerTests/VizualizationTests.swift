//
//  VizualizationTests.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 29/03/2025.
//

import Testing
@testable import DungeonCrawler
import simd
import Combine

@Suite("Converting between game logic structures and visual representations should") struct ConversionGameLogicAndVizualizationTests {
    @Test("return the expected position and rotation for specific testcases", arguments: [
        (Coordinate(x: -5, y: 5), CompassDirection.west, SIMD3<Float>(-5.0, 0.0, -5.0), simd_quatf(real: 0.7071068, imag: SIMD3<Float>(0.0, 0.70710677, 0.0))),
        (Coordinate(x: 0, y: 3), CompassDirection.north, SIMD3<Float>(0.0, 0.0, -3.0), simd_quatf(real: 1.0, imag: SIMD3<Float>(0.0, 0.0, 0.0))),
        (Coordinate(x: -3, y: 4), CompassDirection.west, SIMD3<Float>(-3.0, 0.0, -4.0), simd_quatf(real: 0.7071068, imag: SIMD3<Float>(0.0, 0.70710677, 0.0))),
        (Coordinate(x: 2, y: -3), CompassDirection.south, SIMD3<Float>(2.0, 0.0, 3.0), simd_quatf(real: 7.54979e-08, imag: SIMD3<Float>(0.0, 1.0, 0.0))),
        (Coordinate(x: -2, y: -6), CompassDirection.west, SIMD3<Float>(-2.0, 0.0, 6.0), simd_quatf(real: 0.7071068, imag: SIMD3<Float>(0.0, 0.70710677, 0.0))),
        (Coordinate(x: -5, y: 7), CompassDirection.east, SIMD3<Float>(-5.0, 0.0, -7.0), simd_quatf(real: -0.70710677, imag: SIMD3<Float>(0.0, 0.70710677, 0.0))),
        (Coordinate(x: -9, y: 10), CompassDirection.west, SIMD3<Float>(-9.0, 0.0, -10.0), simd_quatf(real: 0.7071068, imag: SIMD3<Float>(0.0, 0.70710677, 0.0))),
        (Coordinate(x: 8, y: 2), CompassDirection.west, SIMD3<Float>(8.0, 0.0, -2.0), simd_quatf(real: 0.7071068, imag: SIMD3<Float>(0.0, 0.70710677, 0.0))),
        (Coordinate(x: -7, y: -3), CompassDirection.west, SIMD3<Float>(-7.0, 0.0, 3.0), simd_quatf(real: 0.7071068, imag: SIMD3<Float>(0.0, 0.70710677, 0.0))),
        (Coordinate(x: -4, y: 8), CompassDirection.north, SIMD3<Float>(-4.0, 0.0, -8.0), simd_quatf(real: 1.0, imag: SIMD3<Float>(0.0, 0.0, 0.0))),
        (Coordinate(x: 0, y: 1), CompassDirection.west, SIMD3<Float>(0.0, 0.0, -1.0), simd_quatf(real: 0.7071068, imag: SIMD3<Float>(0.0, 0.70710677, 0.0))),
        (Coordinate(x: 6, y: -5), CompassDirection.south, SIMD3<Float>(6.0, 0.0, 5.0), simd_quatf(real: 7.54979e-08, imag: SIMD3<Float>(0.0, 1.0, 0.0))),
        (Coordinate(x: -4, y: -7), CompassDirection.north, SIMD3<Float>(-4.0, 0.0, 7.0), simd_quatf(real: 1.0, imag: SIMD3<Float>(0.0, 0.0, 0.0))),
        (Coordinate(x: -9, y: 2), CompassDirection.west, SIMD3<Float>(-9.0, 0.0, -2.0), simd_quatf(real: 0.7071068, imag: SIMD3<Float>(0.0, 0.70710677, 0.0))),
        (Coordinate(x: -8, y: -4), CompassDirection.east, SIMD3<Float>(-8.0, 0.0, 4.0), simd_quatf(real: -0.70710677, imag: SIMD3<Float>(0.0, 0.70710677, 0.0))),
        (Coordinate(x: 8, y: 5), CompassDirection.east, SIMD3<Float>(8.0, 0.0, -5.0), simd_quatf(real: -0.70710677, imag: SIMD3<Float>(0.0, 0.70710677, 0.0))),
        (Coordinate(x: 0, y: 6), CompassDirection.south, SIMD3<Float>(0.0, 0.0, -6.0), simd_quatf(real: 7.54979e-08, imag: SIMD3<Float>(0.0, 1.0, 0.0))),
        (Coordinate(x: 5, y: -5), CompassDirection.west, SIMD3<Float>(5.0, 0.0, 5.0), simd_quatf(real: 0.7071068, imag: SIMD3<Float>(0.0, 0.70710677, 0.0))),
        (Coordinate(x: 6, y: 5), CompassDirection.east, SIMD3<Float>(6.0, 0.0, -5.0), simd_quatf(real: -0.70710677, imag: SIMD3<Float>(0.0, 0.70710677, 0.0))),
        (Coordinate(x: -4, y: 5), CompassDirection.east, SIMD3<Float>(-4.0, 0.0, -5.0), simd_quatf(real: -0.70710677, imag: SIMD3<Float>(0.0, 0.70710677, 0.0)))
    ]) func convertingBetweenGameLogicPositionAndRotationAndVizualization(testcase: (position: Coordinate, heading: CompassDirection, expectedPosition: SIMD3<Float>, expectedRotation: simd_quatf)) {
        #expect(testcase.position.toSIMD3 == testcase.expectedPosition)
        #expect(testcase.heading.toFloatQuaternion == testcase.expectedRotation)
    }
}



final class MockObserver {
    var state = WorldState.undetermined
    var cancelables = Set<AnyCancellable>()
    
    init(observing viewModel: ViewModel) {
        viewModel.$worldState.sink { [weak self] in
            self?.state = $0
        }.store(in: &cancelables)
    }
}

@Suite("ViewModel should") struct ViewModelTests {
    @Test("When the state of the world changes and the ViewModel is updates, the ViewModel notifies its observers") func viewModelNotifiesObserversOfWorldStateChanges() {
        let world = World(map: Map([
            [".","T"]
        ]))
        let viewModel = ViewModel(world: world)
        let observer = MockObserver(observing: viewModel)
        world.perform(.move(direction: .right))
        
        viewModel.update()
        
        #expect(observer.state == .win)
        
    }
}
