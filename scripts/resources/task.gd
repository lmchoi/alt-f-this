class_name Task
extends Resource

signal progress_changed(new_progress: float)

@export var task_id := "ALT-0000"  # JIRA-style task ID
@export var title := "Fix CEO's PowerPoint"
@export var description := "The CEO needs this done ASAP"
@export var flavor := ""  # e.g., "Design Hell", "Buzzword Compliance"
@export var complexity := 5  # 1-10 scale (affects work speed)
@export var due_day := 5 # Day number (e.g., Day 3)
@export var categories: Array[String] = []  # e.g., ["optics"], ["tech_debt", "critical"]

var _progress := 0.0  # Backing variable

var progress := 0.0:
	set(value):
		_progress = value
		progress_changed.emit(_progress)
	get:
		return _progress

func _init(today_date: int = 1, new_title: String = "Fix CEO's PowerPoint", allowed_time: int = 3, task_complexity: int = 5):
	title = new_title
	complexity = task_complexity
	due_day = today_date + allowed_time
	self.progress = 0  # Use self. to ensure setter is called

func do_work(amount: float) -> float:
	"""Add progress to task. Returns actual amount added."""
	var actual_amount = min(amount, 100 - progress)
	self.progress += actual_amount
	return actual_amount
