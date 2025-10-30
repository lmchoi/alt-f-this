extends Node

# Signals
signal interruption_triggered(event_data: Dictionary)
signal interruption_resolved(consequence: Dictionary)

# Interruption state
var _events: Array = []
var _active_interruptions: Array[Dictionary] = []  # Stack of active interruptions
var _time_until_next: float = 0.0
var _is_active: bool = false  # Only active in timed mode
var current_interruption: String = ""  # ID of interruption currently being viewed (blocks progress)

# Timing constants
const BASE_INTERRUPTION_INTERVAL = 10.0  # Base time in seconds
const INTERVAL_VARIANCE = 5.0  # +/- variance

func _ready() -> void:
	print("InterruptionManager: Ready")

func _process(delta: float) -> void:
	if not _is_active or not TimedModeController.is_timer_running():
		return

	_time_until_next -= delta

	if _time_until_next <= 0.0:
		trigger_random_interruption()
		schedule_next_interruption()

func start_interruptions() -> void:
	"""Start triggering interruptions (called when timed mode starts)."""
	_is_active = true
	schedule_next_interruption()
	print("🚨 Interruption system activated")

func stop_interruptions() -> void:
	"""Stop triggering interruptions (called when timed mode ends)."""
	_is_active = false
	_active_interruptions.clear()
	print("🚨 Interruption system deactivated")

func schedule_next_interruption() -> void:
	"""Schedule the next random interruption."""
	var variance = randf_range(-INTERVAL_VARIANCE, INTERVAL_VARIANCE)
	_time_until_next = BASE_INTERRUPTION_INTERVAL + variance

func trigger_random_interruption() -> void:
	"""Trigger a placeholder interruption to block progress."""
	# Simple placeholder - just blocks progress until dismissed
	var event = {
		"id": "placeholder",
		"source": "Interruption",
		"message": "Something needs your attention"
	}
	_active_interruptions.append(event)
	interruption_triggered.emit(event)

func dismiss_interruption(event_id: String) -> void:
	"""Dismiss an interruption - no consequences, just unblocks progress."""
	# Find and remove the event from active stack
	for e in _active_interruptions:
		if e["id"] == event_id:
			_active_interruptions.erase(e)
			break

func has_active_interruptions() -> bool:
	"""Check if there are any unresolved interruptions."""
	return _active_interruptions.size() > 0

func get_active_interruptions() -> Array[Dictionary]:
	"""Get list of all active interruptions."""
	return _active_interruptions
