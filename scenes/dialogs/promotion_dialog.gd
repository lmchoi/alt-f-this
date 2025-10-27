extends PopupPanel

signal promotion_dismissed()

@onready var title_label := $VBox/TitleLabel
@onready var message_label := $VBox/MessageLabel
@onready var continue_button := $VBox/ContinueButton

func _ready():
	continue_button.pressed.connect(_on_continue_pressed)

func show_promotion(new_title: String, new_salary: int):
	title_label.text = "🎉 PROMOTION! 🎉"
	message_label.text = "You've been promoted to %s!\n\nNew salary: $%d per payday" % [new_title, new_salary]
	popup_centered()

func _on_continue_pressed():
	hide()
	promotion_dismissed.emit()
