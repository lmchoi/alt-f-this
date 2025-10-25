extends PanelContainer

const COLOR_ESCAPE_GOLD = Color(0.9, 0.7, 0.3, 1)  # Hopeful gold/amber
const COLOR_PROGRESS = Color(0.7, 0.85, 0.7, 1)    # Soft green

@onready var header_label = $MarginContainer/MainContainer/HeaderLabel
@onready var progress_label = %ProgressLabel

func _ready():
	header_label.add_theme_color_override("font_color", COLOR_ESCAPE_GOLD)
	progress_label.add_theme_color_override("font_color", COLOR_PROGRESS)
	GameManager.side_project_updated.connect(_on_side_project_updated)
	_update_display(GameManager.side_project)

func _on_side_project_updated(data: Dictionary):
	_update_display(data)

func _update_display(data: Dictionary):
	header_label.text = "🚀 ESCAPE PLAN: " + data.product_name
	progress_label.text = "Progress: %d%%" % data.progress
