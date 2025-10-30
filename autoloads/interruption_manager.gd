extends Node

# Signals
signal interruption_triggered(event_data: Dictionary)
signal interruption_resolved(consequence: Dictionary)

# Interruption state
var _events: Array = []
var _active_interruptions: Array[Dictionary] = []  # Stack of active interruptions
var _is_active: bool = false  # Only active in timed mode

func _ready() -> void:
	print("InterruptionManager: Ready")

func start_interruptions() -> void:
	"""Start triggering interruptions (called when timed mode starts)."""
	_is_active = true
	print("🚨 Interruption system activated")

func stop_interruptions() -> void:
	"""Stop triggering interruptions (called when timed mode ends)."""
	_is_active = false
	_active_interruptions.clear()
	print("🚨 Interruption system deactivated")

func has_active_interruptions() -> bool:
	"""Check if there are any unresolved interruptions."""
	return _active_interruptions.size() > 0

func get_active_interruptions() -> Array[Dictionary]:
	"""Get list of all active interruptions."""
	return _active_interruptions
