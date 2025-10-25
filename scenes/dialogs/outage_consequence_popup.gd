extends PopupPanel

signal consequence_dismissed

func _ready():
	popup_hide.connect(_on_popup_hide)

func show_consequence(text: String):
	$ConsequenceMessage.text = text
	popup()

func _on_popup_hide():
	consequence_dismissed.emit()
