extends PanelContainer

# Signals (same as v1 for compatibility)
signal work_pressed
signal ship_it_pressed

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
@onready var task_title := $MarginContainer/VBoxContainer/HeaderRow/TaskTitle as Label
@onready var badge_container := $MarginContainer/VBoxContainer/HeaderRow/BadgeContainer as HBoxContainer
@onready var due_label := $MarginContainer/VBoxContainer/MetadataRow/DueLabel as Label
@onready var complexity_label := $MarginContainer/VBoxContainer/MetadataRow/ComplexityLabel as Label
@onready var progress_bar := $MarginContainer/VBoxContainer/ProgressSection/ProgressBar as ProgressBar
@onready var progress_percent := $MarginContainer/VBoxContainer/ProgressSection/ProgressPercent as Label
@onready var quality_label := $MarginContainer/VBoxContainer/ProgressSection/QualityLabel as Label
@onready var work_button := $MarginContainer/VBoxContainer/ActionButtons/WorkButton as Button
@onready var ship_it_button := $MarginContainer/VBoxContainer/ActionButtons/ShipItButton as Button

func _ready() -> void:
	print("TaskPanelV2: Ready")
	print("Work button: ", work_button)
	print("Ship It button: ", ship_it_button)

	work_button.pressed.connect(_on_work_pressed)
	ship_it_button.pressed.connect(_on_ship_it_pressed)

	# Connect to GameManager signals (same as v1)
	GameManager.current_task_updated.connect(_on_task_updated)

	# Initial update
	if GameManager.current_task:
		_update_display()

func _on_work_pressed() -> void:
	print("TaskPanelV2: Work button pressed")
	work_pressed.emit()

func _on_ship_it_pressed() -> void:
	print("TaskPanelV2: Ship It button pressed")
	ship_it_pressed.emit()

func _on_task_updated(task: Task) -> void:
	# Connect to the new task's progress_changed signal
	task.progress_changed.connect(_on_progress_changed)
	_update_display()

func _on_progress_changed(new_progress: float) -> void:
	# Update display when task progress changes
	_update_display()

func _update_display() -> void:
	var task = GameManager.current_task
	if not task:
		return

	# Task info
	task_title.text = task.title
	var days_until_due = task.due_day - GameManager.day
	due_label.text = "Due: %dd" % days_until_due
	complexity_label.text = _get_complexity_emoji(task.complexity)

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
