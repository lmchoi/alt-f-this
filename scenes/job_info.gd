extends PanelContainer

@onready var salary_label := $"%SalaryLabel"

func _ready():
	GameManager.next_day.connect(_update_payday)
	GameManager.payday_occurred.connect(_on_payday)

	# Initialize with current value
	_update_payday(GameManager.day)

func _update_payday(_day: int):
	var days = GameManager.days_until_payday
	if days == 1:
		salary_label.text = "Payday: Tomorrow (£500)"
	else:
		salary_label.text = "Payday: %d days (£500)" % days

func _on_payday(_amount: int):
	_update_payday(GameManager.day)
