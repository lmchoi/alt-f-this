extends PopupPanel

func show_warning(text: String):
	$WarningMessage.text = text
	popup()
