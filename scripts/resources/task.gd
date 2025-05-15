class_name Task
extends Resource

signal work_completed(event_data)

@export var title := "Fix CEO's PowerPoint"
@export var due_day := 5 # Day number (e.g., Day 3)
@export var progress := 0

func do_work():
#	update this value
	progress += 20

	if progress >= 100:
		work_completed.emit({"text": "Work Completed!"})
		_new_task()

func _new_task():
#	for now, just reset the existing
	progress = 0
