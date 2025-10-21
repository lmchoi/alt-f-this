extends PanelContainer

# Font size hierarchy - adjust these to change UI scale
const FONT_SIZE_CRITICAL = 24  # Progress percentage, deadline
const FONT_SIZE_GAMEPLAY = 20  # Complexity, categories, bug impact
const FONT_SIZE_STANDARD = 18  # Title, description, flavor, indicators

# Color palette - adjust these to change UI theme
const COLOR_BRIGHT_GREEN = Color(0.2, 0.8, 0.2, 1)    # Gameplay info (default)
const COLOR_YELLOW = Color(0.8, 0.8, 0.2, 1)          # Warnings, urgency
const COLOR_ORANGE = Color(0.8, 0.4, 0.2, 1)          # Bugs, problems
const COLOR_RED = Color(0.8, 0.2, 0.2, 1)             # Critical, overdue
const COLOR_DIM_GRAY = Color(0.6, 0.6, 0.6, 1)        # Flavor text
const COLOR_VERY_DIM_GRAY = Color(0.5, 0.5, 0.5, 1)   # Less important flavor

@onready var task_label := $"%TaskLabel"
@onready var description_label := $"%DescriptionLabel"
@onready var flavor_label := $"%FlavorLabel"
@onready var complexity_label := $"%ComplexityLabel"
@onready var category_label := $"%CategoryLabel"
@onready var deadline_label := $"%DeadlineLabel"
@onready var progress_bar := $"%ProgressBar"
@onready var bug_impact_label := $"%BugImpactLabel"
@onready var ship_it_indicator := $"%ShipItIndicator"

func _ready():
	# Apply font size hierarchy
	task_label.add_theme_font_size_override("font_size", FONT_SIZE_STANDARD)
	description_label.add_theme_font_size_override("font_size", FONT_SIZE_STANDARD)
	flavor_label.add_theme_font_size_override("font_size", FONT_SIZE_STANDARD)
	complexity_label.add_theme_font_size_override("font_size", FONT_SIZE_GAMEPLAY)
	deadline_label.add_theme_font_size_override("font_size", FONT_SIZE_CRITICAL)
	bug_impact_label.add_theme_font_size_override("font_size", FONT_SIZE_GAMEPLAY)
	ship_it_indicator.add_theme_font_size_override("font_size", FONT_SIZE_STANDARD)
	progress_bar.add_theme_font_size_override("font_size", FONT_SIZE_CRITICAL)

	# Apply color palette
	task_label.add_theme_color_override("font_color", COLOR_DIM_GRAY)
	description_label.add_theme_color_override("font_color", COLOR_DIM_GRAY)
	flavor_label.add_theme_color_override("font_color", COLOR_VERY_DIM_GRAY)
	complexity_label.add_theme_color_override("font_color", COLOR_BRIGHT_GREEN)
	bug_impact_label.add_theme_color_override("font_color", COLOR_ORANGE)
	ship_it_indicator.add_theme_color_override("font_color", COLOR_YELLOW)
	progress_bar.add_theme_color_override("font_color", COLOR_BRIGHT_GREEN)

	GameManager.current_task_updated.connect(_on_current_task_updated)
	GameManager.next_day.connect(_on_next_day)
	GameManager.task_progress_changed.connect(_update_progress)
	GameManager.bugs_changed.connect(_update_bug_impact)

	# Initialize with current values
	if GameManager.current_task:
		_on_current_task_updated(GameManager.current_task)
		_on_next_day(GameManager.day)
		_update_bug_impact(GameManager.bugs)

func _on_current_task_updated(current_task: Task):
	task_label.text = current_task.title
	description_label.text = current_task.description
	_update_complexity_label(current_task.complexity)
	_update_flavor_and_categories(current_task.flavor, current_task.categories)

func _on_next_day(nth_day: int):
	var days_left = GameManager.current_task.due_day - nth_day
	_update_deadline_label(days_left)
	progress_bar.value = GameManager.current_task.progress

func _update_complexity_label(complexity: int):
	# Spaghetti code indicator (more spaghetti = more complex)
	var spaghetti = ""
	for i in range(complexity):
		spaghetti += "🍝"
	complexity_label.text = "Complexity: " + spaghetti

func _update_deadline_label(days_left: int):
	if days_left < 0:
		deadline_label.text = str(abs(days_left)) + " days overdue"
		deadline_label.add_theme_color_override("font_color", COLOR_RED)
	elif days_left <= 1:
		deadline_label.text = "Due in " + str(days_left) + " days"
		deadline_label.add_theme_color_override("font_color", COLOR_YELLOW)
	else:
		deadline_label.text = "Due in " + str(days_left) + " days"
		deadline_label.add_theme_color_override("font_color", COLOR_BRIGHT_GREEN)

func _update_progress(progress: float):
	progress_bar.value = progress

	# Show SHIP IT indicator at 20%+ progress
	if progress >= 20.0:
		ship_it_indicator.visible = true
	else:
		ship_it_indicator.visible = false

func _update_flavor_and_categories(flavor: String, categories: Array[String]):
	var display_text = flavor

	if not categories.is_empty():
		display_text += " "
		for category in categories:
			display_text += "[" + category.to_upper() + "] "

	flavor_label.text = display_text.strip_edges()
	category_label.visible = false

func _update_bug_impact(_amount: int):
	var bug_multiplier = GameManager.get_bug_multiplier()
	if bug_multiplier > 1.0:
		bug_impact_label.text = "Progress slowed by bugs: %.1fx" % bug_multiplier
		bug_impact_label.visible = true
	else:
		bug_impact_label.visible = false
