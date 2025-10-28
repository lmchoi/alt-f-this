# Task Category Mechanics Implementation Summary

## Context
Implemented task category risk profiles for Alt+F+This game with three categories: Critical, Optics, and Tech Debt.

## What Was Implemented

### Core Mechanics
1. **Critical Tasks** - Ship <80% → guaranteed outage next turn (via time bomb system)
   - Added to `poorly_shipped_tasks` array as `{name: String, is_critical: bool}`
   - `check_time_bombs()` checks critical tasks first with 100% outage chance
   - NOT instant - triggers on next turn to keep all outage logic centralized

2. **Optics Tasks** - 1 day late → instant PIP (vs 3 days for normal tasks)
   - Uses `OPTICS_MAX_OVERDUE_DAYS = 1` constant
   - Modified `advance_turn()` to check task category before PIP trigger

3. **Tech Debt Tasks** - Bugs × 3 when shipped incomplete
   - Initially 10x, reduced to 3x for better balance
   - Uses `TECH_DEBT_BUG_MULTIPLIER = 3.0` constant
   - Example: ship at 50% = 15 bugs (vs 5 for normal)

4. **Clean Code Tokens** - Earned by shipping ANY task at 100%
   - Tracked stat, shown in end game stats
   - NOT just for tech debt - reward for quality work on any task

### Files Changed
- `autoloads/game_manager.gd` - Core category mechanics
- `scenes/game_ui.gd` - Debug test scenarios
- `scenes/end_game_panel.gd` - Display clean code tokens
- `reference/implementation-status.md` - Documentation
- `ideas/TODO.md` - Marked category implementation complete

## Key Design Decisions

### Critical Task Outage Flow
**Original approach (rejected):** Trigger outage immediately in `ship_it()`
**Final approach (accepted):** Add to time bomb system, trigger on next turn
- Keeps all outage logic in one central place (`check_time_bombs()`)
- Critical tasks get 100% chance vs random chance for normal tasks
- Cleaner separation of concerns

### Bug Multiplier Tuning
- Started at 10x (too brutal)
- Adjusted to 3x (good balance)
- 50% ship = 15 bugs feels punishing but not devastating

### Tutorial System
User removed tutorial popups from their branch (`add-task-category-mechanics`) but kept them on separate feature branch for potential future use.
- Tutorial commits cherry-picked to main for preservation
- Current implementation: no tutorials, just mechanics

## Testing Approach

Debug scenarios in `_setup_test_scenario()`:
```gdscript
# Force specific category task
var test_task = Task.new()
test_task.categories = ["tech_debt"]  # or "critical", "optics"
GameManager.current_task = test_task
```

**Important:** Must use typed array: `Array[String]` not just `Array`

## Branch Structure
- `main` - Has tutorial commits cherry-picked
- `add-task-category-mechanics` - User's working branch, no tutorials
- `feature/task-category-mechanics` - My original branch with full implementation

## Common Gotchas
1. `poorly_shipped_tasks` changed from `Array[String]` to `Array[Dictionary]`
   - Old: `["Task Name"]`
   - New: `[{"name": "Task Name", "is_critical": false}]`
   
2. Critical outages are NOT instant - they happen next turn via time bomb system

3. Clean code tokens awarded for ANY 100% ship, not just tech debt

4. Category arrays must be typed: `var categories_array: Array[String] = ["tech_debt"]`

## Documentation Accuracy
Keep these numbers accurate in docs:
- Tech debt multiplier: **3x** (not 10x)
- Clean code tokens: **any task at 100%** (not just tech debt)
- Critical outages: **guaranteed next turn** (not instant)
- No tutorial/badge UI (mechanics only)

## Learnings for Future Context Awareness

### What I Should Check First (Before Asking Redundant Questions)
When asked to implement a feature, ALWAYS check these files first:

1. **Data files** - `data/tasks.json`, `data/*.json`
   - May already have fields/structure ready but unused
   - Example: `categories` field existed but had no game logic

2. **GameManager state** - `autoloads/game_manager.gd`
   - Check existing variables, signals, constants
   - PIP warnings, outage system, etc. were already implemented
   - Don't assume features need to be built from scratch

3. **TaskManager** - `autoloads/task_manager.gd`
   - Check what's already parsed from JSON
   - Categories were already being loaded into Task objects

4. **Reference docs** - `reference/implementation-status.md`
   - But be aware: may be outdated or incomplete
   - Use as guide, but verify in code

### Common Pattern in This Codebase
- **Data-driven design**: Many systems load from JSON
- **Signal-driven UI**: GameManager emits signals, UI listens
- **Incremental commits**: User prefers small, testable commits (20-100 lines)
- **Implementation first, docs after**: Build it, test it, then document

### What to Ask vs What to Check
**DON'T ask:**
- "Does X exist?" → Just grep/read the files
- "How does Y work?" → Read the implementation first, ask for clarification if unclear

**DO ask:**
- Design direction: "Should critical outages be instant or delayed?"
- Balance tuning: "Is 10x too harsh?"
- Architecture decisions: "Should this be centralized or distributed?"

### Suggested Documentation Improvements
Add to `CLAUDE.md` or `reference/implementation-status.md`:
```markdown
## Critical Game State Variables (GameManager)
- pip_warnings (0-2, fired at 2)
- production_outages (tracked for stats)
- poorly_shipped_tasks (time bombs)
- overdue_days (3 days → PIP)
- clean_code_tokens (quality metric)
```

This helps AI assistants understand what's already wired up vs what needs building.
