extends PanelContainer

@onready var task_label := $"%TaskLabel"
@onready var description_label := $"%DescriptionLabel"
@onready var flavor_label := $"%FlavorLabel"
@onready var complexity_label := $"%ComplexityLabel"
@onready var category_label := $"%CategoryLabel"
@onready var deadline_label := $"%DeadlineLabel"
@onready var progress_bar := $"%ProgressBar"
@onready var bug_impact_label := $"%BugImpactLabel"

func _ready():
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
		deadline_label.add_theme_color_override("font_color", Color(0.8, 0.2, 0.2, 1))  # Red
	elif days_left <= 1:
		deadline_label.text = "Due in " + str(days_left) + " days"
		deadline_label.add_theme_color_override("font_color", Color(0.8, 0.8, 0.2, 1))  # Yellow
	else:
		deadline_label.text = "Due in " + str(days_left) + " days"
		deadline_label.add_theme_color_override("font_color", Color(0.2, 0.8, 0.2, 1))  # Green

func _update_progress(progress: float):
	progress_bar.value = progress

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
