extends Node

var _tasks: Array = []

func _ready() -> void:
	load_tasks()

func load_tasks():
	var json_text = FileAccess.get_file_as_string("res://data/tasks.json")
	_tasks = JSON.parse_string(json_text)["tasks"]

func get_random_task(today_date: int = 1, job_level: int = 0) -> Task:
	# Filter tasks by job level complexity range
	# Junior (0): 1-3, Mid (1): 3-5, Senior (2): 5-7
	var min_complexity = 1 + (job_level * 2)
	var max_complexity = 3 + (job_level * 2)

	# Find tasks that match complexity range
	var valid_tasks = []
	for task in _tasks:
		if task["complexity"] >= min_complexity and task["complexity"] <= max_complexity:
			valid_tasks.append(task)

	# Fallback to any task if no matches
	if valid_tasks.size() == 0:
		valid_tasks = _tasks

	var task_data = valid_tasks[randi() % valid_tasks.size()]
	print("new task: " + task_data["title"] + " (complexity: " + str(task_data["complexity"]) + ")")
	var new_task = Task.new()
	new_task.title = task_data["title"]
	new_task.description = task_data["description"]
	new_task.flavor = task_data["flavor"]
	new_task.complexity = task_data["complexity"]

	# Scale deadline by job level: Junior (5-7d), Mid (4-6d), Senior (3-5d)
	var base_deadline = task_data["allowed_time"]
	var deadline_modifier = 2 - job_level  # +2, +1, +0
	new_task.due_day = today_date + base_deadline + deadline_modifier
	new_task.progress = 0

	# Convert JSON array to typed Array[String]
	var categories_array: Array[String] = []
	for cat in task_data["categories"]:
		categories_array.append(cat)
	new_task.categories = categories_array

	return new_task
