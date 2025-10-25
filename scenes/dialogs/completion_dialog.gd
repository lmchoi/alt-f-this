extends PopupPanel

func get_gold_plating_message() -> String:
	"""Get random message for trying to work at 100% progress."""
	var messages = [
		"Task is at 100%.\n\nShip it or work on your side project.\nYou're burning daylight.",
		"It's done. What are you doing?\n\nShip it and move on, or hustle.\nThe clock is ticking.",
		"Stop gold-plating.\n\nIt's complete. Ship it or hustle.\nYou're wasting time.",
		"Perfectionism is procrastination.\n\nShip this or build your escape.\nBoth pay better than this.",
		"You're bikeshedding a completed task.\n\nShip it or hustle.\nYour deadline doesn't care.",
		"The CEO won't notice your refactoring.\n\nShip it or work on your side project.\nTime is money.",
	]
	return messages[randi() % messages.size()]

func show_completion():
	$CompletionMessage.text = get_gold_plating_message()
	popup()
