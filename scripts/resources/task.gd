class_name Task
extends Resource

@export var title := "Fix CEO's PowerPoint"
@export var due_day := 5 # Day number (e.g., Day 3)
@export var progress := 0

func _init(today_date: int = 1, new_title: String = "Fix CEO's PowerPoint", allowed_time: int = 3):
	title = new_title
	due_day = today_date + allowed_time
	progress = 0

func do_work():
#	update this value
	progress += 20
