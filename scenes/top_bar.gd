extends PanelContainer

@onready var money_value := $"%MoneyValue"
@onready var ducks_value := $"%DucksValue"
@onready var day_value := $"%DayValue"
@onready var timer_container := $"%TimerContainer"
@onready var timer_value := $"%TimerValue"

func _ready():
	GameManager.money_changed.connect(_update_money)
	GameManager.ducks_changed.connect(_update_ducks)
	GameManager.next_day.connect(_update_day)
	TimedModeController.timer_updated.connect(_update_timer)

	# Initialize with current values
	_update_money(GameManager.money)
	_update_ducks(GameManager.ducks)
	_update_day(GameManager.day)
	_update_timer_visibility()

func _update_money(amount: int):
	money_value.text = "$" + str(amount)

func _update_ducks(amount: int):
	ducks_value.text = str(amount)

func _update_day(day: int):
	day_value.text = "Day " + str(day)

func _update_timer(time_left: float):
	"""Update timer display with current countdown value."""
	var seconds = int(ceil(time_left))
	timer_value.text = str(seconds) + "s"

	# Visual warning when timer is low (< 10 seconds)
	if seconds <= 10 and seconds > 0:
		timer_value.add_theme_color_override("font_color", UIColors.STATUS_RED)
	else:
		timer_value.add_theme_color_override("font_color", Color(0.9, 0.75, 0.3, 1))

func _update_timer_visibility():
	"""Timer is always visible."""
	timer_container.visible = true
