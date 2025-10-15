# Godot Best Practices for Alt+F+This

Quick reference for architectural decisions and patterns to follow during development.

---

## Core Principles

1. **Signals over direct calls** - Keep systems decoupled
2. **Resources for data, Nodes for behavior** - Task = Resource, TaskProcessor = Node
3. **Composition over inheritance** - Use scene components, not deep class hierarchies
4. **Event-driven updates** - Don't update every frame, react to signals
5. **Keep GameManager under 300 lines** - Split into systems when it grows

---

## Godot-Specific Patterns We're Using

### ✅ **Signal-Driven Architecture**
```gdscript
# In GameManager
var money := 0:
    set(value):
        money = value
        money_changed.emit(money)

# In UI
GameManager.money_changed.connect(_on_money_changed)
```

### ✅ **Unique Node Names**
```gdscript
@onready var day_label = $"%DayLabel"  # Finds anywhere in subtree
```

### ✅ **Resources for Data**
```gdscript
class_name Task extends Resource  # Pure data, no behavior
```

### ✅ **JSON for Content**
```gdscript
# data/tasks.json - easy to balance without code changes
```

---

## What to Use Autoloads For

**✅ Good Autoload Candidates:**
- GameManager (game state)
- TaskManager (task data)
- EventBus (global events - if needed)
- AudioManager (if we add sound)
- SaveManager (if we add persistence)

**❌ Don't Autoload:**
- UI elements (should be in scene tree)
- Player/entities (should be instanced)
- Anything that needs multiple instances

---

## Code Organization

### Current Structure
```
autoloads/           # Singletons
  ├─ game_manager.gd
  └─ task_manager.gd

scripts/
  ├─ resources/      # Data classes
  │  └─ task.gd
  └─ ui/             # UI components
     ├─ action_button.gd
     ├─ money_label.gd
     └─ progress_ducks.gd

data/                # Content (JSON)
  └─ tasks.json

scenes/              # Scene files
  ├─ game_ui.tscn
  └─ dialogs/
```

### When to Split GameManager

If GameManager exceeds ~300 lines, consider:
```gdscript
# Keep in GameManager
- Core state (money, ducks, day, salary)
- State change signals
- High-level game flow

# Move to separate systems
- BugSystem (bug accumulation/slowdown logic)
- TimeBombSystem (production outage tracking)
- EventSystem (event triggering/tracking)
```

---

## Performance Guidelines

### ✅ **Cache Node References**
```gdscript
@onready var sprite = $Sprite2D  # Once on ready
```

### ❌ **Don't Search Tree Every Frame**
```gdscript
func _process(delta):
    $Sprite2D.position = ...  # Searches every frame - BAD
```

### ✅ **Use Enums Over Strings**
```gdscript
enum PlayerAction {WORK, HUSTLE, DEBUG, REST}

match action:
    PlayerAction.WORK: do_work()  # Fast

# Not: if action == "work": ...  # Slow string comparison
```

---

## Constants and Magic Numbers

### ✅ **Extract to Constants**
```gdscript
# In game_manager.gd or separate constants file
const ESCAPE_GOAL := 5000
const BASE_PROGRESS := 20
const STARTING_DUCKS := 3
const HUSTLE_MULTIPLIER := 2
const DEBUG_AMOUNT := 15
const STRIKE_LIMIT := 3
const BUG_SLOWDOWN_FACTOR := 100.0  # bugs / 100 = slowdown %
```

### ❌ **Don't Hardcode**
```gdscript
if money >= 5000:  # What's 5000? Why 5000?
```

---

## Signal Best Practices

### ✅ **Unidirectional Data Flow**
```
GameManager (source of truth)
     ↓ (signals)
UI Components (react to changes)
```

UI should NEVER directly modify GameManager state. Always call functions:
```gdscript
# ❌ Don't
GameManager.money = 100  # Direct modification

# ✅ Do
GameManager.add_money(100)  # Function handles logic + signal
```

### ✅ **Name Signals Clearly**
```gdscript
signal money_changed(new_amount)     # Good - what changed
signal ducks_changed(new_amount)     # Good
signal production_outage(severity)   # Good - what happened

# Not: signal update()  # Bad - vague
```

