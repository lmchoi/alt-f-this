# Godot Best Practices

Quick reference for Godot-specific patterns and architectural decisions.

---

## Core Principles

1. **Signals over direct calls** - Keep systems decoupled
2. **Resources for data, Nodes for behavior** - Task = Resource, TaskProcessor = Node
3. **Composition over inheritance** - Use scene components, not deep class hierarchies
4. **Event-driven updates** - Don't update every frame, react to signals
5. **Keep managers focused** - Split into systems when responsibilities grow

---

## Signal-Driven Architecture

### ✅ Property Setters with Signals
```gdscript
# In GameManager
var money := 0:
    set(value):
        money = value
        money_changed.emit(money)
```

### ✅ UI Components Listen to Signals
```gdscript
# In UI
func _ready():
    GameManager.money_changed.connect(_on_money_changed)

func _on_money_changed(new_amount: int):
    money_label.text = "$%d" % new_amount
```

### ✅ Unidirectional Data Flow
```
GameManager (source of truth)
     ↓ (signals)
UI Components (react to changes)
```

**UI should NEVER directly modify state:**
```gdscript
# ❌ Don't
GameManager.money = 100

# ✅ Do
GameManager.add_money(100)  # Function handles logic + signal
```

### ✅ Name Signals Clearly
```gdscript
signal money_changed(new_amount)     # Good - what changed
signal ducks_changed(new_amount)     # Good
signal production_outage(severity)   # Good - what happened

# Not: signal update()  # Bad - vague
```

---

## Node References & Performance

### ✅ Unique Node Names
```gdscript
@onready var day_label = $"%DayLabel"  # Finds anywhere in subtree
```

### ✅ Cache Node References
```gdscript
@onready var sprite = $Sprite2D  # Once on ready
```

### ❌ Don't Search Tree Every Frame
```gdscript
func _process(delta):
    $Sprite2D.position = ...  # Searches every frame - BAD
```

### ❌ Get Node Hell
```gdscript
# Don't traverse tree constantly
func _process(delta):
    get_node("/root/GameManager").update()
    get_tree().get_root().get_node("UI").refresh()
```

---

## Type Safety

### ✅ Use Type Hints
```gdscript
func calculate_progress(complexity: int, bugs: int) -> float:
    var multiplier: float = 1.0 + (bugs / 100.0)
    return 20.0 / (complexity * multiplier)
```

### ✅ Typed Arrays
```gdscript
var time_bombs: Array[Dictionary] = []
var tasks: Array[Task] = []
```

### ✅ Use Enums Over Strings
```gdscript
enum PlayerAction {WORK, HUSTLE, SHIP_IT}

match action:
    PlayerAction.WORK: do_work()  # Fast

# Not: if action == "work": ...  # Slow string comparison
```

---

## Data Organization

### ✅ Resources for Data
```gdscript
class_name Task extends Resource  # Pure data, no behavior
```

### ✅ JSON for Content
```gdscript
# data/tasks.json - easy to balance without code changes
```

**Benefits:**
- Easy to balance (tweak numbers without code)
- Non-programmers can add content
- Version control friendly (see what changed)

### ✅ Extract Constants
```gdscript
# In game_manager.gd or separate constants file
const ESCAPE_GOAL := 5000
const BASE_PROGRESS := 20
const STARTING_DUCKS := 3
const BUG_SLOWDOWN_FACTOR := 100.0
```

### ❌ Don't Hardcode
```gdscript
if money >= 5000:  # What's 5000? Why 5000?
```

---

## Autoloads

### ✅ Good Autoload Candidates
- GameManager (game state)
- TaskManager (task data)
- EventBus (global events)
- AudioManager (sound)
- SaveManager (persistence)

### ❌ Don't Autoload
- UI elements (should be in scene tree)
- Player/entities (should be instanced)
- Anything that needs multiple instances

---

## Scene Organization

### ✅ Self-Contained Components
Each scene should:
- Have its own script
- Emit signals for external communication
- Not assume parent structure
- Be testable in isolation

### ✅ Scenes for Reusable Components
```
scenes/
├─ game_ui.tscn              # Main game screen
├─ components/
│  ├─ top_bar.tscn
│  ├─ task_panel.tscn
│  └─ job_info.tscn
└─ dialogs/
   ├─ outage_dialog.tscn
   └─ event_dialog.tscn
```

---

## Anti-Patterns to Avoid

