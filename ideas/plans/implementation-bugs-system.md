# Implementation Plan: Bugs System

**Goal:** Add bugs system to GameManager with UI indicator showing bug count

---

## Overview

The bugs system creates a death spiral mechanic:
1. Rush incomplete tasks → accumulate bugs
2. Bugs slow down ALL future work
3. Forces player to either debug (lose time) or keep rushing (more bugs)
4. Eventually becomes impossible without debugging

---

## Step-by-Step Implementation

### Step 1: Add Bugs to GameManager State

**File:** `autoloads/game_manager.gd`

**Changes:**
```gdscript
# Add new state variable with signal
var bugs := 0:
    set(value):
        bugs = value
        bugs_changed.emit(bugs)

# Add new signal at top of file (around line 10)
signal bugs_changed(amount)
```

**Why:** Follows existing pattern (money, ducks, etc.). Signal enables reactive UI.

---

### Step 2: Add Bug Accumulation Logic

**File:** `autoloads/game_manager.gd`

**Add constant at top:**
```gdscript
const BUG_SLOWDOWN_FACTOR := 100.0  # bugs / 100 = slowdown %
```

**Add helper function:**
```gdscript
func get_bug_multiplier() -> float:
    """Returns slowdown multiplier based on current bugs.
    0 bugs = 1.0x (no slowdown)
    40 bugs = 1.4x (40% slower)
    80 bugs = 1.8x (80% slower)
    """
    return 1.0 + (bugs / BUG_SLOWDOWN_FACTOR)

func add_bugs(amount: int) -> void:
    """Add bugs from rushing or other sources."""
    bugs += amount
    print("Bugs added: +%d (total: %d)" % [amount, bugs])
```

**Why:** Encapsulates bug logic, easy to balance by tweaking constant.

---

### Step 3: Update Task Progress Calculation

**File:** `scripts/resources/task.gd`

**Current code (WRONG):**
```gdscript
func do_work():
    progress += 20  # Ignores complexity and bugs!
```

**New code (CORRECT):**
```gdscript
func do_work(complexity_multiplier: float = 1.0) -> int:
    """Perform work on task, returns actual progress gained.

    Args:
        complexity_multiplier: Slowdown from bugs/complexity

    Returns:
        Actual progress points gained
    """
    const BASE_PROGRESS := 20
    var actual_progress = BASE_PROGRESS / complexity_multiplier
    progress = min(progress + actual_progress, 100)  # Cap at 100
    return actual_progress
```

**Why:** Task shouldn't know about bugs/complexity - that's GameManager's job.

---

### Step 4: Update GameManager Work Action

**File:** `autoloads/game_manager.gd`

**Find `do_work()` function (around line 67), update to:**
```gdscript
func do_work():
    print('work')

    # Calculate combined multiplier (complexity * bugs)
    var bug_multiplier = get_bug_multiplier()
    var total_multiplier = current_task.complexity * bug_multiplier

    # Perform work with slowdown applied
    var progress_gained = current_task.do_work(total_multiplier)

    print("Progress: +%.1f%% (complexity: %d, bugs: %d, multiplier: %.2fx)" % [
        progress_gained,
        current_task.complexity,
        bugs,
        total_multiplier
    ])

    # Update player state
    money += salary

    # Advance day
    day += 1
```

**Why:** Now work respects both task complexity and bug slowdown.

---

### Step 5: Add Debug Action

**File:** `autoloads/game_manager.gd`

**Add new function:**
```gdscript
func debug() -> void:
    """Spend day debugging legacy code. Reduces bugs but no progress/money."""
    print('debug')

    const DEBUG_AMOUNT := 15
    var bugs_removed = min(DEBUG_AMOUNT, bugs)
    bugs -= bugs_removed

    print("Debugging: -%d bugs (remaining: %d)" % [bugs_removed, bugs])

    # No money or progress, but time passes
    day += 1
```

**Why:** Gives player tool to manage bugs, creates strategic choice.

---

### Step 6: Add Rush Ship Functionality

**File:** `autoloads/game_manager.gd`

**Add new function:**
```gdscript
func rush_ship_task() -> void:
    """Ship task incomplete, adds bugs based on how incomplete it was."""
    var completion_percent = current_task.progress
    var bugs_added = int((100 - completion_percent) / 10.0)

    print("Rush shipping at %d%% complete" % completion_percent)

    # Add bugs
    add_bugs(bugs_added)

    # Complete the task
    current_task.progress = 100
    work_completed.emit()

    # Get paid
    money += 100  # TODO: base on task complexity

    # Lose ducks (guilt)
    ducks -= 2

    # Get new task
    current_task = TaskManager.get_random_task(day)

    # Day advances
    day += 1
```

