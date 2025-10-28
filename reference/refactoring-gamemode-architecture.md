# Refactoring Prompt: Game Mode Architecture

## Context

GameManager currently handles both CLASSIC (turn-based) and TIMED (real-time) game modes with conditional logic (`if game_mode == GameMode.TIMED`). This works well now but may benefit from refactoring as the codebase grows.

## Current State

**File:** [autoloads/game_manager.gd](../autoloads/game_manager.gd)

**Key characteristics:**
- 90% of logic is shared between modes (game state, formulas, rules)
- ~5-6 strategic `if game_mode` checks at decision points
- Mode-specific logic concentrated in:
  - `do_work()` - Classic: immediate application, Timed: set action enum
  - `hustle()` - Classic: immediate application, Timed: set action enum
  - `process_game_tick()` - Only runs in timed mode, applies work based on current_action

**Timed mode state:**
- `current_action` enum (PlayerAction.NONE, WORKING, or HUSTLING)
- Actions persist across days (no reset in advance_turn)
- Incremental progress via `process_game_tick(delta)`

**Classic mode:**
- Immediate full-day work application
- Turn advances after action

## Architectural Options to Consider

### Option 1: Keep Current (if statement pattern)
- Simplest, easiest to maintain
- Standard in many successful games
- May accumulate more conditionals over time

### Option 2: Strategy Pattern
- Create `ActionProcessor` base class
- `ClassicActionProcessor` and `TimedActionProcessor` implementations
- Clean separation, easy to add new modes
- More files/complexity, might be overkill for 2 modes

### Option 3: Composition (Extract Timed Logic)
- Create `TimedModeManager` autoload for timed-specific state/logic
- GameManager delegates to it when in timed mode
- Separates concerns while keeping shared logic central
- Two sources of truth for some state

### Option 4: Hybrid (Helper Methods)
- Extract mode checks into descriptive methods: `should_advance_turn_on_action()`
- Centralizes conditionals, improves readability
- Low-effort incremental improvement

## When to Refactor

Consider refactoring if:
1. Adding a 3rd game mode
2. Mode-specific logic exceeds ~10 `if` statements
3. Duplicating formulas/logic between modes
4. Difficulty testing modes independently

## Task for Next Conversation

Review the current architecture and either:
1. **Keep as-is** with justification
2. **Implement Option X** with incremental commits
3. **Propose alternative** architecture pattern

Consider:
- Maintainability vs. complexity tradeoff
- Godot/GDScript best practices
- Testing implications
- Potential future modes (e.g., "CHAOS" mode with random timers)

## Related Files

- [autoloads/game_manager.gd](../autoloads/game_manager.gd) - Core game logic
- [autoloads/timed_mode_controller.gd](../autoloads/timed_mode_controller.gd) - Timer management
- [scenes/game_ui.gd](../scenes/game_ui.gd) - UI handling for both modes
- [reference/godot-best-practices.md](../reference/godot-best-practices.md) - Project coding standards

## Questions to Answer

1. Is the current pattern maintainable as features grow?
2. Would Strategy/Composition reduce or increase cognitive load?
3. Are there Godot-specific patterns that fit better?
4. How would each approach handle a 3rd mode?
5. What's the testing story for each approach?
