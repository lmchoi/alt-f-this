extends Node

# Signals
signal interruption_triggered(event_data: Dictionary)
signal interruption_resolved(consequence: Dictionary)
signal interruption_timed_out(event_id: String)  # Emitted when interruption timer expires

# Interruption state
var _events: Array = []
var _active_interruptions: Array[Dictionary] = []  # Stack of active interruptions
var _time_until_next: float = 0.0
var _is_active: bool = false  # Only active in timed mode
var current_interruption: String = ""  # ID of interruption currently being viewed (blocks progress)

# Loaded interruption data
var interruption_templates: Dictionary = {}

# Timing constants
const BASE_INTERRUPTION_INTERVAL = 30.0  # Base time in seconds
const INTERVAL_VARIANCE = 5.0  # +/- variance
const INTERRUPTION_TIMER_DURATION = 20.0  # Seconds before interruption times out

# Tracking stats
var interruptions_total: int = 0      # All interruptions triggered
var interruptions_missed: int = 0     # Timed out without response

func _ready() -> void:
	_load_interruption_data()
	print("InterruptionManager: Ready")

func _process(delta: float) -> void:
	if not _is_active or not TimedModeController.is_timer_running():
		return

	# Countdown to next interruption spawn
	_time_until_next -= delta

	if _time_until_next <= 0.0:
		trigger_random_interruption()
		schedule_next_interruption()

	# Countdown timers on active interruptions
	var timed_out_interruptions: Array[Dictionary] = []
	for event in _active_interruptions:
		event["timer_remaining"] -= delta

		if event["timer_remaining"] <= 0.0:
			timed_out_interruptions.append(event)

	# Handle timeouts (auto-decline and remove)
	for event in timed_out_interruptions:
		handle_interruption_timeout(event)

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

func _load_interruption_data() -> void:
	"""Load interruption templates from JSON file."""
	var file = FileAccess.open("res://data/interruptions.json", FileAccess.READ)
	if file:
		var json_text = file.get_as_text()
		var json = JSON.new()
		var error = json.parse(json_text)
		if error == OK:
			interruption_templates = json.data
			print("✅ Loaded %d interruption templates" % interruption_templates.get("task_offers", []).size())
		else:
			push_error("Failed to parse interruptions.json: " + json.get_error_message())
		file.close()
	else:
		push_error("Failed to open interruptions.json")

func trigger_random_interruption() -> void:
	"""Trigger a random task offer interruption."""
	var offers = interruption_templates.get("task_offers", [])
	if offers.is_empty():
		push_error("No interruption templates loaded!")
		return

	# Pick a random offer
	var offer = offers[randi() % offers.size()]

	# Pick a random message variant
	var message = offer["messages"][randi() % offer["messages"].size()]

	# Build the event data
	var event = {
		"id": offer["id"] + "_" + str(randi()),  # Make unique with random suffix
		"type": "task_offer",
		"source": offer["source"],
		"message": message,
		"task_data": offer["task"],
		"consequences": offer["decline_consequences"],
		"timer_remaining": INTERRUPTION_TIMER_DURATION  # Countdown timer
	}

	_active_interruptions.append(event)
	interruptions_total += 1
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

func handle_interruption_timeout(event: Dictionary) -> void:
	"""Handle when an interruption timer expires - auto-apply decline consequences."""
	print("⏰ Interruption timed out: %s" % event["id"])

	var event_id = event["id"]

	# Apply decline consequences
	if event.has("consequences"):
		var consequences = event["consequences"]

		# Apply ducks penalty
		if consequences.has("ducks"):
			GameManager.ducks += consequences["ducks"]  # Note: already negative in JSON

		# Apply bugs penalty
		if consequences.has("bugs"):
			GameManager.bugs += consequences["bugs"]

		# Show consequence message as an event
		if consequences.has("message"):
			GameManager.event_occurred.emit({
				"text": "[IGNORED] " + consequences["message"],
				"money": 0,
				"ducks": 0
			})

	# Track missed interruption
	interruptions_missed += 1

	# Remove from active interruptions
	_active_interruptions.erase(event)

	# Notify UI to remove the card
	interruption_timed_out.emit(event_id)
