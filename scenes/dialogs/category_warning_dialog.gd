extends PopupPanel

signal warning_acknowledged()

func _ready():
	popup_hide.connect(_on_popup_hide)

func show_warning(message: String):
	$WarningMessage.text = message
	popup()

func _on_popup_hide():
	warning_acknowledged.emit()
