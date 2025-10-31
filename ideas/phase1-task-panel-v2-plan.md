# Phase 1: TaskPanelV2 Implementation Plan

Mobile-first task panel with huge progress display and chunky buttons.

---

## Goals

1. **Create mobile-optimized task panel** that works great on phones
2. **Test in isolation** before integrating into main game
3. **Keep incremental** - small commits, testable at each step
4. **Maintain signals** - same API as v1 for easy swap

---

## Design Specs (Mobile-First)

### Visual Layout
```
┌─────────────────────────────────────────┐
│ Update Slack Status                     │ ← 28px
│ Due: 2d  |  🍝  |  🔧 15 bugs           │ ← 20px
│                                         │
│        ████████████░░░░░░░              │ ← 100px tall
│                                         │
│                 41%                     │ ← 48px (HUGE)
│             HALF-BAKED                  │ ← 24px
│                                         │
│ 🔴━━━┃🟠━━━━━┃🟡━━━━┃🟢━━━             │ ← Quality guide
│    20%    50%   90%                     │ ← 18px
│                                         │
│ ┌─────────────────┐ ┌─────────────────┐│
│ │                 │ │                 ││
│ │    WORK ⚙️      │ │   SHIP IT 🚢    ││ ← 60px tall
│ │                 │ │                 ││
│ └─────────────────┘ └─────────────────┘│
└─────────────────────────────────────────┘
```

### Size Requirements
- **Min width:** 360px (iPhone SE)
- **Max width:** 600px (will center on desktop)
- **Height:** ~400px total
- **Side padding:** 16px
- **Internal spacing:** 12px between sections

### Font Sizes (from theme or override)
- **Progress %:** 48px, bold, center-aligned
- **Quality label:** 24px, center-aligned (e.g., "HALF-BAKED")
- **Task title:** 28px, normal weight
- **Metadata:** 20px (due date, complexity, bugs)
- **Quality markers:** 18px (20%, 50%, 90% labels)
- **Button text:** 24px, bold

### Colors (from existing theme)
- **Theme file:** `themes/main_theme.tres`
- **Panel background:** Color(0.12, 0.12, 0.15, 1) with 3px border
- **Border color:** Color(0.6, 0.6, 0.65, 1) - light gray
- **Button border:** Color(0.9, 0.75, 0.3, 1) - gold/yellow
- **Button text:** Color(0.9, 0.75, 0.3, 1) - gold/yellow
- **Label text:** Color(0.75, 0.75, 0.8, 1) - light gray
- **Progress bar fill:** Color(0.6, 0.75, 0.85, 0.8) - blue-ish (v1)
  - **v2 will use quality-based colors:**
    - Red zone (0-20%): Color(1.0, 0.3, 0.3, 0.8)
    - Orange zone (20-50%): Color(1.0, 0.6, 0.2, 0.8)
    - Yellow zone (50-90%): Color(1.0, 0.9, 0.3, 0.8)
    - Green zone (90-100%): Color(0.3, 1.0, 0.3, 0.8)

---

## Implementation Steps (Incremental Commits)

### Commit 1: Scene Structure
**Create:** `scenes/task_panel_v2.tscn`

**Node tree:**
```
PanelContainer (task_panel_v2)
├─ theme: res://themes/main_theme.tres (inherit existing)
├─ custom_minimum_size: Vector2(360, 0)
└─ MarginContainer (margins: 16px all sides)
   └─ VBoxContainer (spacing: 12px)
      ├─ Label (name: TaskTitle)
      │  └─ Font size override: 28px
      ├─ HBoxContainer (name: MetadataRow, spacing: 8px)
      │  ├─ Label (name: DueLabel, text: "Due: 2d")
      │  ├─ Label (name: ComplexityLabel, text: "🍝🍝")
      │  └─ Label (name: BugLabel, text: "🔧 0")
      ├─ VBoxContainer (name: ProgressSection, spacing: 8px)
      │  ├─ ProgressBar (name: ProgressBar, custom_minimum_size: y=100)
      │  ├─ Label (name: ProgressPercent, font_size: 48px, align: center)
      │  ├─ Label (name: QualityLabel, font_size: 24px, align: center)
      │  └─ HBoxContainer (name: QualityGuide, separation: 16px)
      │     ├─ Label (text: "🔴 20%", font_size: 18px)
      │     ├─ Label (text: "🟠 50%", font_size: 18px)
      │     ├─ Label (text: "🟡 90%", font_size: 18px)
      │     └─ Label (text: "🟢", font_size: 18px)
      └─ HBoxContainer (name: ActionButtons, spacing: 12px)
         ├─ Button (name: WorkButton, script: ActionButton)
         │  ├─ custom_minimum_size: Vector2(0, 60)
         │  ├─ size_flags_horizontal: FILL + EXPAND
         │  ├─ text: "⚙️ WORK"
         │  └─ font_size override: 24px
         └─ Button (name: ShipItButton, script: ActionButton)
            ├─ custom_minimum_size: Vector2(0, 60)
            ├─ size_flags_horizontal: FILL + EXPAND
            ├─ text: "🚢 SHIP IT"
            └─ font_size override: 24px
```