**Why:** Creates tempting but dangerous shortcut - core to death spiral mechanic.

---

### Step 7: Update Deadline Dialog

**File:** `scenes/deadline_dialog.gd`

**Current code:**
```gdscript
add_button("Beg for Mercy", false, "mercy")
add_button("Duck It!", false, "duck_it")
```

**New code:**
```gdscript
func _ready():
    title = "Deadline Reached!"

    # Check if task is shippable
    var progress = GameManager.current_task.progress

    if progress >= 50:
        dialog_text = "Deadline is TODAY! (Task at %d%%)\nWhat do you do?" % progress
        add_button("Rush Ship It", false, "rush_ship")
    else:
        dialog_text = "Deadline is TODAY! (Task only %d%% done)\nNot enough to ship!" % progress

    add_button("Beg Extension", false, "extension")
    add_button("Accept Failure", false, "fail")

    get_ok_button().hide()
```

**Why:** Gives player the rush ship option that creates bugs.

---

### Step 8: Update Process Action Handler

**File:** `autoloads/game_manager.gd`

**Find `process_action()` (around line 90), update to:**
```gdscript
func process_action(action: String):
    match action:
        "rush_ship":
            rush_ship_task()
            print("Rush shipped - bugs added!")
        "extension":
            salary -= 100
            money -= 100  # Immediate penalty
            current_task.due_day += 3
            ducks -= 1  # Begging is humiliating
            print("Extension granted: +3 days, -$100, -1 duck")
        "fail":
            ducks -= 1
            current_task = TaskManager.get_random_task(day)
            print("Failed task, got new one")
```

**Why:** Connects UI choices to game systems.

---

### Step 9: Add Bugs UI Indicator

**File:** `scenes/game_ui.gd`

**Add @onready reference (around line 8):**
```gdscript
@onready var bugs_label := $"%BugsLabel"
```

**Add signal connection in `_ready()` (around line 24):**
```gdscript
GameManager.bugs_changed.connect(_update_bugs_label)
```

**Add update function:**
```gdscript
func _update_bugs_label(new_amount: int):
    bugs_label.text = "🐛 " + str(new_amount)

    # Optional: Change color based on severity
    if new_amount >= 80:
        bugs_label.add_theme_color_override("font_color", Color.RED)
    elif new_amount >= 40:
        bugs_label.add_theme_color_override("font_color", Color.ORANGE)
    else:
        bugs_label.add_theme_color_override("font_color", Color.WHITE)
```

**Why:** Visual feedback for bug accumulation, color coding adds tension.

---

### Step 10: Add Bugs Label to UI Scene

**File:** `scenes/game_ui.tscn` (edit in Godot Editor)

**Steps:**
1. Open `scenes/game_ui.tscn` in Godot
2. Find the top stats panel (where Day/Money/Ducks are shown)
3. Add a new Label node
4. Set its properties:
   - Name: `BugsLabel`
   - Text: `🐛 0`
   - Mark as "Access as Unique Name" (%)
5. Position it next to the ducks display
6. Set font size to match other stats
7. Save scene

**Why:** Adds visual indicator in the UI.

---

### Step 11: Add Debug Button to UI

**File:** `scenes/game_ui.tscn` (edit in Godot Editor)

**Steps:**
1. Find the action buttons (Work, Hustle)
2. Duplicate one of them
3. Rename to `DebugButton`
4. Change text to "Debug" or "🐛 Debug"
5. Make it unique name if needed

**File:** `scenes/game_ui.gd`

**Add reference and connection:**
```gdscript
@onready var debug_button := $"%DebugButton" as ActionButton

func _ready():
    # ... existing connections ...
    debug_button.pressed.connect(_on_debug_button_pressed)

func _on_debug_button_pressed():
    GameManager.debug()
```

**Why:** Gives player access to debug action.

---

### Step 12: Initialize Bugs on Game Start

**File:** `autoloads/game_manager.gd`

**Update `start_game()` (around line 45):**
```gdscript
func start_game():
    # Reset all state
    day = 1
    money = 0
    salary = 100
    ducks = 3  # Start with 3 ducks
    bugs = 0   # Start with 0 bugs

    current_task = TaskManager.get_random_task()
```

