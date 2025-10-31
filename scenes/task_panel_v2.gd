extends PanelContainer

# Task type enum
enum TaskType {
	JOB,     # Corporate work task
	ESCAPE   # Side project / escape plan
}

# Signals (same as v1 for compatibility)
signal work_pressed
signal ship_it_pressed
signal hustle_pressed

# Current task type being displayed
var current_task_type := TaskType.JOB

# Theme styles
var job_theme_style: StyleBox
var escape_theme_style: StyleBox

# Category badge theme mapping
const BADGE_THEME = preload("res://themes/badge_theme.tres")
const CATEGORY_STYLES = {
	"critical": "CriticalBadge",
	"optics": "OpticsBadge",
	"tech_debt": "TechDebtBadge",
	"technical": "TechnicalBadge",
	"urgent": "UrgentBadge"
}

# Node references
@onready var job_tab := $MarginContainer/VBoxContainer/TabBar/JobTab as Button
@onready var escape_tab := $MarginContainer/VBoxContainer/TabBar/EscapeTab as Button
@onready var task_title := $MarginContainer/VBoxContainer/HeaderRow/TaskTitle as Label
@onready var badge_container := $MarginContainer/VBoxContainer/HeaderRow/BadgeContainer as HBoxContainer
@onready var due_label := $MarginContainer/VBoxContainer/MetadataRow/DueLabel as Label
@onready var complexity_label := $MarginContainer/VBoxContainer/MetadataRow/ComplexityLabel as Label
@onready var progress_bar := $MarginContainer/VBoxContainer/ProgressSection/ProgressBar as ProgressBar
@onready var progress_percent := $MarginContainer/VBoxContainer/ProgressSection/ProgressPercent as Label
@onready var quality_label := $MarginContainer/VBoxContainer/ProgressSection/QualityLabel as Label
@onready var work_button := $MarginContainer/VBoxContainer/ActionButtons/WorkButton as Button
@onready var ship_it_button := $MarginContainer/VBoxContainer/ActionButtons/ShipItButton as Button
@onready var hustle_button := $MarginContainer/VBoxContainer/ActionButtons/HustleButton as Button

func _ready() -> void:
	print("TaskPanelV2: Ready")
	print("Work button: ", work_button)
	print("Ship It button: ", ship_it_button)

	# Store theme styles
	job_theme_style = get_theme_stylebox("panel")

	# Create escape theme style (gold border)
	escape_theme_style = StyleBoxFlat.new()
	escape_theme_style.bg_color = Color(0.12, 0.12, 0.15, 1)
	escape_theme_style.border_width_left = 3
	escape_theme_style.border_width_top = 3
	escape_theme_style.border_width_right = 3
	escape_theme_style.border_width_bottom = 3
	escape_theme_style.border_color = Color(0.9, 0.75, 0.3, 1)  # Gold
	escape_theme_style.corner_radius_top_left = 6
	escape_theme_style.corner_radius_top_right = 6
	escape_theme_style.corner_radius_bottom_right = 6
	escape_theme_style.corner_radius_bottom_left = 6
	escape_theme_style.shadow_color = Color(0.9, 0.75, 0.3, 0.2)
	escape_theme_style.shadow_size = 6

	# Connect tab buttons
	job_tab.pressed.connect(_on_job_tab_pressed)
	escape_tab.pressed.connect(_on_escape_tab_pressed)

	work_button.pressed.connect(_on_work_pressed)
	ship_it_button.pressed.connect(_on_ship_it_pressed)
	hustle_button.pressed.connect(_on_hustle_pressed)

	# Connect to GameManager signals (same as v1)
	GameManager.current_task_updated.connect(_on_task_updated)
	GameManager.side_project_updated.connect(_on_side_project_updated)

	# Initial update
	if GameManager.current_task:
		_update_display()

func _on_work_pressed() -> void:
	print("TaskPanelV2: Work button pressed")
	work_pressed.emit()

