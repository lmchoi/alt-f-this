# Timed Mode Implementation Prompt

## Context

You're working in the `alt-f-this-timed` worktree on the `feature/timed-mode` branch.

**Working directory**: `/Users/mandy/workspace/alt-f-this-timed`

This is a separate worktree created to prototype a real-time/timed gameplay mode without affecting the main branch. You don't need to worry about worktrees - just work normally in this directory.

---

## Task: Implement Timed Work Mode

Create a real-time gameplay mode as an alternative to the current turn-based system.

### Design Goals

**Current (Turn-Based)**:
- Player clicks action button → day advances
- Player controls pacing completely
- Allows time to think through decisions

**New (Timed Mode)**:
- Real-time countdown per day (duration TBD - suggest 30-60 seconds?)
- Player must make decision before time runs out
- Same actions (WORK, HUSTLE, SHIP IT) but under time pressure
- Creates tension and urgency

### What Should Stay The Same

- All game state and logic (GameManager)
- Task system (TaskManager)
- Bug/duck/money/deadline mechanics
- UI panels and displays
- Win/lose conditions

### What Needs To Change

- Add timer/countdown system
- Auto-advance day when timer expires
- Visual countdown indicator (progress bar? numeric timer?)
- Possibly default action if player doesn't choose in time?
- Game mode selection (how does player choose timed vs classic?)

---

## Implementation Approach

Use incremental commits (20-100 lines each). Suggested breakdown:

1. Add game mode enum and selection mechanism
2. Create timer component (countdown logic only)
3. Add timer UI element (display countdown)
4. Wire timer to day advancement
5. Update action buttons for timed mode
6. Test and polish timing/feel

---

## Questions To Consider

- How long should each day timer be? (30s? 60s? Configurable?)
- What happens if timer expires and player hasn't acted? (Auto-WORK? Force decision?)
- Should timer pause during dialogs (end game, promotions, etc.)?
- How does player select timed mode? (Main menu? Debug panel? Startup choice?)
- Does time pressure make the game MORE fun or just more stressful?

---

## Reference Files

- **GameManager**: [autoloads/game_manager.gd](autoloads/game_manager.gd) - Core game state
- **Action buttons**: [scenes/action_panel.gd](scenes/action_panel.gd) - WORK/HUSTLE/SHIP IT
- **Main UI**: [scenes/game_ui.tscn](scenes/game_ui.tscn) - Where timer UI would go
- **Game design**: [ideas/game-design.md](ideas/game-design.md) - Core principles

---

**Start by exploring the codebase and proposing a specific implementation plan before writing code.**
