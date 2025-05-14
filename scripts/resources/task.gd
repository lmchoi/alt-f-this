class_name Task
extends Resource

signal work_completed()

@export var title := "Fix CEO's PowerPoint"
@export var due_day := 2 # Day number (e.g., Day 3)
@export var work_remaining := 1

func do_work(unit_of_work):
	work_remaining -= unit_of_work
	if work_remaining == 0:
		work_completed.emit()
