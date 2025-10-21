# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

---

## Project Overview

**Alt+F+This** - *"Papers Please meets Office Space with duck-based emotional damage"*

A darkly comedic inspection/management game built in Godot 4.5 where you're a tech worker trapped in corporate hell. Inspect work tickets, make impossible decisions, and escape with $5K before you run out of ducks to give.

---

## Game Design Vision

**See [ideas/game-plan.md](ideas/game-plan.md) for complete design, mechanics, and systems.**

### Core Concept
Papers Please meets Office Space with duck-based emotional damage. Save $5K before bugs make work impossible.

### Key Design Rules
1. **Bugs NEVER decrease** - No DEBUG action, permanent consequences
2. **3 actions only** - WORK, HUSTLE, SHIP IT (daily choice is the core loop)
3. **SHIP IT is the game** - Daily temptation to ship incomplete work, creates bugs
4. **Payment on completion only** - Creates urgency to ship early vs. ship clean

---

## Running the Game

Open project in Godot 4.5 and press F5. Main scene: [scenes/game_ui.tscn](scenes/game_ui.tscn)

---

## Architecture

### Signal-Driven Design
The game uses a reactive signal architecture where:
1. GameManager holds all state with property setters that emit signals
2. UI components connect to signals in `_ready()`
3. State changes propagate automatically through signals
4. **Never update UI directly** - always emit signals from GameManager

---

## Godot UI Best Practices

### Styling & Theming
- **Use Theme resources** (`.tres` files) for visual styling, not inline code
- Apply theme overrides in script `_ready()`, not in `.tscn` scene files
- Example: `themes/badge_theme.tres` for category badges

### UI Constants
- Define font sizes and colors as constants at top of scripts
- Makes theme adjustments trivial across the game
- Example: `FONT_SIZE_CRITICAL = 24`, `COLOR_BRIGHT_GREEN = Color(...)`

### Mobile UI Requirements
- **Minimum font size: 18px** (readable on 720x1280 portrait)
- Use size + color for visual hierarchy, never text smaller than 18px
- Touch-friendly spacing and button sizes

### Code Organization
- Extract styling/creation into helper functions (e.g., `_create_badge()`)
- Update functions should only handle data, not styling
- Separate concerns: data updates vs. visual presentation

---

## Incremental Implementation Workflow

**IMPORTANT:** Break features into small, testable commits (20-100 lines, 1-3 files each).

Before implementing any feature:
1. Plan 3-6 small commits
2. Each commit should be immediately testable
3. Implement → Test → Commit → Next

### Commit Style
- Single-line commit messages for small changes
- Always include Claude Code footer for tracking AI contributions

See [ideas/workflow-incremental-implementation.md](ideas/workflow-incremental-implementation.md) for details.

### Autoloaded Singletons

**GameManager** ([autoloads/game_manager.gd](autoloads/game_manager.gd))
- Central game state: `day`, `money`, `salary`, `ducks`, `bugs`, `strikes`, `current_task`
- All properties use setters that emit signals (e.g., `money_changed`, `ducks_changed`, `bugs_changed`)
- Game actions: `do_work()`, `hustle()`, `debug()`, `process_action()`
- Bug system: `get_bug_multiplier()`, `add_bugs(amount)`
- Events: `next_day`, `missed_deadline`, `event_occurred`, `game_over`, `production_outage`

**TaskManager** ([autoloads/task_manager.gd](autoloads/task_manager.gd))
- Loads tasks from [data/tasks.json](data/tasks.json)
- Provides `get_random_task(today_date, min_complexity, max_complexity)` for difficulty scaling
- Tasks have: title, description, complexity (1-10), allowed_time, category, completion_text

---

## Critical Implementation Notes

### ⚠️ Bugs Are PERMANENT
**NEVER implement bug reduction.** No DEBUG action. Bugs never decrease. This is the core tension.

### ⚠️ Task Complexity (NOT YET IMPLEMENTED)
**ALWAYS use task complexity** when calculating progress:
```gdscript
# WRONG (current code)
progress += 20

# CORRECT (what it should be)
var bug_multiplier = get_bug_multiplier()  # 1.0 + (bugs * 0.01)
progress += 20 / (complexity * bug_multiplier)
```

### ⚠️ SHIP IT Is The Core Mechanic
Daily decision: "Is this good enough to ship?"
- Available at 20%+ progress
- Bugs added: `(100 - progress) / 10`
- Duck change based on quality (see game plan for details)
- Immediate payment (creates urgency)

### ⚠️ Death Spiral Is Intentional
Bugs → slower work → can't meet deadlines → ship early → more bugs → repeat. This is **intentional game design**, not a bug to fix. The game is a race: earn $5K before bugs make it impossible.

---

## Writing Style

All game text should be:
- **Dry, deadpan humor** - Not silly or over-the-top
- **Specific tech references** - "blockchain todo app", not generic "do the thing"
- **Absurdist but grounded** - Corporate demands are ridiculous but recognizable
- **Dark without being mean** - Satirical, not cruel

Examples from [data/tasks.json](data/tasks.json):
- "Make the Logo Bigger (Again)"
- "Fix the 'Sent with Wrong Font' Email"
- "CEO's 'Simple' Excel Macro"

---

## Quick Reference

### Target Actions (Final Design)
- **WORK**: +progress (scaled by complexity + bugs), 30% event chance, paid on completion/payday
- **HUSTLE**: +salary×2 (on payday), +1 duck, 50% event chance, no progress
- **SHIP IT**: Complete task, add bugs `(100-progress)/10`, duck change by quality, immediate payment

### Win/Lose Conditions
- **Victory**: $5,000 → escape to Act 2
- **Game Over**: 0 ducks (burnout) OR 100+ bugs (death spiral) OR salary trap ($2,500/5 days)

### Balance Targets
- Complexity 5 task: ~5 days (0 bugs), ~7 days (40 bugs), ~9 days (80 bugs)
- Escape: 30-50 days depending on choices
- Ducks: Start with 3, rarely gain back
- Most players: ship 80-90% early, 40-60% later

---

## Key Files

- **Game plan & design**: [ideas/game-plan.md](ideas/game-plan.md)
- **Godot best practices**: [ideas/godot-best-practices.md](ideas/godot-best-practices.md)
- **Incremental workflow**: [ideas/workflow-incremental-implementation.md](ideas/workflow-incremental-implementation.md)
