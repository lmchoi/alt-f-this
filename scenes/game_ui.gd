extends Node

@onready var work_button := $ActionPanel/ActionButtons/WorkButtonContainer/WorkButton as ActionButton

func _ready():
	work_button.pressed.connect(_on_work_button_pressed)

func _on_work_button_pressed():
	PlayerState.earn_money(10)
