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

# Task card management
const TaskCardScene = preload("res://scenes/task_card.tscn")
var task_cards: Array = []  # Keep references to instantiated cards

# Node references
@onready var job_tab := $MarginContainer/VBoxContainer/TabBar/JobTab as Button
@onready var escape_tab := $MarginContainer/VBoxContainer/TabBar/EscapeTab as Button
@onready var job_content := $MarginContainer/VBoxContainer/JobContent as VBoxContainer
@onready var escape_content := $MarginContainer/VBoxContainer/EscapeContent as VBoxContainer
@onready var hustle_button := $MarginContainer/VBoxContainer/EscapeContent/ActionButtons/HustleButton as Button

# Legacy single-task nodes (for ESCAPE tab)
@onready var task_title := $MarginContainer/VBoxContainer/EscapeContent/HeaderRow/TaskTitle as Label
@onready var due_label := $MarginContainer/VBoxContainer/EscapeContent/MetadataRow/DueLabel as Label
@onready var progress_bar := $MarginContainer/VBoxContainer/EscapeContent/ProgressSection/ProgressBar as ProgressBar
@onready var progress_percent := $MarginContainer/VBoxContainer/EscapeContent/ProgressSection/ProgressPercent as Label

func _ready() -> void:
	print("TaskPanelV2: Ready")

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
	hustle_button.pressed.connect(_on_hustle_pressed)

	# Connect to GameManager signals
	GameManager.current_task_updated.connect(_on_task_updated)
	GameManager.side_project_updated.connect(_on_side_project_updated)
	GameManager.tasks_changed.connect(_on_tasks_changed)

	# Initial update
	_update_display()

func _on_hustle_pressed() -> void:
	print("TaskPanelV2: Hustle button pressed")
	hustle_pressed.emit()

func _on_task_updated(task: Task) -> void:
	# Connect to the new task's progress_changed signal
	if task and not task.progress_changed.is_connected(_on_progress_changed):
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
		_update_task_list()
		job_content.visible = true
		escape_content.visible = false
	else:
		_show_escape_task()
		job_content.visible = false
		escape_content.visible = true
	_apply_theme(current_task_type)

func _on_tasks_changed(tasks: Array[Task]) -> void:
	"""Handle tasks list changes from GameManager."""
	_update_task_list()

func _update_task_list() -> void:
	"""Update task cards to match GameManager.tasks using update-in-place pattern."""
	var tasks = GameManager.tasks

	# Update existing cards or create new ones
	for i in tasks.size():
		var card = null

		if i < task_cards.size():
			# Reuse existing card
			card = task_cards[i]
		else:
			# Need more cards - create new one
			card = TaskCardScene.instantiate()
			job_content.add_child(card)
			task_cards.append(card)

			# Connect signals from the new card
			card.work_pressed.connect(_on_task_work_pressed)
			card.ship_it_pressed.connect(_on_task_ship_it_pressed)

		# Update card with task data
		card.set_task(tasks[i])
		card.set_active(tasks[i] == GameManager.current_task)
		card.visible = true

	# Hide excess cards
	for i in range(tasks.size(), task_cards.size()):
		task_cards[i].visible = false

func _on_task_work_pressed(task: Task) -> void:
	"""Handle WORK button pressed on a task card."""
	print("TaskPanelV2: Work pressed on task: ", task.title)

	# Switch to this task if it's not already active
	if task != GameManager.current_task:
		GameManager.switch_task(task)
		print("TaskPanelV2: Switched to task: ", task.title)

	# Emit work signal so game_ui can process it
	work_pressed.emit()

func _on_task_ship_it_pressed(task: Task) -> void:
	"""Handle SHIP IT button pressed on a task card."""
	print("TaskPanelV2: Ship It pressed on task: ", task.title)

	# Switch to this task if it's not already active
	if task != GameManager.current_task:
		GameManager.switch_task(task)
		print("TaskPanelV2: Switched to task: ", task.title)

	# Emit ship signal so game_ui can process it
	ship_it_pressed.emit()

func _show_escape_task() -> void:
	var escape = GameManager.side_project

	# Title
	task_title.text = "Side Project"

	# Metadata
	due_label.text = "Goal: $5K"

	# Progress
	progress_bar.value = escape.progress
	progress_percent.text = "%d%%" % int(escape.progress)

	# Color based on escape progress
	var color: Color
	if escape.progress < 50:
		color = Color(1.0, 0.9, 0.3, 0.8)  # Gold/Yellow
	else:
		color = Color(0.9, 0.75, 0.3, 0.8)  # Brighter gold
	progress_bar.modulate = color

func _apply_theme(task_type: TaskType) -> void:
	if task_type == TaskType.JOB:
		add_theme_stylebox_override("panel", job_theme_style)
	else:
		add_theme_stylebox_override("panel", escape_theme_style)

func _on_job_tab_pressed() -> void:
	print("TaskPanelV2: JOB tab pressed")
	current_task_type = TaskType.JOB
	_update_display()

func _on_escape_tab_pressed() -> void:
	print("TaskPanelV2: ESCAPE tab pressed")
	current_task_type = TaskType.ESCAPE
	_update_display()
