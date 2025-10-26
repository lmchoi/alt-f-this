extends Panel

@onready var title_label := $"%TitleLabel"
@onready var message_label := $"%MessageLabel"
@onready var stats_label := $"%StatsLabel"
@onready var panel_container := $"PanelContainer"

var endings_data: Dictionary = {}
var is_victory: bool = false

func _ready():
	visible = false
	_load_endings()

func _load_endings():
	"""Load endings data from JSON."""
	var json_text = FileAccess.get_file_as_string("res://data/endings.json")
	endings_data = JSON.parse_string(json_text)

func show_game_over(ending_type: String, stats: Dictionary):
	"""Display game over screen with ending type and stats."""
	var ending = endings_data.get(ending_type, {"title": "GAME OVER", "message": "Unknown ending"})

	is_victory = false
	_apply_theme()

	title_label.text = ending["title"]
	message_label.text = ending["message"]
	stats_label.text = _format_stats(stats)
	visible = true

func show_victory(stats: Dictionary):
	"""Display victory screen with stats."""
	var ending = endings_data.get("victory_escape", {"title": "ESCAPED!", "message": "You're free!"})

	is_victory = true
	_apply_theme()

	title_label.text = ending["title"]
	message_label.text = ending["message"]
	stats_label.text = _format_stats(stats)
	visible = true

func _format_stats(stats: Dictionary) -> String:
	"""Format stats dictionary into display text."""
	var lines = [
		"Tasks completed: %d" % stats.get("tasks_completed", 0),
		"Days survived: %d" % stats.get("days_survived", 0),
		"Bugs: %d" % stats.get("bugs", 0),
		"Ducks: %d" % stats.get("ducks", 0),
		"Side Project: %d%%" % stats.get("side_project_progress", 0),
		"Money: £%d" % stats.get("money", 0),
		"Clean Code Tokens: %d" % stats.get("clean_code_tokens", 0)
	]
	return "\n".join(lines)

func _apply_theme():
	"""Apply victory or defeat theme styling."""
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.08, 0.08, 0.12, 1)  # Core UI blue-tint background
	style.border_width_left = 3
	style.border_width_top = 3
	style.border_width_right = 3
	style.border_width_bottom = 3
	style.corner_radius_top_left = 6
	style.corner_radius_top_right = 6
	style.corner_radius_bottom_left = 6
	style.corner_radius_bottom_right = 6
	style.content_margin_left = 20
	style.content_margin_top = 20
	style.content_margin_right = 20
	style.content_margin_bottom = 20

	if is_victory:
		# Gold theme for victory
		style.border_color = Color(0.9, 0.75, 0.3, 1)
		title_label.add_theme_color_override("font_color", Color(0.9, 0.75, 0.3, 1))
	else:
		# Red theme for defeat
		style.border_color = Color(0.8, 0.2, 0.2, 1)
		title_label.add_theme_color_override("font_color", Color(0.8, 0.2, 0.2, 1))

	panel_container.add_theme_stylebox_override("panel", style)