func _on_ship_it_pressed() -> void:
	print("TaskPanelV2: Ship It button pressed")
	ship_it_pressed.emit()

func _on_hustle_pressed() -> void:
	print("TaskPanelV2: Hustle button pressed")
	hustle_pressed.emit()

func _on_task_updated(task: Task) -> void:
	# Connect to the new task's progress_changed signal
	task.progress_changed.connect(_on_progress_changed)
	_update_display()

func _on_progress_changed(new_progress: float) -> void:
	# Update display when task progress changes
	_update_display()

func _on_side_project_updated(_side_project_data: Dictionary) -> void:
	# Update display when side project progress changes (only if showing ESCAPE tab)
	if current_task_type == TaskType.ESCAPE:
		_update_display()

func _update_display() -> void:
	if current_task_type == TaskType.JOB:
		_show_job_task()
	else:
		_show_escape_task()
	_update_button_visibility(current_task_type)
	_apply_theme(current_task_type)

func _show_job_task() -> void:
	var task = GameManager.current_task
	if not task:
		return

	# Task info
	task_title.text = task.title
	var days_until_due = task.due_day - GameManager.day
	due_label.text = "Due: %dd" % days_until_due
	complexity_label.text = _get_complexity_emoji(task.complexity)
	complexity_label.visible = true

	# Update category badges
	_update_category_badges(task.categories)

	# Progress
	progress_bar.value = task.progress
	progress_percent.text = "%d%%" % int(task.progress)
	quality_label.text = _get_quality_label(task.progress)

	# Update progress bar color based on quality
	_update_progress_bar_color(task.progress)

	# Ship It button state
	ship_it_button.disabled = task.progress < GameManager.MIN_SHIP_PROGRESS

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

func _update_progress_bar_color(progress: float) -> void:
	var color: Color

	if progress < 20:
		color = Color(1.0, 0.3, 0.3, 0.8)  # Red
	elif progress < 50:
		color = Color(1.0, 0.6, 0.2, 0.8)  # Orange
	elif progress < 90:
		color = Color(1.0, 0.9, 0.3, 0.8)  # Yellow
	else:
		color = Color(0.3, 1.0, 0.3, 0.8)  # Green

	# Update progress bar modulate to tint the fill color
	progress_bar.modulate = color

func _create_badge(category: String) -> Label:
	var badge = Label.new()
	badge.text = " " + category.to_upper() + " "
	badge.theme = BADGE_THEME
	badge.add_theme_color_override("font_color", Color(0, 0, 0, 1))  # Black text

	# Apply category-specific style from theme
	var cat_lower = category.to_lower()
	var style_name = CATEGORY_STYLES.get(cat_lower, "CriticalBadge")
	var style = BADGE_THEME.get_stylebox(style_name, "Label")
	if style:
		badge.add_theme_stylebox_override("normal", style)

	return badge

func _update_category_badges(categories: Array[String]) -> void:
	# Clear existing badges
	for child in badge_container.get_children():
		child.queue_free()

	# Create new badges
	for category in categories:
		badge_container.add_child(_create_badge(category))

func _apply_theme(task_type: TaskType) -> void:
	if task_type == TaskType.JOB:
		add_theme_stylebox_override("panel", job_theme_style)
	else:
		add_theme_stylebox_override("panel", escape_theme_style)

func _update_button_visibility(task_type: TaskType) -> void:
	work_button.visible = (task_type == TaskType.JOB)
	ship_it_button.visible = (task_type == TaskType.JOB)
	hustle_button.visible = (task_type == TaskType.ESCAPE)

func _on_job_tab_pressed() -> void:
	print("TaskPanelV2: JOB tab pressed")
	current_task_type = TaskType.JOB
	_update_display()

func _on_escape_tab_pressed() -> void:
	print("TaskPanelV2: ESCAPE tab pressed")
	current_task_type = TaskType.ESCAPE
	_update_display()
