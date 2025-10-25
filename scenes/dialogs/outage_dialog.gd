extends AcceptDialog

signal outage_choice(choice: String)

var task_name := ""

func _ready():
	get_ok_button().hide()

	$VBoxContainer/ResponsibilityButton.pressed.connect(_on_responsibility_pressed)
	$VBoxContainer/ScapegoatButton.pressed.connect(_on_scapegoat_pressed)
	$VBoxContainer/SystemicButton.pressed.connect(_on_systemic_pressed)

func show_outage(p_task_name: String):
	task_name = p_task_name

	title = "🚨 PRODUCTION OUTAGE 🚨"
	$VBoxContainer/MessageLabel.text = "Your '%s' feature crashed in production.\n\nWho takes the blame?" % task_name

	popup_centered()

func _on_responsibility_pressed():
	outage_choice.emit("responsibility")
	hide()

func _on_scapegoat_pressed():
	outage_choice.emit("scapegoat")
	hide()

func _on_systemic_pressed():
	outage_choice.emit("systemic")
	hide()
