extends PanelContainer

@onready var salary_label := $"%SalaryLabel"
@onready var bugs_value := $"%BugsValue"

func _ready():
	GameManager.bugs_changed.connect(_update_bugs)
	GameManager.next_day.connect(_update_payday)
	GameManager.payday_occurred.connect(_on_payday)

	_update_bugs(GameManager.bugs)
	_update_payday(GameManager.day)

func _update_bugs(amount: int):
	bugs_value.text = str(amount)

func _update_payday(_day: int):
	var days = GameManager.days_until_payday - 1
	if days == 1:
		salary_label.text = "Payday: Tomorrow (£500)"
	else:
		salary_label.text = "Payday: %d days (£500)" % days

func _on_payday(_amount: int):
	salary_label.text = "Payday: Today!!! (£500)"
