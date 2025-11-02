extends GutTest

# Test InterruptionManager timer functionality
# Tests focus on timer countdown, timeout handling, and stat tracking

var interruption_manager: Node

func before_each():
	"""Set up InterruptionManager for each test."""
	interruption_manager = InterruptionManager
	# Reset stats
	interruption_manager.interruptions_total = 0
	interruption_manager.interruptions_missed = 0
	# Clear active interruptions
	interruption_manager._active_interruptions.clear()

func after_each():
	"""Clean up after each test."""
	# Clear active interruptions
	interruption_manager._active_interruptions.clear()

# === TIMER INITIALIZATION TESTS ===

func test_interruption_has_timer_on_trigger():
	"""Test that triggered interruptions have a timer_remaining field."""
	var test_event = _create_test_interruption()

	assert_true(test_event.has("timer_remaining"), "Event should have timer_remaining field")
	assert_eq(test_event["timer_remaining"], interruption_manager.INTERRUPTION_TIMER_DURATION,
		"Timer should start at INTERRUPTION_TIMER_DURATION")

func test_interruptions_total_increments_on_trigger():
	"""Test that interruptions_total increments when interruption is triggered."""
	var initial_count = interruption_manager.interruptions_total
	_create_test_interruption()

	assert_eq(interruption_manager.interruptions_total, initial_count + 1,
		"interruptions_total should increment by 1")

# === TIMER COUNTDOWN TESTS ===

func test_timer_counts_down():
	"""Test that timer_remaining decreases over time."""
	var event = _create_test_interruption()
	var initial_timer = event["timer_remaining"]

	# Start timed mode properly
	interruption_manager._is_active = true
	TimedModeController.start_timer(60.0)

	# Simulate 1 second passing
	interruption_manager._process(1.0)

	assert_lt(event["timer_remaining"], initial_timer,
		"Timer should decrease after _process()")

func test_multiple_timers_countdown_simultaneously():
	"""Test that multiple interruptions count down independently."""
	var event1 = _create_test_interruption()
	var event2 = _create_test_interruption()

	# Start timed mode properly
	interruption_manager._is_active = true
	TimedModeController.start_timer(60.0)

	# Simulate 2 seconds passing
	interruption_manager._process(2.0)

	assert_lt(event1["timer_remaining"], interruption_manager.INTERRUPTION_TIMER_DURATION,
		"Event 1 timer should decrease")
	assert_lt(event2["timer_remaining"], interruption_manager.INTERRUPTION_TIMER_DURATION,
		"Event 2 timer should decrease")

# === TIMEOUT HANDLING TESTS ===

func test_interruption_removed_on_timeout():
	"""Test that interruption is removed from active list when timer expires."""
	var event = _create_test_interruption()
	event["timer_remaining"] = 0.1  # Almost expired

	var initial_count = interruption_manager._active_interruptions.size()

	# Start timed mode and process enough to trigger timeout
	interruption_manager._is_active = true
	TimedModeController.start_timer(60.0)
	interruption_manager._process(0.2)

	assert_eq(interruption_manager._active_interruptions.size(), initial_count - 1,
		"Active interruptions should decrease by 1")

func test_missed_stat_increments_on_timeout():
	"""Test that interruptions_missed increments when timeout occurs."""
	var event = _create_test_interruption()
	event["timer_remaining"] = 0.1

	var initial_missed = interruption_manager.interruptions_missed

	# Start timed mode and trigger timeout
	interruption_manager._is_active = true
	TimedModeController.start_timer(60.0)
	interruption_manager._process(0.2)

	assert_eq(interruption_manager.interruptions_missed, initial_missed + 1,
		"interruptions_missed should increment by 1")

func test_decline_consequences_applied_on_timeout():
	"""Test that decline consequences are applied when timeout occurs."""
	var event = _create_test_interruption_with_consequences()
	event["timer_remaining"] = 0.1

	var initial_ducks = GameManager.ducks

	# Start timed mode and trigger timeout
	interruption_manager._is_active = true
	TimedModeController.start_timer(60.0)
	interruption_manager._process(0.2)

	# Check that ducks decreased (consequences had -1 duck)
	assert_lt(GameManager.ducks, initial_ducks,
		"Ducks should decrease due to timeout consequences")

func test_multiple_simultaneous_timeouts():
	"""Test that multiple interruptions timing out simultaneously all apply consequences."""
	var event1 = _create_test_interruption_with_consequences()
	var event2 = _create_test_interruption_with_consequences()
	var event3 = _create_test_interruption_with_consequences()

	# Set all to expire soon
	event1["timer_remaining"] = 0.1
	event2["timer_remaining"] = 0.1
	event3["timer_remaining"] = 0.1

	var initial_missed = interruption_manager.interruptions_missed

	# Start timed mode and trigger all timeouts
	interruption_manager._is_active = true
	TimedModeController.start_timer(60.0)
	interruption_manager._process(0.2)

	assert_eq(interruption_manager.interruptions_missed, initial_missed + 3,
		"All 3 interruptions should be counted as missed")
	assert_eq(interruption_manager._active_interruptions.size(), 0,
		"All interruptions should be removed")

# === HELPER FUNCTIONS ===

func _create_test_interruption() -> Dictionary:
	"""Create a test interruption and add it to active interruptions."""
	var event = {
		"id": "test_" + str(randi()),
		"type": "task_offer",
		"source": "Test Source",
		"message": "Test message",
		"task_data": {},
		"consequences": {},
		"timer_remaining": interruption_manager.INTERRUPTION_TIMER_DURATION
	}

	interruption_manager._active_interruptions.append(event)
	interruption_manager.interruptions_total += 1

	return event

func _create_test_interruption_with_consequences() -> Dictionary:
	"""Create a test interruption with consequences."""
	var event = _create_test_interruption()
	event["consequences"] = {
		"ducks": -1,
		"message": "Test consequence"
	}
	return event
