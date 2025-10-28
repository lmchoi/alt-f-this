extends Node

# Signals
signal timer_updated(time_left: float)
signal timer_expired()

# Timer state
var time_remaining: float = 0.0
var is_running: bool = false
var is_paused: bool = false

func _process(delta: float) -> void:
	if not is_running or is_paused:
		return

	time_remaining -= delta
	timer_updated.emit(time_remaining)

	# Pass delta to GameManager for incremental work processing
	GameManager.process_game_tick(delta)

	if time_remaining <= 0.0:
		time_remaining = 0.0
		is_running = false
		timer_expired.emit()

func start_timer(duration: float) -> void:
	"""Start a new timer countdown."""
	time_remaining = duration
	is_running = true
	is_paused = false
	timer_updated.emit(time_remaining)

func pause_timer() -> void:
	"""Pause the timer without resetting."""
	is_paused = true

func resume_timer() -> void:
	"""Resume a paused timer."""
	is_paused = false

func stop_timer() -> void:
	"""Stop and reset the timer."""
	is_running = false
	is_paused = false
	time_remaining = 0.0
	timer_updated.emit(time_remaining)

func reset_timer(duration: float) -> void:
	"""Reset timer to full duration (for new day/task)."""
	time_remaining = duration
	is_running = true
	is_paused = false
	timer_updated.emit(time_remaining)

func get_time_remaining() -> float:
	"""Get current time remaining in seconds."""
	return time_remaining

func is_timer_running() -> bool:
	"""Check if timer is actively counting down."""
	return is_running and not is_paused
