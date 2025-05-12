extends Node

@onready var work_button := $ActionButtons/WorkButton as ActionButton
@onready var money_label := $StatusBar/MoneyLabel as MoneyLabel

func _ready():
	work_button.pressed.connect(_on_work_button_pressed)	
	PlayerState.money_changed.connect(money_label.update_amount)

func _on_work_button_pressed():
	PlayerState.earn_money(10)
