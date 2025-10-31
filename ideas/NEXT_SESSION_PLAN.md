# Next Session Plan - Task Switcher Implementation

**Context:** We've completed Phase 1 of mobile-first redesign. TaskPanelV2 is integrated and working. Now implementing unified task panel with tabs to switch between JOB and ESCAPE tasks.

---

## What We Just Completed

### ✅ Phase 1: TaskPanelV2 (Mobile-First)
**Status:** Complete and integrated into game

**Files created:**
- `scenes/task_panel_v2.tscn` - Mobile-optimized task panel
- `scenes/task_panel_v2.gd` - Script with job task display logic
- `scenes/task_panel_v2_demo.tscn` - Demo scene for testing

**What works:**
- 100px tall progress bar (was 60px)
- 48px progress percentage (huge, readable)
- 60px tall WORK/SHIP IT buttons (mobile-friendly)
- Color-coded quality zones (red → orange → yellow → green)
- Category badges (CRITICAL, OPTICS, etc.)
- Progress updates correctly when working
- Connects to GameManager signals
- Integrated into main game (`game_ui.tscn`)

**Last commits:**
- `cbac5ae` - Add category badges and remove bug label
- `a576915` - Fix: Connect to task's progress_changed signal
- `767f642` - Wire up TaskPanelV2 work_pressed signal
- `8842ed1` - Swap TaskPanel → TaskPanelV2 in main game UI

---

## Next Task: Unified Task Panel with Tabs

### Goal
One TaskPanelV2 that can show **either** JOB tasks or ESCAPE plan, with tabs to switch between them.

### Design Decisions (Confirmed)
1. **Tab style:** Option A - `[💼 JOB] [🚀 ESCAPE]` buttons at top
   - Open to adding swipe gestures later (Option C for mobile)
2. **Visual distinction:** Gold border/theme when showing ESCAPE (vs. gray for JOB)
3. **Buttons:** WORK/SHIP IT for JOB, HUSTLE only for ESCAPE
4. **Task queue:** Deferred - Not implementing interruption task queue yet

### Reference Doc
See **[ideas/task-switcher-implementation.md](task-switcher-implementation.md)** for complete implementation plan.

---

## Implementation Steps (Next Session)

### Step 1: Add Tab Buttons (30 mins)
**File:** `scenes/task_panel_v2.tscn`

Add at top of VBoxContainer:
```
TabBar (HBoxContainer)
├─ JobTab (Button) - "💼 JOB"
└─ EscapeTab (Button) - "🚀 ESCAPE"
```

**Specs:**
- Height: 40px each
- Font: 22px
- Side-by-side, equal width
- Active tab: Highlighted border
- Inactive tab: Dimmed

**Test:** Open scene, verify tabs appear

---

### Step 2: Add Task Type Enum (15 mins)
**File:** `scenes/task_panel_v2.gd`

```gdscript
enum TaskType {
	JOB,     # Corporate work task
	ESCAPE   # Side project / escape plan
}

var current_task_type := TaskType.JOB

func _on_job_tab_pressed() -> void:
	current_task_type = TaskType.JOB
	_update_display()

func _on_escape_tab_pressed() -> void:
	current_task_type = TaskType.ESCAPE
	_update_display()
```

**Test:** Click tabs, print current_task_type

---

### Step 3: Add HUSTLE Button (15 mins)
**File:** `scenes/task_panel_v2.tscn`

Add to ActionButtons HBoxContainer:
```
ActionButtons
├─ WorkButton (existing)
├─ ShipItButton (existing)
└─ HustleButton (new) - "⚙️ HUSTLE", 60px tall
```

**File:** `scenes/task_panel_v2.gd`
```gdscript
signal hustle_pressed

@onready var hustle_button := $MarginContainer/VBoxContainer/ActionButtons/HustleButton as Button

func _ready() -> void:
	hustle_button.pressed.connect(_on_hustle_pressed)

func _on_hustle_pressed() -> void:
	hustle_pressed.emit()

func _update_button_visibility(task_type: TaskType) -> void:
	work_button.visible = (task_type == TaskType.JOB)
	ship_it_button.visible = (task_type == TaskType.JOB)
	hustle_button.visible = (task_type == TaskType.ESCAPE)
```

**Test:** Switch tabs, verify buttons show/hide

---

### Step 4: Split Display Logic (30 mins)
**File:** `scenes/task_panel_v2.gd`

Refactor `_update_display()`:
```gdscript
func _update_display() -> void:
	if current_task_type == TaskType.JOB:
		_show_job_task()
	else:
		_show_escape_task()
	_update_button_visibility(current_task_type)

func _show_job_task() -> void:
	var task = GameManager.current_task
	if not task:
		return

	# Existing job task display logic
	task_title.text = task.title
	# ... (current code)

func _show_escape_task() -> void:
	var escape = GameManager.side_project

	# Title
	task_title.text = "Side Project"

	# Metadata
	due_label.text = "Goal: $5K"
	complexity_label.visible = false

	# Clear badges
	_update_category_badges([])

	# Progress
	progress_bar.value = escape.progress
	progress_percent.text = "%d%%" % int(escape.progress)
	quality_label.text = "$%d / $%d" % [GameManager.money, GameManager.VICTORY_MONEY_GOAL]

	# Color based on escape progress
	_update_progress_bar_color(escape.progress)
```

**Test:** Switch tabs, verify correct data shows

---

### Step 5: Add Gold Theme (20 mins)
**File:** `scenes/task_panel_v2.tscn`