**Styling notes:**
- Use existing `main_theme.tres` as base
- Panel will inherit StyleBoxFlat_task_panel style (dark bg, gray border)
- Buttons will inherit theme's gold border + text colors
- Labels inherit light gray text color

**Test:** Open scene, verify layout structure matches existing style
**Commit message:** "Create TaskPanelV2 scene structure (mobile-first)"

---

### Commit 2: Basic Script + Signals
**Create:** `scenes/task_panel_v2.gd`

```gdscript
extends PanelContainer

# Signals (same as v1 for compatibility)
signal work_pressed
signal ship_it_pressed

# Node references
@onready var task_title := $MarginContainer/VBoxContainer/TaskTitle
@onready var due_label := $MarginContainer/VBoxContainer/MetadataRow/DueLabel
@onready var complexity_label := $MarginContainer/VBoxContainer/MetadataRow/ComplexityLabel
@onready var bug_label := $MarginContainer/VBoxContainer/MetadataRow/BugLabel
@onready var progress_bar := $MarginContainer/VBoxContainer/ProgressSection/VBoxContainer/ProgressBar
@onready var progress_percent := $MarginContainer/VBoxContainer/ProgressSection/VBoxContainer/ProgressPercent
@onready var quality_label := $MarginContainer/VBoxContainer/ProgressSection/VBoxContainer/QualityLabel
@onready var work_button := $MarginContainer/VBoxContainer/ActionButtons/WorkButton
@onready var ship_it_button := $MarginContainer/VBoxContainer/ActionButtons/ShipItButton

func _ready() -> void:
	work_button.pressed.connect(_on_work_pressed)
	ship_it_button.pressed.connect(_on_ship_it_pressed)

	# Connect to GameManager signals (same as v1)
	GameManager.current_task_updated.connect(_on_task_updated)

	# Initial update
	if GameManager.current_task:
		_update_display()

func _on_work_pressed() -> void:
	work_pressed.emit()

func _on_ship_it_pressed() -> void:
	ship_it_pressed.emit()

func _on_task_updated(task: Task) -> void:
	_update_display()

func _update_display() -> void:
	var task = GameManager.current_task
	if not task:
		return

	# Task info
	task_title.text = task.name
	due_label.text = "Due: %dd" % task.deadline
	complexity_label.text = _get_complexity_emoji(task.complexity)
	bug_label.text = "🔧 %d" % GameManager.bugs

	# Progress
	progress_bar.value = task.progress
	progress_percent.text = "%d%%" % int(task.progress)
	quality_label.text = _get_quality_label(task.progress)

	# Ship It button state
	ship_it_button.disabled = task.progress < GameManager.MIN_SHIP_PROGRESS

func _get_complexity_emoji(complexity: int) -> String:
	var emoji = ""
	for i in complexity:
		emoji += "🍝"
	return emoji

func _get_quality_label(progress: float) -> String:
	if progress < 20:
		return "VERY RISKY"
	elif progress < 50:
		return "HALF-BAKED"
	elif progress < 90:
		return "ACCEPTABLE"
	else:
		return "READY TO SHIP"
```

**Test:** Connect signals, verify text updates
**Commit message:** "Add TaskPanelV2 script with update logic"

---

### Commit 3: Progress Bar Gradient
**Modify:** `scenes/task_panel_v2.tscn`

Add custom StyleBox to ProgressBar for gradient background:

**In Godot Editor:**
1. Select `ProgressBar` node
2. Theme Overrides → Styles → Background
3. Create new `StyleBoxFlat`
4. Set gradient colors (red → orange → yellow → green)

