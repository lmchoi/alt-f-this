extends PopupPanel

signal warning_acknowledged()

func show_optics_warning(message: String):
	$WarningMessage.text = message
	popup()

func _on_popup_hide():
	warning_acknowledged.emit()