Create new SubResource StyleBox:
```
[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_escape_theme"]
bg_color = Color(0.12, 0.12, 0.15, 1)
border_width_left = 3
border_width_top = 3
border_width_right = 3
border_width_bottom = 3
border_color = Color(0.9, 0.75, 0.3, 1)  # Gold!
corner_radius_top_left = 6
corner_radius_top_right = 6
corner_radius_bottom_right = 6
corner_radius_bottom_left = 6
shadow_color = Color(0.9, 0.75, 0.3, 0.2)
shadow_size = 6
```

**File:** `scenes/task_panel_v2.gd`
```gdscript
@onready var job_theme_style: StyleBox  # Store reference to default
@onready var escape_theme_style: StyleBox  # Load gold theme

func _ready() -> void:
	# Store default job theme
	job_theme_style = get_theme_stylebox("panel")
	# Load escape theme from scene resources

func _apply_theme(task_type: TaskType) -> void:
	if task_type == TaskType.JOB:
		add_theme_stylebox_override("panel", job_theme_style)
	else:
		add_theme_stylebox_override("panel", escape_theme_style)
```

**Test:** Switch tabs, verify border changes gray ↔ gold

---

### Step 6: Wire Up HUSTLE Signal (10 mins)
**File:** `scenes/game_ui.gd`

```gdscript
func _ready():
	# ... existing code ...
	task_panel.hustle_pressed.connect(_on_slack_button_pressed)  # Reuse handler
```

**Test:** Click HUSTLE, verify side project progress increases

---

### Step 7: Connect Escape Progress Updates (15 mins)
**File:** `scenes/task_panel_v2.gd`

Listen to side_project updates:
```gdscript
func _ready() -> void:
	# ... existing code ...
	GameManager.side_project_updated.connect(_on_side_project_updated)

func _on_side_project_updated(_side_project_data: Dictionary) -> void:
	if current_task_type == TaskType.ESCAPE:
		_update_display()
```

**Test:** Click HUSTLE, verify ESCAPE tab updates

---

## Testing Checklist

After all steps complete:

### Visual
- [ ] Tabs appear at top of panel
- [ ] Active tab is highlighted
- [ ] JOB tab shows gray border
- [ ] ESCAPE tab shows gold border
- [ ] Gold border has subtle glow

### Functional (JOB Tab)
- [ ] Shows task title + badges
- [ ] Shows due date + complexity
- [ ] Shows WORK + SHIP IT buttons
- [ ] WORK increases progress
- [ ] SHIP IT completes task

### Functional (ESCAPE Tab)
- [ ] Shows "Side Project"
- [ ] Shows money progress ($X / $5K)
- [ ] Shows HUSTLE button only
- [ ] HUSTLE increases escape progress
- [ ] Progress bar updates

### Switching
- [ ] Click ESCAPE → switches view
- [ ] Click JOB → switches back
- [ ] Theme changes correctly
- [ ] Buttons show/hide correctly
- [ ] No errors when switching

---

## Files to Modify

1. `scenes/task_panel_v2.tscn` - Add tabs, HUSTLE button, escape theme
2. `scenes/task_panel_v2.gd` - Tab logic, theme switching, escape display
3. `scenes/game_ui.gd` - Wire up hustle_pressed signal

---

## Current State of Codebase

### Key Files
- **Main game UI:** `scenes/game_ui.tscn` (uses TaskPanelV2)
- **Game logic:** `autoloads/game_manager.gd` (handles state)
- **Task data:** `scripts/resources/task.gd` (Task class)
- **Side project:** GameManager.side_project (Dictionary with progress)

### Important Properties
- `GameManager.current_task` - Current job task (Task object)
- `GameManager.side_project` - Escape plan (Dictionary with progress, name)
- `GameManager.money` - Current money
- `GameManager.VICTORY_MONEY_GOAL` - $5000

### Existing Signals
- `GameManager.current_task_updated` - When job task changes
- `GameManager.side_project_updated` - When escape progress changes
- `Task.progress_changed` - When task progress updates

---

## Quick Start Commands (Next Session)

1. **Open Godot project**
2. **Read this file** to refresh context
3. **Start with Step 1** - Add tab buttons to scene
4. **Test incrementally** - Run game after each step
5. **Commit frequently** - Small commits for each step

---

## Questions to Resolve (If Any Come Up)

1. **Tab visual style:** Should active tab have different background color or just border?
2. **HUSTLE button size:** Full width or same size as WORK/SHIP IT?
3. **Escape progress color:** Use same quality zones or different gradient (money-based)?
4. **Tab icon size:** Keep emojis or use icon sprites?

---

## Success Criteria

Session complete when:
- ✅ Can switch between JOB and ESCAPE tabs
- ✅ JOB tab shows job task with WORK/SHIP IT
- ✅ ESCAPE tab shows side project with HUSTLE
- ✅ Gold border appears for ESCAPE
- ✅ All buttons work correctly
- ✅ No errors or visual glitches

Estimated time: **2-2.5 hours** for all 7 steps.

---

## After This Session

### Next Features (Future)
1. **Juice improvements** - Animated progress, button feedback
2. **Status panels v2** - Compress job info + escape panels (or remove if tabs handle it)
3. **Task queue** - When interruptions add tasks
4. **Swipe gestures** - Mobile polish for tab switching

### Mobile Export
- Test on real Android device
- Verify button sizes work with actual thumbs
- Export APK for playtesting

Good luck! 🚀
