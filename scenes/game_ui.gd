extends Node

@onready var work_button := $ActionButtons/WorkButton as ActionButton
@onready var money_label := $StatusBar/MoneyLabel as MoneyLabel
@onready var chaos_bar := $StatusBar/ChaosBar

func _ready():
	work_button.pressed.connect(_on_work_button_pressed)	
	PlayerState.money_changed.connect(money_label.update_amount)
	PlayerState.chaos_changed.connect(_update_chaos_level)

func _on_work_button_pressed():
#	// TODO depends on the job
	PlayerState.earn_money(10)
	PlayerState.increase_chaos(5)

func _update_chaos_level(new_amount: int):
	chaos_bar.value = new_amount
