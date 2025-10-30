extends PanelContainer

signal card_clicked(event_id: String)

var event_data: Dictionary = {}
var _setup_deferred: bool = false

@onready var source_label := $"%SourceLabel"
@onready var message_label := $"%MessageLabel"
@onready var button := $"%Button"

func _ready() -> void:
	button.pressed.connect(_on_button_pressed)

	# If setup was called before _ready, apply it now
	if _setup_deferred:
		_apply_setup()

func setup(p_event_data: Dictionary) -> void:
	"""Initialize card with event data."""
	event_data = p_event_data

	# If nodes aren't ready yet, defer the setup
	if not is_node_ready():
		_setup_deferred = true
		return

	_apply_setup()

func _apply_setup() -> void:
	"""Apply the event data to UI elements."""
	# Get emoji for source type
	var emoji = _get_source_emoji(event_data["source"])
	source_label.text = "%s %s" % [emoji, event_data["source"]]

	# Truncate message for card display
	var message = event_data["message"]
	if message.length() > 50:
		message = message.substr(0, 47) + "..."
	message_label.text = message

func _get_source_emoji(source: String) -> String:
	"""Get emoji icon for source type."""
	match source:
		"Slack":
			return "💬"
		"Email":
			return "📧"
		"Calendar":
			return "📅"
		"Kitchen":
			return "☕"
		"GitHub":
			return "🔧"
		"PagerDuty":
			return "🚨"
		"Browser":
			return "🌐"
		_:
			return "🔔"

func _on_button_pressed() -> void:
	card_clicked.emit(event_data["id"])
