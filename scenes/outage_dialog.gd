extends AcceptDialog

signal outage_choice(choice: String)

var task_name := ""
var buttons_added := false

func _ready():
	get_ok_button().hide()
	custom_action.connect(_on_custom_action)

	# Add buttons once in _ready instead of every show
	add_button("I own this mistake.", false, "responsibility")
	add_button("The intern we just let go.", false, "scapegoat")
	add_button("Impossible product requirements.", false, "systemic")

func show_outage(p_task_name: String):
	task_name = p_task_name

	title = "🚨 PRODUCTION OUTAGE 🚨"
	dialog_text = "Your '%s' feature crashed in production.\n\nWho takes the blame?" % task_name

	popup_centered()

func _on_custom_action(action: String):
	outage_choice.emit(action)
	hide()
