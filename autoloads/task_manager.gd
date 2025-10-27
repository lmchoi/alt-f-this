extends Node

var _tasks: Array = []
var _tutorial_tasks: Array = []
var _next_task_id: int = 1000  # Start at ALT-1000
var _current_tutorial_index: int = 0

func _ready() -> void:
	load_tasks()
	load_tutorial_tasks()

func load_tasks():
	var json_text = FileAccess.get_file_as_string("res://data/tasks.json")
	_tasks = JSON.parse_string(json_text)["tasks"]

func load_tutorial_tasks():
	var json_text = FileAccess.get_file_as_string("res://data/tutorial_tasks.json")
	_tutorial_tasks = JSON.parse_string(json_text)["tutorial_tasks"]

func get_random_task(today_date: int = 1, job_level: int = 0) -> Task:
	var task_data: Dictionary

	# Check if still in tutorial phase
	if _current_tutorial_index < len(_tutorial_tasks):
		task_data = _tutorial_tasks[_current_tutorial_index]
		_current_tutorial_index += 1
		print("tutorial task %d: %s" % [_current_tutorial_index, task_data["title"]])
	else:
		# Post-tutorial: Filter tasks by job level complexity range
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

		task_data = valid_tasks[randi() % valid_tasks.size()]
		print("new task: " + task_data["title"] + " (complexity: " + str(task_data["complexity"]) + ")")
	var new_task = Task.new()

	# Generate JIRA-style task ID
	new_task.task_id = "ALT-%d" % _next_task_id
	_next_task_id += 1

	new_task.title = task_data["title"]
	new_task.description = task_data["description"]
	new_task.flavor = task_data["flavor"]
	new_task.complexity = task_data["complexity"]

	var base_deadline = task_data["allowed_time"]
	new_task.due_day = today_date + base_deadline
	new_task.progress = 0

	# Convert JSON array to typed Array[String]
	var categories_array: Array[String] = []
	for cat in task_data["categories"]:
		categories_array.append(cat)
	new_task.categories = categories_array

	return new_task
