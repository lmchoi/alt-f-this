class_name ActionButton
extends Button

# Configuration variables
@export var cooldown_duration := 0.2

func _ready():
	pressed.connect(_trigger_feedback)

func _trigger_feedback():
	disabled = true
	await get_tree().create_timer(cooldown_duration).timeout
	disabled = false
