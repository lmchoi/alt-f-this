# TaskManager.gd
extends Node

var _tasks: Array[Task] = []

# Predefined pool of ridiculous tasks
const _BS_TASKS := [
	{
		"description": "Fix CEO's PowerPoint (for the 3rd time)",
		"deadline": 2,
		"complexity": 1,
		"category": "CEO Nonsense"
	},
	{
		"description": "Add blockchain to the to-do app",
		"deadline": 5,
		"complexity": 5,
		"category": "Buzzword Compliance"
	},
	{
		"description": "Printer is 'hacking us' (it's just Jim)",
		"deadline": 3,
		"complexity": 2,
		"category": "IT Firefighting"
	}
]

# Generate a random BS task
func generate_random_task() -> Task:
	var task_data = _BS_TASKS.pick_random()
	var task = Task.new()
	task.description = task_data["description"]
	task.deadline = task_data["deadline"]
	task.complexity = task_data["complexity"]
	task.category = task_data.get("category", "Misc")
	return task

# Add a task to the queue
func add_task(task: Task) -> void:
	_tasks.append(task)

# Get all active tasks
func get_tasks() -> Array[Task]:
	return _tasks.duplicate()

# Mark a task as complete
func complete_task(task_index: int) -> void:
	if task_index < _tasks.size():
		_tasks[task_index].is_completed = true
