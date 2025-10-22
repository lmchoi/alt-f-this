extends Panel

@onready var title_label := $"%TitleLabel"
@onready var message_label := $"%MessageLabel"
@onready var stats_label := $"%StatsLabel"
@onready var button := $"%ActionButton"

var endings_data: Dictionary = {}

signal action_pressed

func _ready():
	button.pressed.connect(_on_button_pressed)
	visible = false
	_load_endings()

func _load_endings():
	"""Load endings data from JSON."""
	var json_text = FileAccess.get_file_as_string("res://data/endings.json")
	endings_data = JSON.parse_string(json_text)

func show_game_over(ending_type: String, stats: Dictionary):
	"""Display game over screen with ending type and stats."""
	var ending = endings_data.get(ending_type, {"title": "GAME OVER", "message": "Unknown ending"})

	title_label.text = ending["title"]
	message_label.text = ending["message"]
	stats_label.text = _format_stats(stats)
	button.text = "Rage Quit"
	visible = true

func show_victory(stats: Dictionary):
	"""Display victory screen with stats."""
	var ending = endings_data.get("victory", {"title": "VICTORY!", "message": "You escaped!"})

	title_label.text = ending["title"]
	message_label.text = ending["message"]
	stats_label.text = _format_stats(stats)
	button.text = "I'm Free!"
	visible = true

func _format_stats(stats: Dictionary) -> String:
	"""Format stats dictionary into display text."""
	return "Tasks completed: %d\nDays survived: %d\nBugs: %d\nDucks: %d" % [
		stats.get("tasks_completed", 0),
		stats.get("days_survived", 0),
		stats.get("bugs", 0),
		stats.get("ducks", 0)
	]

func _on_button_pressed():
	action_pressed.emit()
	get_tree().quit()
