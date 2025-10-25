extends PanelContainer

@onready var header_label = $MarginContainer/MainContainer/HeaderLabel
@onready var progress_label = %ProgressLabel

func _ready():
	GameManager.side_project_updated.connect(_on_side_project_updated)
	_update_display(GameManager.side_project)

func _on_side_project_updated(data: Dictionary):
	_update_display(data)

func _update_display(data: Dictionary):
	header_label.text = data.product_name
	progress_label.text = "Progress: %d%%" % data.progress
