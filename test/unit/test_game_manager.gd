extends GutTest

# Test GameManager core functionality
# Tests focus on game state, day advancement, and signal emissions

var game_manager: Node

func before_each():
	"""Set up a fresh GameManager instance for each test."""
	game_manager = GameManager.duplicate()
	add_child_autofree(game_manager)

func after_each():
	"""Clean up after each test."""
	if game_manager and is_instance_valid(game_manager):
		game_manager.queue_free()
	game_manager = null

# === DAY ADVANCEMENT TESTS ===

func test_day_advances_on_advance_turn():
	"""Test that calling advance_turn increments the day counter."""
	var initial_day = game_manager.day
	game_manager.current_task = _create_mock_task()

	game_manager.advance_turn()

	assert_eq(game_manager.day, initial_day + 1, "Day should increment by 1")

func test_day_advancement_emits_next_day_signal():
	"""Test that advancing day emits the next_day signal."""
	game_manager.current_task = _create_mock_task()

	watch_signals(game_manager)
	game_manager.advance_turn()

	assert_signal_emitted(game_manager, "next_day", "next_day signal should be emitted")
	assert_signal_emit_count(game_manager, "next_day", 1, "next_day should emit exactly once")

func test_overdue_days_increases_when_past_deadline():
	"""Test that overdue_days increments when day > due_day."""
	game_manager.day = 5
	game_manager.current_task = _create_mock_task()
	game_manager.overdue_days = 0

	game_manager.advance_turn()

	assert_eq(game_manager.overdue_days, 1, "overdue_days should increment when past deadline")

func test_overdue_does_not_increase_before_deadline():
	"""Test that overdue_days does not increment before deadline."""
	game_manager.day = 2
	game_manager.current_task = _create_mock_task()
	game_manager.overdue_days = 0

	game_manager.advance_turn()

	assert_eq(game_manager.overdue_days, 0, "overdue_days should not increment before deadline")

# === BUG MULTIPLIER TESTS ===

func test_bug_multiplier_with_zero_bugs():
	"""Test bug multiplier calculation with no bugs."""
	game_manager.bugs = 0

	var multiplier = game_manager.get_bug_multiplier()

	assert_eq(multiplier, 1.0, "Bug multiplier should be 1.0 with zero bugs")

func test_bug_multiplier_with_50_bugs():
	"""Test bug multiplier calculation with 50 bugs."""
	game_manager.bugs = 50

	var multiplier = game_manager.get_bug_multiplier()

	assert_eq(multiplier, 1.5, "Bug multiplier should be 1.5 with 50 bugs (1.0 + 50*0.01)")

func test_bug_multiplier_with_100_bugs():
	"""Test bug multiplier calculation with 100 bugs."""
	game_manager.bugs = 100

	var multiplier = game_manager.get_bug_multiplier()

	assert_eq(multiplier, 2.0, "Bug multiplier should be 2.0 with 100 bugs")

# === SIGNAL EMISSION TESTS ===
#
#func test_setting_money_emits_signal():
	#"""Test that changing money property emits money_changed signal."""
	#watch_signals(game_manager)
#
	#game_manager.money = 100
#
	#assert_signal_emitted(game_manager, "money_changed", "money_changed signal should be emitted")
	#assert_signal_emitted_with_parameters(game_manager, "money_changed", [100], "Signal should emit new money value")
#
#func test_setting_bugs_emits_signal():
	#"""Test that changing bugs property emits bugs_changed signal."""
	#watch_signals(game_manager)
#
	#game_manager.bugs = 25
#
	#assert_signal_emitted(game_manager, "bugs_changed", "bugs_changed signal should be emitted")
	#assert_signal_emitted_with_parameters(game_manager, "bugs_changed", [25], "Signal should emit new bugs value")
#
#func test_setting_ducks_emits_signal():
	#"""Test that changing ducks property emits ducks_changed signal."""
	#watch_signals(game_manager)
#
	#game_manager.ducks = 5
#
	#assert_signal_emitted(game_manager, "ducks_changed", "ducks_changed signal should be emitted")
	#assert_signal_emitted_with_parameters(game_manager, "ducks_changed", [5], "Signal should emit new ducks value")

# === ADD BUGS TESTS ===

func test_add_bugs_increases_bug_count():
	"""Test that add_bugs properly increments the bugs counter."""
	game_manager.bugs = 10

	game_manager.add_bugs(5)

	assert_eq(game_manager.bugs, 15, "Bugs should increase by 5")

