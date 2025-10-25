extends AcceptDialog


func _ready():
	title = "Deadline: Today"
	dialog_text = "Task is due today.\n\nYou're out of time.\n\nShip it now or negotiate an extension.\n(3 days overdue = fired)"

	get_ok_button().hide()

	# Add custom buttons (text, right-aligned, action_id)
	add_button("Ask for Extension", false, "mercy")
	add_button("Ship It Now", false, "duck_it")
