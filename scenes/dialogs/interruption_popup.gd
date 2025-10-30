extends PopupPanel

signal interruption_dismissed(event_id: String)

var current_event_id: String = ""

func _ready() -> void:
	popup_hide.connect(_on_popup_hide)

func show_interruption(event_data: Dictionary) -> void:
	"""Show interruption popup with event details."""
	current_event_id = event_data["id"]
	$"%MessageLabel".text = event_data["message"]
	popup()

func _on_popup_hide() -> void:
	interruption_dismissed.emit(current_event_id)
