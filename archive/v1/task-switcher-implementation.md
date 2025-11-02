# Task Switcher Implementation Plan

Unified TaskPanelV2 with tabs to switch between JOB and ESCAPE tasks.

---

## Design

### Visual Structure
```
┌─────────────────────────────────────────┐
│ [💼 JOB] [🚀 ESCAPE]          ← Tabs   │
├─────────────────────────────────────────┤
│ Update Slack Status        [CRITICAL]   │
│ Due: 2d  |  🍝🍝                         │
│        ████████████░░░░░░░              │
│              41%                        │
│ [    WORK    ] [   SHIP IT   ]          │
└─────────────────────────────────────────┘
```

### When ESCAPE Tab Active
```
┌─────────────────────────────────────────┐
│ [💼 JOB] [🚀 ESCAPE]          ← Gold!  │
├─────────────────────────────────────────┤
│ Side Project: Todo App                  │
│ $750 / $5,000 (15%)                     │
│        ████░░░░░░░░░░░░                 │
│              15%                        │
│ [      HUSTLE      ]                    │ ← Single button
└─────────────────────────────────────────┘
```

---

## Implementation Steps

### Step 1: Add Tab Container
**File:** `scenes/task_panel_v2.tscn`

Add tabs at top of VBoxContainer:
```
VBoxContainer
├─ TabContainer (new)
│  ├─ JobTab (Button)
│  └─ EscapeTab (Button)
├─ HeaderRow (task title + badges)
├─ MetadataRow
├─ ProgressSection
└─ ActionButtons
```

**Tab specs:**
- Height: 40px
- Font: 22px
- Full width HBoxContainer
- Active tab: Highlighted
- Inactive tab: Dimmed

---

### Step 2: Add Task Type Enum
**File:** `scenes/task_panel_v2.gd`

```gdscript
enum TaskType {
	JOB,     # Corporate work task
	ESCAPE   # Side project / escape plan
}

var current_task_type := TaskType.JOB
```

---

### Step 3: Conditional Display Logic
**File:** `scenes/task_panel_v2.gd`

```gdscript
func _update_display() -> void:
	if current_task_type == TaskType.JOB:
		_show_job_task()
	else:
		_show_escape_task()

func _show_job_task() -> void:
	var task = GameManager.current_task
	# Show: title, badges, due date, complexity
	# Show: WORK + SHIP IT buttons
	# Apply: Gray border theme

func _show_escape_task() -> void:
	var escape = GameManager.side_project
	# Show: side project title
	# Show: money progress ($X / $5K)
	# Show: HUSTLE button only
	# Apply: Gold border theme
```

---

### Step 4: Theme Switching
**File:** `scenes/task_panel_v2.gd`

Create two StyleBoxFlat variants:
1. **Job theme** (gray border) - current default
2. **Escape theme** (gold border)

```gdscript
func _apply_theme(task_type: TaskType) -> void:
	if task_type == TaskType.JOB:
		# Apply gray border StyleBox
		theme_override_styles/panel = job_theme_style
	else:
		# Apply gold border StyleBox
		theme_override_styles/panel = escape_theme_style
```

---

### Step 5: Button Visibility
**File:** `scenes/task_panel_v2.tscn` + `.gd`

Add all buttons, show/hide based on task type:
```
ActionButtons (HBoxContainer)
├─ WorkButton (visible when TaskType.JOB)
├─ ShipItButton (visible when TaskType.JOB)
└─ HustleButton (visible when TaskType.ESCAPE, full width)
```

```gdscript
func _update_button_visibility(task_type: TaskType) -> void:
	work_button.visible = (task_type == TaskType.JOB)
	ship_it_button.visible = (task_type == TaskType.JOB)
	hustle_button.visible = (task_type == TaskType.ESCAPE)
```

---

### Step 6: Tab Click Handlers
**File:** `scenes/task_panel_v2.gd`

```gdscript
func _on_job_tab_pressed() -> void:
	current_task_type = TaskType.JOB
	_update_display()
	_apply_theme(TaskType.JOB)
	_update_button_visibility(TaskType.JOB)

func _on_escape_tab_pressed() -> void:
	current_task_type = TaskType.ESCAPE
	_update_display()
	_apply_theme(TaskType.ESCAPE)
	_update_button_visibility(TaskType.ESCAPE)
```

---

### Step 7: Escape Task Data Display
**File:** `scenes/task_panel_v2.gd`

```gdscript
func _show_escape_task() -> void:
	var escape = GameManager.side_project

	# Title
	task_title.text = "Side Project: " + escape.name

	# Metadata row
	due_label.text = "Goal: $%d" % GameManager.VICTORY_MONEY_GOAL
	complexity_label.visible = false  # Not relevant for escape

	# No badges for escape
	_update_category_badges([])

	# Progress bar
	progress_bar.value = escape.progress
	progress_percent.text = "%d%%" % int(escape.progress)

	# Money progress as quality label
	quality_label.text = "$%d / $%d" % [GameManager.money, GameManager.VICTORY_MONEY_GOAL]

	# Color based on money progress
	var money_progress = (float(GameManager.money) / GameManager.VICTORY_MONEY_GOAL) * 100.0
	_update_progress_bar_color(money_progress)
```

---

## Signals

### New Signal
```gdscript
signal hustle_pressed  # Emitted when HUSTLE button clicked
```

### Wire Up in game_ui.gd
```gdscript
task_panel.hustle_pressed.connect(_on_slack_button_pressed)  # Reuse existing handler
```

---

## Theme Files

### Create Escape Theme StyleBox
**File:** `scenes/task_panel_v2.tscn` (inline SubResource)

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
shadow_color = Color(0.9, 0.75, 0.3, 0.2)  # Gold glow
shadow_size = 6
shadow_offset = Vector2(0, 2)
```

---

## Testing Checklist

After implementation:

### Visual Tests
- [ ] Tabs are visible and tappable (40px tall)
- [ ] Active tab is highlighted
- [ ] JOB tab shows gray border
- [ ] ESCAPE tab shows gold border
- [ ] Gold border has subtle glow effect

### Functional Tests (JOB Tab)
- [ ] Shows current task title + badges
- [ ] Shows due date + complexity
- [ ] Shows WORK + SHIP IT buttons
- [ ] WORK button increases progress
- [ ] SHIP IT button completes task

### Functional Tests (ESCAPE Tab)
- [ ] Shows "Side Project: [name]"
- [ ] Shows money progress ($X / $5K)
- [ ] Shows HUSTLE button (full width)
- [ ] HUSTLE button triggers hustle action
- [ ] Progress bar shows escape progress

### Switching Tests
- [ ] Click ESCAPE tab → switches to escape view
- [ ] Click JOB tab → switches back to job view
- [ ] Theme changes correctly on switch
- [ ] Buttons change correctly on switch
- [ ] No errors when switching rapidly

---

## Future Enhancements (Deferred)

### Task Queue (When Interruptions Add Tasks)
- Add task count badge: `[💼 JOB (2)]` when multiple tasks
- Clicking tab opens task picker
- Dropdown or list to choose which task to work on

### Swipe Gestures (Mobile Polish)
- Swipe left/right to switch tabs
- Touch-friendly for mobile play

### Keyboard Shortcuts (Desktop)
- `1` = JOB tab
- `2` = ESCAPE tab
- Quick switching during timed mode

---

## Files to Modify

1. `scenes/task_panel_v2.tscn` - Add tabs, HUSTLE button
2. `scenes/task_panel_v2.gd` - Tab logic, theme switching, escape display
3. `scenes/game_ui.gd` - Wire up hustle_pressed signal

Total estimated time: **1-2 hours**
