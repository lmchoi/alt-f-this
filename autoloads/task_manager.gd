extends Node

var _tasks: Array = []

func _ready() -> void:
	load_tasks()

func load_tasks():
	var json_text = FileAccess.get_file_as_string("res://data/tasks.json")
	_tasks = JSON.parse_string(json_text)["tasks"]

func get_random_task(today_date: int = 1) -> Task:
	var random_index = randi() % 10
	var task = _tasks[random_index]
	print("new task: " + task["title"])
	return Task.new(today_date, task["title"], task["allowed_time"])
