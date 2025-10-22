# Project Structure & Code Organization

Quick reference for where code lives and how managers are organized.

---

## Directory Structure

```
autoloads/           # Singleton managers
  ├── game_manager.gd
  └── task_manager.gd

scripts/
  ├── resources/     # Data classes
  │   └── task.gd
  └── ui/            # UI components

data/                # Content (JSON)
  ├── tasks.json
  ├── events.json
  └── ship_messages.json

scenes/              # Scene files
  ├── game_ui.tscn
  ├── components/
  └── dialogs/
```

---

## GameManager Responsibilities

**What it should contain:**
- Core state variables (money, ducks, bugs, day, salary, escape_progress)
- State change signals
- High-level game actions (work, hustle, ship_it)
- Game flow (advance_day, check_game_over, check_victory)
- Victory/game over conditions

**What it should NOT contain:**
- UI update logic (use signals)
- Detailed calculations (extract to helper functions if > 20 lines)
- Event text/content (load from JSON)
- Sound effects (would go in AudioManager if added)

**Target size:** < 300 lines. If it exceeds this, split into separate systems.

---

## When to Extract Systems

If GameManager exceeds ~300 lines, extract helper systems:
- `BugSystem` - bug calculations
- `PaydaySystem` - payday logic
- `OutageSystem` - production outage tracking

---

## TaskManager Responsibilities

- Load tasks from JSON
- Provide `get_random_task()` with filtering
- Task complexity scaling based on day/bugs
- No game state (that's GameManager's job)

---

## UI Component Pattern

```gdscript
extends PanelContainer

func _ready():
    GameManager.money_changed.connect(_update_money)
    _update_all()  # Initial state

func _update_money(new_amount: int):
    money_label.text = "$%d" % new_amount
```

---

## Data Files

**tasks.json** - Task definitions with complexity, category, time
**events.json** - Random events with consequences
**ship_messages.json** - Quality-based flavor text for shipping

---

## Naming Conventions

**Variables:** `lowercase`, constants: `UPPER_CASE`, private functions: `_prefix`

**Signals:**
- State changes: `money_changed`, `task_completed` (past tense)
- Events: `production_outage`, `game_over` (present tense)

**Files:** All `snake_case` (scripts, scenes, resources)
