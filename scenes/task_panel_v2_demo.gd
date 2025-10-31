extends Control

func _ready() -> void:
	# Create a test task
	var test_task = Task.new()
	test_task.title = "Update Slack Status"
	test_task.description = "Set status to 'thriving' and upload a professional headshot"
	test_task.complexity = 2
	test_task.due_day = 3  # Due on day 3 (so 2 days away from day 1)
	test_task.progress = 41.0

	GameManager.current_task = test_task
	GameManager.bugs = 15
	GameManager.day = 1  # Set current day to 1

	# Connect signals for testing
	var panel = $CenterContainer/TaskPanelV2
	panel.work_pressed.connect(_on_work_pressed)
	panel.ship_it_pressed.connect(_on_ship_it_pressed)

	print("=== TaskPanelV2 Demo Started ===")
	print("Click WORK to increase progress by 10%")
	print("Click SHIP IT to complete task (unlocks at 20%)")

func _on_work_pressed() -> void:
	print("WORK pressed - increasing progress")
	GameManager.current_task.progress += 10.0
	GameManager.current_task.progress = min(100.0, GameManager.current_task.progress)

	# Manually trigger update (normally GameManager would emit signal)
	GameManager.current_task_updated.emit(GameManager.current_task)

	print("Progress now: %.0f%%" % GameManager.current_task.progress)

func _on_ship_it_pressed() -> void:
	print("SHIP IT pressed - task would complete at %.0f%%" % GameManager.current_task.progress)
	print("Bugs that would be added: %.0f" % ((100.0 - GameManager.current_task.progress) / 10.0))
