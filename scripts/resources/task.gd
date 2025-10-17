class_name Task
extends Resource

@export var title := "Fix CEO's PowerPoint"
@export var complexity := 5  # 1-10 scale (affects work speed)
@export var due_day := 5 # Day number (e.g., Day 3)
@export var progress := 0

func _init(today_date: int = 1, new_title: String = "Fix CEO's PowerPoint", allowed_time: int = 3, task_complexity: int = 5):
	title = new_title
	complexity = task_complexity
	due_day = today_date + allowed_time
	progress = 0

func do_work(amount: float) -> float:
	"""Add progress to task. Returns actual amount added."""
	var actual_amount = min(amount, 100 - progress)
	progress += actual_amount
	return actual_amount
