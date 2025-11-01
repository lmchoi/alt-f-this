extends GutTest

# Test TaskCard UI component functionality
# Tests focus on active state display and visual indicators

const TaskCardScene = preload("res://scenes/task_card.tscn")

var task_card: PanelContainer
var test_task: Task

func before_each():
	"""Set up a fresh task card for each test."""
	task_card = TaskCardScene.instantiate()
	add_child_autofree(task_card)
	test_task = _create_mock_task()

func after_each():
	"""Clean up after each test."""
	test_task = null

# === ACTIVE STATE TESTS ===

func test_active_label_hidden_when_not_active():
	"""Test that active label is hidden when task is not active."""
	task_card.set_task(test_task)
	task_card.set_active(false, false)

	assert_false(task_card.active_label.visible, "Active label should be hidden when not active")

func test_active_label_hidden_when_active_but_not_progressing():
	"""Test that active label is hidden when task is active but not progressing."""
	task_card.set_task(test_task)
	task_card.set_active(true, false)

	assert_false(task_card.active_label.visible,
		"Active label should be hidden when active but not progressing")

func test_active_label_visible_when_active_and_progressing():
	"""Test that active label shows only when task is both active AND progressing."""
	task_card.set_task(test_task)
	task_card.set_active(true, true)

	assert_true(task_card.active_label.visible,
		"Active label should be visible when active and progressing")

func test_active_label_hidden_when_progressing_but_not_active():
	"""Test that active label doesn't show for progressing state alone."""
	task_card.set_task(test_task)
	task_card.set_active(false, true)

	assert_false(task_card.active_label.visible,
		"Active label should not show when progressing but not active")

# === VISUAL STATE TESTS ===

func test_is_active_flag_set_correctly():
	"""Test that is_active internal flag is set correctly."""
	task_card.set_task(test_task)

	task_card.set_active(true, false)
	assert_true(task_card.is_active, "is_active should be true")

	task_card.set_active(false, false)
	assert_false(task_card.is_active, "is_active should be false")

func test_set_active_triggers_style_update():
	"""Test that setting active state updates card styling."""
	task_card.set_task(test_task)

	# Should not crash when setting active state
	task_card.set_active(true, true)
	assert_not_null(task_card.get_theme_stylebox("panel"),
		"Card should have panel stylebox after setting active")

# === TASK DATA TESTS ===

func test_set_task_updates_display():
	"""Test that setting a task updates the card display."""
	task_card.set_task(test_task)

	assert_eq(task_card.task_title.text, test_task.title,
		"Task title should match task data")

func test_progress_bar_reflects_task_progress():
	"""Test that progress bar value matches task progress."""
	test_task.progress = 50
	task_card.set_task(test_task)

	assert_eq(task_card.progress_bar.value, 50,
		"Progress bar should show 50%")

func test_ship_it_button_disabled_below_min_progress():
	"""Test that SHIP IT button is disabled when progress < 20%."""
	test_task.progress = 15
	task_card.set_task(test_task)

	assert_true(task_card.ship_it_button.disabled,
		"SHIP IT button should be disabled at 15% progress")

func test_ship_it_button_enabled_above_min_progress():
	"""Test that SHIP IT button is enabled when progress >= 20%."""
	test_task.progress = 25
	task_card.set_task(test_task)

	assert_false(task_card.ship_it_button.disabled,
		"SHIP IT button should be enabled at 25% progress")

# === SIGNAL TESTS ===

func test_work_button_emits_signal():
	"""Test that clicking WORK button emits signal with task."""
	task_card.set_task(test_task)
	watch_signals(task_card)

	task_card.work_button.pressed.emit()

	assert_signal_emitted(task_card, "work_pressed",
		"work_pressed signal should be emitted")

func test_ship_it_button_emits_signal():
	"""Test that clicking SHIP IT button emits signal with task."""
	test_task.progress = 50
	task_card.set_task(test_task)
	watch_signals(task_card)

	task_card.ship_it_button.pressed.emit()

	assert_signal_emitted(task_card, "ship_it_pressed",
		"ship_it_pressed signal should be emitted")

# === HELPER FUNCTIONS ===

func _create_mock_task() -> Task:
	"""Create a minimal mock task for testing."""
	var task = Task.new()
	task.task_id = "TEST-001"
	task.title = "Test Task"
	task.description = "A test task"
	task.due_day = 5
	task.complexity = 2
	task.progress = 0
	var categories_array: Array[String] = []
	task.categories = categories_array
	return task
