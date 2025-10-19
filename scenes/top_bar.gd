extends PanelContainer

@onready var money_value := $"%MoneyValue"
@onready var ducks_value := $"%DucksValue"
@onready var bugs_value := $"%BugsValue"
@onready var day_value := $"%DayValue"

func _ready():
	GameManager.money_changed.connect(_update_money)
	GameManager.ducks_changed.connect(_update_ducks)
	GameManager.bugs_changed.connect(_update_bugs)
	GameManager.next_day.connect(_update_day)

	# Initialize with current values
	_update_money(GameManager.money)
	_update_ducks(GameManager.ducks)
	_update_bugs(GameManager.bugs)
	_update_day(GameManager.day)

func _update_money(amount: int):
	money_value.text = "$" + str(amount)

func _update_ducks(amount: int):
	ducks_value.text = str(amount)

func _update_bugs(amount: int):
	bugs_value.text = str(amount)

func _update_day(day: int):
	day_value.text = "Day " + str(day)
