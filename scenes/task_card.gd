extends PanelContainer
## Displays a single task in the task list

# Category badge theme mapping
const BADGE_THEME = preload("res://themes/badge_theme.tres")
const CATEGORY_STYLES = {
	"critical": "CriticalBadge",
	"optics": "OpticsBadge",
	"tech_debt": "TechDebtBadge",
	"technical": "TechnicalBadge",
	"urgent": "UrgentBadge"
}

# Signals
signal work_pressed(task: Task)
signal ship_it_pressed(task: Task)

# Node references
@onready var task_title := $MarginContainer/VBoxContainer/HeaderRow/TaskTitle as Label
@onready var badge_container := $MarginContainer/VBoxContainer/HeaderRow/BadgeContainer as HBoxContainer
@onready var metadata_row := $MarginContainer/VBoxContainer/MetadataRow as HBoxContainer
@onready var due_label := $MarginContainer/VBoxContainer/MetadataRow/DueLabel as Label
@onready var complexity_label := $MarginContainer/VBoxContainer/MetadataRow/ComplexityLabel as Label
@onready var progress_bar := $MarginContainer/VBoxContainer/ProgressBar as ProgressBar
@onready var progress_label := $MarginContainer/VBoxContainer/ProgressLabel as Label
@onready var active_label := $MarginContainer/VBoxContainer/ActiveLabel as Label
@onready var work_button := $MarginContainer/VBoxContainer/ActionButtons/WorkButton as Button
@onready var ship_it_button := $MarginContainer/VBoxContainer/ActionButtons/ShipItButton as Button

var task: Task
var is_active := false

func _ready() -> void:
	# Connect buttons
	work_button.pressed.connect(_on_work_pressed)
	ship_it_button.pressed.connect(_on_ship_it_pressed)

	if task:
		update_display()

func _on_work_pressed() -> void:
	work_pressed.emit(task)

func _on_ship_it_pressed() -> void:
	ship_it_pressed.emit(task)

func set_task(new_task: Task) -> void:
	"""Set the task to display and update the UI."""
	task = new_task
	if task:
		# Connect to progress updates
		if not task.progress_changed.is_connected(_on_task_progress_changed):
			task.progress_changed.connect(_on_task_progress_changed)
		update_display()

func set_active(active: bool) -> void:
	"""Set whether this task is the active one."""
	is_active = active
	active_label.visible = is_active
	# Make active task visually distinct
	_update_card_style_for_active()

func _on_task_progress_changed(_new_progress: float) -> void:
	update_display()

func update_display() -> void:
	"""Update all UI elements based on current task state."""
	if not task:
		return

	# Title
	task_title.text = task.title

	# Metadata
	# GameManager might not be available if this is run outside scene tree
	var current_day = GameManager.day if is_inside_tree() else 1
	var days_until_due = task.due_day - current_day
	if days_until_due < 0:
		due_label.text = "OVERDUE: %dd" % abs(days_until_due)
		due_label.add_theme_color_override("font_color", Color(1.0, 0.3, 0.3))
	elif days_until_due == 0:
		due_label.text = "Due: TODAY"
		due_label.add_theme_color_override("font_color", Color(1.0, 0.5, 0.0))
	else:
		due_label.text = "Due: %dd" % days_until_due
		due_label.remove_theme_color_override("font_color")

	complexity_label.text = _get_complexity_emoji(task.complexity)

	# Update category badges
	_update_category_badges(task.categories)

	# Progress
	progress_bar.value = task.progress
	progress_label.text = "%d%%" % int(task.progress)

	# Update SHIP IT button state
	ship_it_button.disabled = task.progress < GameManager.MIN_SHIP_PROGRESS if is_inside_tree() else true

	# Update card color based on urgency
	_update_card_style(days_until_due)

func _get_complexity_emoji(complexity: int) -> String:
	var emoji = ""
	for i in complexity:
		emoji += "🍝"
	return emoji

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

func _update_card_style(days_until_due: int) -> void:
	"""Update card border color based on urgency."""
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.12, 0.12, 0.15, 1)

	# Thicker border if active
	var border_width = 3 if is_active else 2
	style.border_width_left = border_width
	style.border_width_top = border_width
	style.border_width_right = border_width
	style.border_width_bottom = border_width

	style.corner_radius_top_left = 4
	style.corner_radius_top_right = 4
	style.corner_radius_bottom_right = 4
	style.corner_radius_bottom_left = 4

	# Color-code by urgency (or green if active)
	if is_active:
		# Active task - green
		style.border_color = Color(0.3, 1.0, 0.3, 1.0)
	elif days_until_due < 0:
		# Overdue - bright red
		style.border_color = Color(1.0, 0.2, 0.2, 1.0)
		style.border_width_left = 3
		style.border_width_top = 3
		style.border_width_right = 3
		style.border_width_bottom = 3
	elif days_until_due == 0:
		# Due today - red
		style.border_color = Color(1.0, 0.3, 0.3, 1.0)
	elif days_until_due <= 2:
		# Due soon - yellow
		style.border_color = Color(1.0, 0.9, 0.3, 1.0)
	else:
		# Normal - gray
		style.border_color = Color(0.3, 0.3, 0.3, 1.0)

	add_theme_stylebox_override("panel", style)

func _update_card_style_for_active() -> void:
	"""Update card styling when active state changes."""
	if not task or not is_inside_tree():
		return
	var current_day = GameManager.day if is_inside_tree() else 1
	var days_until_due = task.due_day - current_day
	_update_card_style(days_until_due)
