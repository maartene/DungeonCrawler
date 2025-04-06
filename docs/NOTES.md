# Pomodoro Technique - 📝 Notes from the journey 🍅 by 🍅

## 🏷️ Labels

- ✅ done
- 🚧 WIP
- ❌ ERROR
- ⚠️ TODO

## 🍅 Pomodoro 1 - creating a corridor
- ✅ Setup AR view and integrate into SwiftUI
- ✅ Create a corridor to show on screen

## 🍅 Pomodoro 2 - moving around
- ✅ Lights
- 🚧 Player movement
    - ✅ Forward and backward
    - ⚠️ Sideways
    - ⚠️ Rotation

## 🍅 Pomodoro 3 - moving around (all four directions)
- ✅ Moving forward, backwards, left and right
- ✅ Moving in a direction multiple times
- ✅ Refactored the code to be nice and clean

## 🍅 Pomodoro 4 - rotation first
- ✅ Fixed tech debt: folder structure and encapsulation for `Player`.`position`
- ✅ Rotate clockwise and counter clockwise
- ✅ Move while taking facing into account

## 🍅 Pomodoro 5 - gain more confidence about moving while taking facing into account
- ✅ write enough tests to gain confidence in `toCompassDirection`
- ✅ Refactored the `toCompassDirection` function

## 🍅 Pomodoro 6 - visualize movement and rotation in the RealityKit view
- ✅ Create UI to control player
- ✅ Update view as player moves and rotates
- ✅ Keyboard shortcuts
- ✅ Extra colors for the walls, so depth is more explicit

## 🍅 Pomodoro 7 - limit player movement to floor (i.e. cannot move through walls)
- ✅ Limit player movement so they cannot move through walls
- ✅ Remove redundant `rotatedClockwise` computed properties and functions

## 🍅 Pomodoro 8 - start working on moving up and down floors
- ✅ refactored the conversion from game logic coordinate and direction space to 3D coordinates and rotations
- ✅ move up a floor when standing on a stairs leading up.

## 🍅 Pomodoro 9 - Refactoring
- ✅ remove unneeded `Player` abstraction - solving several code smells in one fell swoop

## 🍅 Pomodoro 10 - Changed stair behaviour
- ✅ You move up or down stairs when you move into them
- ✅ Map can now be instected for tiles at a position
- ✅ Add stair visual stubs to the game view
