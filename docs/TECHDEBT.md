# Tech Debt

## ⚠️ TODO
- `WorldUpdateSystem` is taking on too many responsibilities: moving party as well as showing maps.
- Cleanup initializer for `Map`
- Stairs up only look good at bottom of map and stairs down only look good at top of map

## ✅ DONE

- World code should be test driven, it is not right now
- Cleanup the mess that the folder structure is
- Player `position` breaks encapsulation as its changeable from outside of the class.
- `Direction.toCompassDirection` can be cleaned up. Its long and its smelly.
- Rename `HeadingDirection` to `MovementDirection`
- CompassDirection has both a `rotatedClockwise()` function as well as a `rotatedClockwise` computed variable.
- missing tests for `toAngleAroundAxis` and `toSIMD3`
- Feature envy and/or message chains in `ContentView` and `GameView` where the world's internal properties get accessed directly.
- Hard coded starting position for player in `World`
- Inspecting the map for features (`hasWall` and `hasStairsUp`, ...)
- `World` contains three times the same check for movement and turning
