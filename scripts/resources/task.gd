class_name Task
extends Resource

signal work_completed(event_data)

@export var title := "Fix CEO's PowerPoint"
@export var due_day := 5 # Day number (e.g., Day 3)
@export var work_remaining := 1

func do_work():
	work_remaining -= 1

	if work_remaining == 0:
		work_completed.emit({"text": "Work Completed!"})