func test_add_bugs_emits_signal():
	"""Test that add_bugs triggers bugs_changed signal."""
	game_manager.bugs = 0
	watch_signals(game_manager)

	game_manager.add_bugs(10)

	assert_signal_emitted(game_manager, "bugs_changed", "bugs_changed should be emitted when bugs are added")

# === PAYDAY TESTS ===

func test_payday_occurs_every_5_days():
	"""Test that payday occurs at the correct interval."""
	game_manager.day = 1
	game_manager.days_until_payday = 1  # Next turn is payday
	game_manager.current_task = _create_mock_task()
	game_manager.job_level = 0  # Junior Dev

	watch_signals(game_manager)
	game_manager.advance_turn()

	assert_signal_emitted(game_manager, "payday_occurred", "payday_occurred signal should be emitted")
	assert_eq(game_manager.days_until_payday, game_manager.PAYDAY_INTERVAL, "days_until_payday should reset to 5")

func test_payday_adds_salary_to_money():
	"""Test that payday increases money by current salary."""
	game_manager.day = 1
	game_manager.days_until_payday = 1  # Next turn is payday
	game_manager.current_task = _create_mock_task()
	game_manager.job_level = 0  # Junior Dev (300 salary)
	game_manager.money = 0

	var expected_salary = game_manager.get_current_salary()
	game_manager.advance_turn()

	assert_eq(game_manager.money, expected_salary, "Money should increase by salary amount")

# === GAME OVER TESTS ===

func test_game_over_when_ducks_reach_zero():
	"""Test that game ends when ducks reach 0."""
	game_manager.ducks = 0
	watch_signals(game_manager)

	var game_ended = game_manager.check_game_over()

	assert_true(game_ended, "Game should end when ducks = 0")
	assert_signal_emitted(game_manager, "game_over", "game_over signal should be emitted")

func test_game_over_when_bugs_reach_max():
	"""Test that game ends when bugs reach 100."""
	game_manager.bugs = 100
	watch_signals(game_manager)

	var game_ended = game_manager.check_game_over()

	assert_true(game_ended, "Game should end when bugs = 100")
	assert_signal_emitted(game_manager, "game_over", "game_over signal should be emitted")

func test_game_over_when_pip_warnings_reach_max():
	"""Test that game ends when PIP warnings reach 2."""
	game_manager.pip_warnings = 2
	watch_signals(game_manager)

	var game_ended = game_manager.check_game_over()

	assert_true(game_ended, "Game should end when pip_warnings = 2")
	assert_signal_emitted(game_manager, "game_over", "game_over signal should be emitted")

func test_victory_when_money_and_side_project_complete():
	"""Test that victory occurs when money >= 5000 and side project = 100."""
	game_manager.money = 5000
	game_manager.side_project.progress = 100
	watch_signals(game_manager)

	var game_ended = game_manager.check_game_over()

	assert_true(game_ended, "Game should end when victory conditions met")
	assert_signal_emitted(game_manager, "victory", "victory signal should be emitted")

func test_no_game_over_when_conditions_not_met():
	"""Test that game continues when no end conditions are met."""
	game_manager.ducks = 3
	game_manager.bugs = 50
	game_manager.money = 1000
	game_manager.pip_warnings = 0

	var game_ended = game_manager.check_game_over()

	assert_false(game_ended, "Game should continue when no end conditions are met")

# === JOB LEVEL TESTS ===

func test_get_current_salary_returns_correct_amount():
	"""Test that salary matches job level."""
	game_manager.job_level = 0
	assert_eq(game_manager.get_current_salary(), 300, "Junior Dev salary should be 300")

	game_manager.job_level = 1
	assert_eq(game_manager.get_current_salary(), 500, "Mid-Level Dev salary should be 500")

	game_manager.job_level = 2
	assert_eq(game_manager.get_current_salary(), 800, "Senior Dev salary should be 800")

func test_get_job_title_returns_correct_title():
	"""Test that job title matches job level."""
	game_manager.job_level = 0
	assert_eq(game_manager.get_job_title(), "Junior Dev", "Level 0 should be Junior Dev")

	game_manager.job_level = 1
	assert_eq(game_manager.get_job_title(), "Mid-Level Dev", "Level 1 should be Mid-Level Dev")

	game_manager.job_level = 2
	assert_eq(game_manager.get_job_title(), "Senior Dev", "Level 2 should be Senior Dev")

# === HELPER FUNCTIONS ===

func _create_mock_task(due_day: int = 5, complexity: int = 1, categories: Array = []) -> Task:
	"""Create a minimal mock task for testing."""
	var task = Task.new()
	task.title = "Test Task"
	task.description = "A test task"
	task.due_day = due_day
	task.complexity = complexity
	task.progress = 0
	#task.categories = categories
	return task
