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

## 🍅 Pomodoro 11 - Added models for walls, stairs and floor/ceiling

- ✅ Added models and changed background color

## 🍅 Pomodoro 12 - Move between floors properly

- ✅ Move between floors and the map changes
- ✅ Visual representation also changes
- ✅ Added caching to improve performance when changing floors

## 🍅 Pomodoro 13 - Win and Lose conditions

- ✅ Implemented a very simple win condition
- ✅ Added a viewmodel that can notify observers (i.e. the UI) of changes to the world state
- ✅ Made sure the viewmodel gets updated every frame

## 🍅 Pomodoro 14 - Model for Win condition

- ✅ Added a model to show the goal of the game
- ✅ After reaching the goal, you can no longer move around
- ✅ Refactoring the World to solve DRY vialotion

## 🍅 Pomodoro 15 - Lose condition

- ✅ Lose condition after all party members are defeated
- ✅ Show (static) HP on game screen

## 🍅 Pomodoro 16 - Updating HP on game screen

- ✅ Update HP on game screen
- ✅ Only send updates when values change

## 🍅 Pomodoro 17 - Updating HP on game screen

- ✅ Show an enemy sprite on screen
- ✅ Have enemy damage the party

## 🍅 Pomodoro 18 - Refacoring WorldUpdateSystem

- ✅ Refactor `WorldUpdateSystem` to smaller parts
- ✅ Add billboarding to enemy sprite
- ✅ Add lighting to enemy sprite

## 🍅 Pomodoro 19 - Better world initializer

- ✅ Create a `makeWorld` factory method
- ✅ Refactor it
- ✅ Use it in the game

## 🍅 Pomodoro 19 - Sprite swapping

- ✅ Swap sprites based on player and enemy facing
- ✅ Fix ❌ where sprite positioning was hard coded