### ❌ God Object
If GameManager does everything:
- UI updates
- Sound effects
- Physics
- Inventory
- Save/load
- Input handling

**Fix:** Split responsibilities into managers/systems

### ❌ Update Everything Every Frame
```gdscript
func _process(delta):
    update_ui()  # Only update when state changes!
```

**Fix:** Use signals (event-driven updates)

---

## Godot-Specific Gotchas

### ⚠️ UID Collisions (Critical!)
```bash
# Godot auto-generates .uid files for ALL resources (.gd, .tscn, .gdshader, etc.)
# IMPORTANT: Always commit .uid files to version control!

# UID collision happens when .gd and .tscn accidentally get the SAME UID
# This can happen during file operations or scene creation

# ❌ Bad - causes "No loader found for resource" errors
scenes/my_popup.gd          uid://abc123
scenes/my_popup.gd.uid      uid://abc123  # Same UID!
scenes/my_popup.tscn        uid://abc123  # COLLISION!

# ✅ Good - each file has unique UID
scenes/my_popup.gd          uid://abc123
scenes/my_popup.gd.uid      uid://abc123
scenes/my_popup.tscn        uid://def456  # Different UID
```

**Fix UID collisions when they occur:**
```bash
# 1. Clear Godot cache to force regeneration
rm -rf .godot

# 2. Reopen project - Godot will regenerate unique UIDs
godot --headless --editor --quit

# 3. Commit the regenerated .uid files
git add **/*.uid
git commit -m "Fix UID collisions"
```

**Important:**
- **DO commit** `.uid` files to version control
- **DO NOT** add `*.uid` to `.gitignore`
- Without committed `.uid` files, clones will break references

### ⚠️ NEVER Manually Create .uid Files
```bash
# ❌ WRONG - manually creating .uid files causes collisions
# When using Write tool to create both .gd and .tscn:
Write("popup.gd", "extends PopupPanel...")
Write("popup.tscn", "[gd_scene uid='uid://abc123']...")
Write("popup.gd.uid", "uid://abc123")  # ← COLLISION!

# ✅ RIGHT - let Godot generate .uid files
Write("popup.gd", "extends PopupPanel...")
Write("popup.tscn", "[gd_scene uid='uid://abc123']...")
# DON'T create .gd.uid manually!
# Run: godot --headless --editor --quit
# Godot generates popup.gd.uid with unique UID
# Then commit the generated .uid file
```

**Workflow:**
1. Use Write tool for `.gd` and `.tscn` files only
2. Run `godot --headless --editor --quit` to generate `.uid` files
3. Commit all generated `.uid` files

### ⚠️ Setter Order Matters
```gdscript
var money := 0:
    set(value):
        money = value  # Must update before emit!
        money_changed.emit(money)
```

### ⚠️ Signals Need Connection
```gdscript
# Signal defined but never connected = silent failure
signal my_signal
my_signal.emit()  # Does nothing if no listeners
```

### ⚠️ @onready Runs After _init()
```gdscript
@onready var node = $SomeNode  # Available in _ready(), not _init()
```

### ⚠️ Resource Instances Share Data
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

## UI Best Practices

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

## Code Quality Checklist

### Before Committing:
- [ ] No hardcoded magic numbers (use constants)
- [ ] All state changes emit signals
- [ ] Type hints on functions and variables
- [ ] No deep nesting (< 3 levels)
- [ ] Functions are focused (< 30 lines)
- [ ] Descriptive variable names (no `x`, `temp`, `data`)
- [ ] Comments explain WHY, not WHAT
- [ ] Tested manually in-game

### When to Refactor:
- Any manager > 300 lines
- Any function > 50 lines
- Deep nesting (> 3 levels of if/for)
- Copy-pasted code (DRY principle)
- "God object" doing everything

---

## Implementation Priority

1. **Make it work** - Get feature functional
2. **Make it right** - Refactor for clarity
3. **Make it fast** - Optimize if needed (usually not needed)

Don't prematurely optimize. Focus on clean, readable code first.

---

## Questions Before Adding Code

1. **Does this belong in this manager?** - If > 20 lines of logic, consider extracting
2. **Am I hardcoding values?** - Extract to constants
3. **Am I updating UI directly?** - Use signals instead
4. **Can this be data-driven?** - Move to JSON if possible
5. **Is this testable?** - Can I verify it works without playing whole game?