---

## Scene Organization

### ✅ **Scenes for Reusable Components**
```
scenes/
├─ game_ui.tscn              # Main game screen
├─ ticket_inspection.tscn    # Papers Please desk (Phase 1)
├─ work_phase.tscn           # Daily actions (Phase 1)
└─ dialogs/
   ├─ deadline_dialog.tscn
   ├─ outage_dialog.tscn
   └─ event_dialog.tscn
```

### ✅ **Self-Contained Components**
Each scene should:
- Have its own script
- Emit signals for external communication
- Not assume parent structure
- Be testable in isolation

---

## Data-Driven Design

### ✅ **Keep Content in JSON**
```json
// data/tasks.json
{
  "tasks": [
    {
      "title": "Add Blockchain",
      "complexity": 5,
      "allowed_time": 4
    }
  ]
}

// data/events.json (to add)
{
  "events": [
    {
      "text": "Boss says we're a family",
      "choices": [...]
    }
  ]
}
```

**Benefits:**
- Easy to balance (tweak numbers without code)
- Non-programmers can add content
- Version control friendly (see what changed)

---

## Anti-Patterns to Avoid

### ❌ **Get Node Hell**
```gdscript
# Don't traverse tree constantly
func _process(delta):
    get_node("/root/GameManager").update()
    get_tree().get_root().get_node("UI").refresh()
```

### ❌ **God Object**
If GameManager does everything:
- UI updates
- Sound effects
- Physics
- Inventory
- Save/load
- Input handling

**Fix:** Split responsibilities into managers/systems

### ❌ **Update Everything Every Frame**
```gdscript
func _process(delta):
    update_ui()  # Only update when state changes!
```

