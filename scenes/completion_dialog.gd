extends AcceptDialog

signal completion_choice(choice: String)

func get_gold_plating_message() -> String:
	"""Get random message for trying to work at 100% progress."""
	var messages = [
		"Stop gold-plating.\n\nIt's done. Ship it.",
		"Perfectionism is procrastination.\n\nShip it already.",
		"You're bikeshedding.\n\nIt works. Move on.",
		"'Done' beats 'perfect'.\n\nShip it.",
		"This is scope creep, but you're doing it to yourself.\n\nShip it.",
		"The CEO doesn't care about your refactoring.\n\nShip it.",
		"You're not paid to polish.\n\nShip it.",
		"'Just one more thing' is how projects die.\n\nShip it."
	]
	return messages[randi() % messages.size()]

func _ready():
	get_ok_button().hide()
	custom_action.connect(_on_custom_action)

	# Add choice buttons
	add_button("SHIP & NEW TASK", false, "ship")
	add_button("HUSTLE", false, "hustle")

func show_completion():
	title = "Huh?"
	dialog_text = get_gold_plating_message()

	popup_centered()

func _on_custom_action(action: String):
	completion_choice.emit(action)
	hide()
