extends PopupPanel

func show_event(text: String):
  $EventMessage.text = text
  popup_centered()