**Why:** Ensures clean state on game start.

---

## Testing Checklist

After implementation, test these scenarios:

### Test 1: Bugs Slow Work
- [ ] Start game (0 bugs)
- [ ] Work on complexity 5 task
- [ ] Should take ~5 work actions (100 / 20 = 5)
- [ ] Note: takes exactly 5 actions

### Test 2: Bug Accumulation
- [ ] Rush ship a task at 50% complete
- [ ] Should add 5 bugs (100 - 50) / 10 = 5
- [ ] UI should show "🐛 5"
- [ ] Console should print bug count

### Test 3: Bug Slowdown
- [ ] With 40 bugs, work on complexity 5 task
- [ ] Progress per work = 20 / (5 * 1.4) = ~2.86%
- [ ] Should take ~35 work actions to complete (not 5!)
- [ ] This is the death spiral

### Test 4: Debugging
- [ ] Have 40 bugs
- [ ] Press Debug button
- [ ] Bugs should reduce by 15 → 25 remaining
- [ ] No money gained
- [ ] Day advances
- [ ] UI updates to "🐛 25"

### Test 5: Bug Indicator Colors
- [ ] At 0-39 bugs → white text
- [ ] At 40-79 bugs → orange text
- [ ] At 80+ bugs → red text (panic!)

---

## Expected Behavior

### Math Examples

**With 0 bugs, complexity 5 task:**
```
Multiplier = 5 * 1.0 = 5.0
Progress per work = 20 / 5.0 = 4%
Actions to complete = 100 / 4 = 25 actions
```

**With 40 bugs, complexity 5 task:**
```
Bug multiplier = 1.0 + (40 / 100) = 1.4
Total multiplier = 5 * 1.4 = 7.0
Progress per work = 20 / 7.0 = 2.86%
Actions to complete = 100 / 2.86 = 35 actions  (40% slower!)
```

**With 80 bugs, complexity 5 task:**
```
Bug multiplier = 1.0 + (80 / 100) = 1.8
Total multiplier = 5 * 1.8 = 9.0
Progress per work = 20 / 9.0 = 2.22%
Actions to complete = 100 / 2.22 = 45 actions  (80% slower!)
```

---

## Success Criteria

✅ Bugs system is complete when:
1. Bug count displays in UI with 🐛 emoji
2. Bug color changes at thresholds (40, 80)
3. Bugs slow down work progress visibly
4. Rush shipping incomplete tasks adds bugs
5. Debug action reduces bugs
6. Console prints helpful debug info
7. All 5 test scenarios pass

---

## Potential Issues & Solutions

### Issue 1: Division by Zero
**Problem:** `20 / (complexity * bug_multiplier)` if complexity is 0
**Solution:** Task complexity should be 1-10 (enforced in JSON)

### Issue 2: Progress > 100
**Problem:** Progress could exceed 100%
**Solution:** Use `min(progress + amount, 100)` in task.gd

### Issue 3: Negative Bugs
**Problem:** Debugging could make bugs < 0
**Solution:** Use `bugs = max(0, bugs - amount)`

### Issue 4: UI Not Updating
**Problem:** Bug label doesn't update
**Solution:** Check signal is connected in _ready(), check unique name %

---

## File Summary

**Files to Modify:**
1. `autoloads/game_manager.gd` - Add bugs state, logic, actions
2. `scripts/resources/task.gd` - Update do_work() to accept multiplier
3. `scenes/game_ui.gd` - Add bugs label connection and update function
4. `scenes/game_ui.tscn` - Add bugs label and debug button (in editor)
5. `scenes/deadline_dialog.gd` - Add rush ship option

**No new files needed** - everything integrates into existing architecture.

---

## Implementation Order

1. ✅ Add bugs variable to GameManager (Step 1)
2. ✅ Add helper functions (Step 2)
3. ✅ Update task.gd (Step 3)
4. ✅ Update do_work() (Step 4)
5. ✅ Add debug() action (Step 5)
6. ✅ Add rush_ship_task() (Step 6)
7. ✅ Update UI script (Step 9)
8. ✅ Add UI elements in Godot (Step 10, 11)
9. ✅ Update deadline dialog (Step 7, 8)
10. ✅ Test everything (Step 12)

**Estimated time:** 1-2 hours for implementation + testing

---

Ready to start? We can go step-by-step, or I can implement multiple steps at once.
