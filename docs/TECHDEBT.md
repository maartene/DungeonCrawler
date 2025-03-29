#  Tech Debt

## ⚠️ TODO
- Cleanup initializer for Map

## ✅ DONE
- World code should be test driven, it is not right now
- Cleanup the mess that the folder structure is
- Player `position` breaks encapsulation as its changeable from outside of the class.
- `Direction.toCompassDirection` can be cleaned up. Its long and its smelly.
- Rename `HeadingDirection` to `MovementDirection`
- CompassDirection has both a `rotatedClockwise()` function as well as a `rotatedClockwise` computed variable.
