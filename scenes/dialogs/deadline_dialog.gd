extends AcceptDialog


func _ready():
	title = "Deadline Police!"
	dialog_text = "THE DEADLINE POLICE ARE HERE! What will you do?"
	
	get_ok_button().hide()
	
	# Add custom buttons (text, right-aligned, action_id)
	add_button("Beg for Mercy", false, "mercy")  
	add_button("Duck It!", false, "duck_it")
