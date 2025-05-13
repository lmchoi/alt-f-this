extends Node

@onready var work_button := $ActionButtons/WorkButton as ActionButton
@onready var slack_button := $ActionButtons/SlackButton as ActionButton
@onready var money_label := $StatusBar/MoneyLabel as MoneyLabel
@onready var chaos_bar := $StatusBar/ChaosBar

func _ready():
	work_button.pressed.connect(_on_work_button_pressed)
	slack_button.pressed.connect(_on_slack_button_pressed)
	GameManager.money_changed.connect(money_label.update_amount)
	GameManager.chaos_changed.connect(_update_chaos_level)
	GameManager.event_occurred.connect(_on_event_occurred)

func _on_work_button_pressed():
	GameManager.do_work()

func _on_slack_button_pressed():
	# TODO more generic function to update chaos
	# TODO can't go below 0
	GameManager.increase_chaos(-10)
	$EventPopup.show_event("Slacker")
	
func _update_chaos_level(new_amount: int):
	chaos_bar.value = new_amount

func _on_event_occurred(event: Dictionary):
	if event.text != "":
		$EventPopup.show_event(event.text)