**Alternative (if StyleBox gradient doesn't work well):**
Add a `TextureRect` behind progress bar with pre-made gradient image

**Script addition for quality zones:**
```gdscript
# Add to task_panel_v2.gd

func _update_progress_bar_color() -> void:
	var progress = GameManager.current_task.progress
	var color: Color

	if progress < 20:
		color = Color("#FF4444")  # Red
	elif progress < 50:
		color = Color("#FF8844")  # Orange
	elif progress < 90:
		color = Color("#FFD700")  # Yellow
	else:
		color = Color("#44FF44")  # Green

	# Update progress bar fill color
	progress_bar.modulate = color
```

**Test:** Run game, watch progress bar change colors
**Commit message:** "Add quality gradient to TaskPanelV2 progress bar"

---

### Commit 4: Button Styling
**Modify:** `scenes/task_panel_v2.tscn`

**Style WORK button:**
1. Select WorkButton
2. Theme Overrides → Font Sizes → font_size = 24
3. Custom Minimum Size: x=0, y=60
4. Text: "⚙️ WORK"
5. Expand icon: true

**Style SHIP IT button:**
1. Select ShipItButton
2. Theme Overrides → Font Sizes → font_size = 24
3. Custom Minimum Size: x=0, y=60
4. Text: "🚢 SHIP IT"
5. Theme Overrides → Colors → font_color (disabled) = gray
6. Expand icon: true

**HBoxContainer settings:**
- Size Flags Horizontal: Expand + Fill (both buttons)
- Separation: 12px

**Test:** Buttons should be chunky, equal width, easy to tap
**Commit message:** "Style TaskPanelV2 buttons for mobile (60px tall)"

---

### Commit 5: Demo Scene
**Create:** `scenes/task_panel_v2_demo.tscn`

**Structure:**
```
Control (full screen)
└─ CenterContainer
   └─ TaskPanelV2 (custom_minimum_size: x=360, y=400)
```

**Script:** `scenes/task_panel_v2_demo.gd`
```gdscript
extends Control

func _ready() -> void:
	# Create a test task
	var test_task = Task.new()
	test_task.name = "Update Slack Status"
	test_task.description = "Set status to 'thriving'"
	test_task.complexity = 2
	test_task.deadline = 2
	test_task.progress = 41.0

	GameManager.current_task = test_task
	GameManager.bugs = 15

	# Connect signals for testing
	$CenterContainer/TaskPanelV2.work_pressed.connect(_on_work_pressed)
	$CenterContainer/TaskPanelV2.ship_it_pressed.connect(_on_ship_it_pressed)

func _on_work_pressed() -> void:
	print("WORK pressed - progress would increase")
	GameManager.current_task.progress += 10
	GameManager.current_task.progress = min(100, GameManager.current_task.progress)

func _on_ship_it_pressed() -> void:
	print("SHIP IT pressed - task would complete")
```

**Test:**
1. Open demo scene (F6)
2. Click WORK → progress increases
3. Click SHIP IT → prints message
4. Verify button sizes are easy to click

**Commit message:** "Add TaskPanelV2 demo scene for testing"

---

### Commit 6: Quality Guide Styling
**Modify:** `scenes/task_panel_v2.tscn`

**QualityGuide HBoxContainer:**
- Alignment: Center
- Separation: 16px

**Quality marker labels:**
```
Label "🔴 20%" - font_size: 18px, align: center
Label "🟠 50%" - font_size: 18px, align: center
Label "🟡 90%" - font_size: 18px, align: center
Label "🟢" - font_size: 18px, align: center
```

**Optional:** Add subtle lines connecting markers to progress bar

**Test:** Markers clearly show risk zones
**Commit message:** "Add quality zone guide markers to TaskPanelV2"

---

## Testing Checklist

After all commits, verify:

### Visual Tests
- [ ] Progress % is HUGE (48px) and readable
- [ ] Buttons are 60px tall (chunky, easy to tap)
- [ ] Quality label changes based on progress
- [ ] Gradient shows clear zones (red/orange/yellow/green)
- [ ] Quality markers align with gradient zones
- [ ] Task title + metadata readable but not dominant

### Functional Tests
- [ ] WORK button emits signal correctly
- [ ] SHIP IT button emits signal correctly
- [ ] SHIP IT disabled when progress <20%
- [ ] Progress bar updates smoothly (0-100)
- [ ] Quality label updates at thresholds (20, 50, 90)
- [ ] Bug count displays correctly
- [ ] Complexity emoji displays (🍝 x N)

### Mobile Tests (if possible)
- [ ] Export demo scene as Android APK
- [ ] Test on real phone (not just emulator)
- [ ] Verify buttons are easy to tap with thumb
- [ ] Check font sizes are readable at arm's length
- [ ] Test in portrait orientation

---

## File Summary

**Created:**
- `scenes/task_panel_v2.tscn` - Mobile-first task panel
- `scenes/task_panel_v2.gd` - Script with signals + update logic
- `scenes/task_panel_v2_demo.tscn` - Isolated testing scene
- `scenes/task_panel_v2_demo.gd` - Demo scene test logic

**Not Modified:**
- `scenes/task_panel.tscn` - Keep v1 for reference
- `scenes/game_ui.tscn` - Will integrate in Phase 2

---

## Success Criteria

Phase 1 complete when:
1. ✅ TaskPanelV2 works in isolation (demo scene)
2. ✅ All signals fire correctly
3. ✅ Progress display is readable + prominent
4. ✅ Buttons are chunky + easy to tap
5. ✅ Quality gradient clearly shows risk zones
6. ✅ Ready to integrate into game_ui_v2.tscn (Phase 2)

---

## Next Steps After Phase 1

**Phase 2:** Create `game_ui_v2.tscn` with TaskPanelV2 integrated
**Phase 3:** Add compressed status panels (escape + job)
**Phase 4:** Redesign interruption cards for prominence

See [mobile-first-layout-plan.md](mobile-first-layout-plan.md) for full roadmap.
