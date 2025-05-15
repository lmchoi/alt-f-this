extends Label

@export var current_ducks: int = 7 :
	set(value):
		current_ducks = value
#		TODO game over if no ducks left
		update_text()

# TODO change to numbers if 10 or more ducks
@export var duck_emoji: String = "🦆"

func _ready():
	update_text()
	
func update_text():
	var progress_text = ""
	
	for i in current_ducks:
		progress_text += duck_emoji
	
	set_text(progress_text)
