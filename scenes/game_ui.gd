extends Node

@onready var day_label := $"%DayLabel"
@onready var work_button := $"%WorkButton" as ActionButton
@onready var slack_button := $"%SlackButton" as ActionButton
@onready var money_label := $"%MoneyLabel" as MoneyLabel
@onready var ducks_bar := $"%DucksBar"

@onready var deadline_label := $"%DeadlineLabel"
@onready var progress_bar := $"%ProgressBar"

func _ready():
	work_button.pressed.connect(_on_work_button_pressed)
	slack_button.pressed.connect(_on_slack_button_pressed)
	GameManager.money_changed.connect(money_label.update_amount)
	GameManager.ducks_changed.connect(_update_ducks_level)
	GameManager.event_occurred.connect(_on_event_occurred)
	GameManager.next_day.connect(_on_next_day)
	GameManager.current_task.work_completed.connect(_on_event_occurred)

	_on_next_day(GameManager.day)

func _on_work_button_pressed():
	GameManager.do_work()

func _on_slack_button_pressed():
	GameManager.slack_off()
	
func _update_ducks_level(new_amount: int):
	ducks_bar.current_ducks = new_amount

func _on_event_occurred(event: Dictionary):
	if event.text != "":
		$EventPopup.show_event(event.text)

func _on_next_day(nth_day: int):
	day_label.text = "Day " + str(nth_day)
	var days_left = GameManager.current_task.due_day - nth_day
	deadline_label.text = "Due in " + str(days_left) + " days"
	progress_bar.value = GameManager.current_task.progress
