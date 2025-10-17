extends Node

var _tasks: Array = []

func _ready() -> void:
	load_tasks()

func load_tasks():
	var json_text = FileAccess.get_file_as_string("res://data/tasks.json")
	_tasks = JSON.parse_string(json_text)["tasks"]

func get_random_task(today_date: int = 1) -> Task:
	var random_index = randi() % 10
	var task_data = _tasks[random_index]
	print("new task: " + task_data["title"] + " (complexity: " + str(task_data["complexity"]) + ")")
	var new_task = Task.new()
	new_task.title = task_data["title"]
	new_task.complexity = task_data["complexity"]
	new_task.due_day = today_date + task_data["allowed_time"]
	new_task.progress = 0
	return new_task
