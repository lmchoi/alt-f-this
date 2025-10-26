extends PanelContainer

# Color name mapping for JSON data
const COLOR_MAP = {
	"green": UIColors.STATUS_GREEN,
	"yellow": UIColors.STATUS_YELLOW,
	"orange": UIColors.STATUS_ORANGE,
	"red": UIColors.STATUS_RED,
	"subdued": UIColors.TEXT_SUBDUED
}

# Category badge theme mapping
const BADGE_THEME = preload("res://themes/badge_theme.tres")
const CATEGORY_STYLES = {
	"critical": "CriticalBadge",
	"optics": "OpticsBadge",
	"technical": "TechnicalBadge",
	"urgent": "UrgentBadge"
}

@onready var task_id_label := $"%TaskIdLabel"
@onready var task_label := $"%TaskLabel"
@onready var description_label := $"%DescriptionLabel"
@onready var complexity_label := $"%ComplexityLabel"
@onready var badge_container := $"%HeaderBadgeContainer"
@onready var deadline_label := $"%DeadlineLabel"
@onready var progress_bar := $"%ProgressBar"
@onready var ship_it_indicator := $"%ShipItIndicator"
@onready var ship_it_button := $"%ShipItButton"

var progress_indicators: Dictionary = {}

signal ship_it_pressed

func _load_progress_indicators():
	var json_text = FileAccess.get_file_as_string("res://data/progress_indicators.json")
	progress_indicators = JSON.parse_string(json_text)

func _ready():
	_load_progress_indicators()
	# Apply job color theme
	task_id_label.add_theme_color_override("font_color", UIColors.JOB_SILVER)
	task_label.add_theme_color_override("font_color", UIColors.JOB_SILVER)
	description_label.add_theme_color_override("font_color", UIColors.JOB_INFO_BLUE)
	complexity_label.add_theme_color_override("font_color", UIColors.JOB_INFO_BLUE)
	ship_it_indicator.add_theme_color_override("font_color", UIColors.STATUS_YELLOW)
	progress_bar.add_theme_color_override("font_color", UIColors.JOB_INFO_BLUE)

	GameManager.current_task_updated.connect(_on_current_task_updated)
	GameManager.next_day.connect(_on_next_day)
	GameManager.task_progress_changed.connect(_update_progress)
	ship_it_button.pressed.connect(_on_ship_it_pressed)

func _on_ship_it_pressed():
	ship_it_pressed.emit()

func _on_current_task_updated(current_task: Task):
	task_id_label.text = current_task.task_id
	task_label.text = current_task.title
	description_label.text = current_task.description
	_update_complexity_label(current_task.complexity)
	_update_flavor_and_categories(current_task.flavor, current_task.categories)

	# Update deadline and progress for new task
	var days_left = current_task.due_day - GameManager.day
	_update_deadline_label(days_left)
	_update_progress(current_task.progress)

func _on_next_day(nth_day: int):
	var days_left = GameManager.current_task.due_day - nth_day
	_update_deadline_label(days_left)
	_update_progress(GameManager.current_task.progress)

func _update_complexity_label(complexity: int):
	# Spaghetti code indicator (more spaghetti = more complex)
	var spaghetti = ""
	for i in range(complexity):
		spaghetti += "🍝"
	complexity_label.text = "Complexity: " + spaghetti

func _update_deadline_label(days_left: int):
	if days_left < 0:
		deadline_label.text = "⚡ " + str(abs(days_left)) + " days overdue ⚡"
		deadline_label.add_theme_color_override("font_color", UIColors.STATUS_RED)
	elif days_left <= 1:
		deadline_label.text = "⚡ Due in " + str(days_left) + " days"
		deadline_label.add_theme_color_override("font_color", UIColors.STATUS_YELLOW)
	else:
		deadline_label.text = "Due in " + str(days_left) + " days"
		deadline_label.add_theme_color_override("font_color", UIColors.JOB_INFO_BLUE)

func _update_progress(progress: float):
	progress_bar.value = progress

	# Update SHIP IT indicator from JSON data
	var thresholds = progress_indicators["progress_thresholds"]
	var indicator_data = null

	# Find the appropriate threshold (check in descending order)
	for key in ["complete", "almost_done", "acceptable", "half_baked", "very_risky", "incomplete", "not_started"]:
		var threshold = thresholds[key]
		if progress >= threshold["min"]:
			indicator_data = threshold
			break

	if indicator_data:
		# Special handling for 100% completion - show message based on days sitting
		if progress >= 100 and indicator_data.has("messages_by_days"):
			var messages = indicator_data["messages_by_days"]
			var days = min(GameManager.days_at_100_percent, len(messages) - 1)
			ship_it_indicator.text = messages[str(days)]
		else:
			ship_it_indicator.text = indicator_data["text"]

		# Map color name to actual color
		var color = COLOR_MAP.get(indicator_data["color"], UIColors.JOB_INFO_BLUE)
		ship_it_indicator.add_theme_color_override("font_color", color)

		ship_it_indicator.visible = true

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

func _update_flavor_and_categories(_flavor: String, categories: Array[String]):
	# Clear existing badges
	for child in badge_container.get_children():
		child.queue_free()

	# Create new badges
	for category in categories:
		badge_container.add_child(_create_badge(category))