**Fix:** Use signals (we're doing this!)

---

## Type Safety

### ✅ **Use Type Hints**
```gdscript
func calculate_progress(complexity: int, bugs: int) -> float:
    var multiplier: float = 1.0 + (bugs / 100.0)
    return 20.0 / (complexity * multiplier)
```

### ✅ **Typed Arrays**
```gdscript
var time_bombs: Array[Dictionary] = []
var tasks: Array[Task] = []
```

---

## Architecture for Phase 1

### GameManager Should Have:
- Core state variables (money, ducks, bugs, strikes, day, salary)
- State change signals
- High-level actions (do_work, hustle, debug, rest)
- Game flow (daily_updates, check_game_over)

### GameManager Should NOT Have:
- UI update logic (use signals)
- Detailed bug calculation (extract to function/system)
- Event text/content (load from JSON)
- Sound effects (would go in AudioManager)

### Example Split (if needed later):
```gdscript
# game_manager.gd (< 300 lines)
var bugs := 0
var time_bombs: Array[Dictionary] = []

func add_bugs(amount: int):
    bugs += amount
    bugs_changed.emit(bugs)

func get_bug_multiplier() -> float:
    return 1.0 + (bugs / BUG_SLOWDOWN_FACTOR)

func check_time_bombs():
    for bomb in time_bombs:
        if bomb.trigger_day == day:
            _trigger_outage(bomb)
```

If it grows too large, extract:
```gdscript
# scripts/systems/bug_system.gd
class_name BugSystem
static func calculate_multiplier(bugs: int) -> float:
    return 1.0 + (bugs / 100.0)
```

---

## Testing Approach

### Manual Testing Checklist
- [ ] Start game with 0 bugs - complexity 5 task takes ~5 work actions
- [ ] Add 40 bugs - same task takes ~7 work actions (40% slower)
- [ ] Ship task at 50% complete - adds 5 bugs
- [ ] Production outage triggers 2-5 days after rush ship
- [ ] Ducks reach 0 - game over triggers
- [ ] 3 strikes - fired game over triggers
- [ ] Reach $5000 - victory screen

---

## Phase 1 Implementation Guidelines

### Adding Bugs System
1. Add `bugs` variable to GameManager
2. Add `bugs_changed` signal
3. Emit signal when bugs change
4. Update UI to show bugs (🐛 icon)
5. Use bugs in progress calculation
6. Add debug action to reduce bugs

### Adding Time Bombs
1. Add `time_bombs: Array[Dictionary]` to GameManager
2. When rushing, append bomb with trigger_day
3. In `daily_updates()`, check for explosions
4. Trigger production_outage event
5. Apply penalties (money, bugs, strikes)

### Adding Complexity
1. Ensure Task.complexity is set from JSON
2. Update `do_work()` to use complexity
3. Formula: `progress += 20 / (complexity * bug_multiplier)`
4. Test with different complexity values

### Adding Actions
1. Create enum `PlayerAction {WORK, HUSTLE, DEBUG, REST}`
2. Implement each action function
3. Each action should:
   - Update relevant stats
   - Emit appropriate signals
   - Advance day (except maybe REST?)
   - Trigger daily_updates()

---

## Quick Reference: Resource Costs

```gdscript
# Work
- progress += 20 / (complexity * bug_multiplier)
- money += salary
- day += 1

# Hustle
- progress += 0
- money += salary * 2
- ducks -= 1
- day += 1

# Debug
- progress += 0
- money += 0
- bugs -= 15
- day += 1

# Rest
- progress += 0
- money += 0
- ducks += 1
- day += 1

# Rush Ship
- progress = 100 (instant complete)
- bugs += (100 - progress) / 10
- ducks -= 2
- time_bomb created
- money += task_payment
```

---

## Writing Style Guide

Game text should be:
- **Dry, deadpan humor** - "Boss says: 'We're a family.'"
- **Specific tech references** - "blockchain todo app", not "the project"
- **Absurdist but grounded** - Ridiculous but recognizable
- **Dark without being mean** - Satirical, not cruel

Examples:
- ✅ "The printer is 'hacking us'"
- ✅ "CEO's nephew said the logo looks 'weak'"
- ❌ "Your boss is a big meanie!" (too silly)
- ❌ "You're worthless trash" (too mean)

---

## When to Refactor

### Red Flags:
- GameManager > 300 lines
- Any function > 50 lines
- Deep nesting (> 3 levels of if/for)
- Copy-pasted code (DRY principle)
- "God object" doing everything

### Green Lights:
- Single responsibility per class/function
- Functions < 20 lines (mostly)
- Clear, descriptive names
- Type hints everywhere
- Easy to test in isolation

---

## Implementation Priority

1. **Make it work** - Get feature functional
2. **Make it right** - Refactor for clarity
3. **Make it fast** - Optimize if needed (usually not needed for this game)

Don't prematurely optimize. Focus on clean, readable code first.

---

## Questions to Ask Before Adding Code

1. **Does this belong in GameManager?**
   - If > 20 lines of logic, consider extracting

2. **Am I hardcoding values?**
   - Extract to constants

3. **Am I updating UI directly?**
   - Use signals instead

4. **Can this be data-driven?**
   - Move to JSON if possible

5. **Is this testable?**
   - Can I verify it works without playing whole game?

---

## Godot-Specific Gotchas

### ⚠️ **Setter Order Matters**
```gdscript
var money := 0:
    set(value):
        money = value  # Must update before emit!
        money_changed.emit(money)
```

### ⚠️ **Signals Need Connection**
```gdscript
# Signal defined but never connected = silent failure
signal my_signal
my_signal.emit()  # Does nothing if no listeners
```

### ⚠️ **@onready Runs After _init()**
```gdscript
@onready var node = $SomeNode  # Available in _ready(), not _init()
```

### ⚠️ **Resource Instances Share Data**
```gdscript
# If loading same resource multiple times
var task1 = load("res://task.tres")
var task2 = load("res://task.tres")
task1.progress = 50
print(task2.progress)  # Also 50! Same instance!

# Fix: Use .duplicate()
var task2 = task1.duplicate()
```

---

## Final Checklist Before Committing

- [ ] No hardcoded magic numbers (use constants)
- [ ] All state changes emit signals
- [ ] Type hints on functions and variables
- [ ] No deep nesting (< 3 levels)
- [ ] Functions are focused (< 30 lines)
- [ ] Descriptive variable names (no `x`, `temp`, `data`)
- [ ] Comments explain WHY, not WHAT
- [ ] Tested manually in-game

---

This document is a living reference. Update as we learn more during implementation.
