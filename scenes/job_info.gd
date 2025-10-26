extends PanelContainer

const COLOR_JOB_GREY = Color(0.75, 0.75, 0.8, 1)    # Header - silver/bright grey
const COLOR_JOB_INFO = Color(0.6, 0.75, 0.85, 1)    # Info - corporate blue

@onready var job_title := $MarginContainer/VBoxContainer/JobTitleLabel
@onready var salary_label := $"%SalaryLabel"
@onready var bugs_icon := $MarginContainer/VBoxContainer/BugsContainer/BugsIcon
@onready var bugs_value := $"%BugsValue"

func _ready():
	# Apply color theme
	job_title.add_theme_color_override("font_color", COLOR_JOB_GREY)
	salary_label.add_theme_color_override("font_color", COLOR_JOB_INFO)
	bugs_icon.add_theme_color_override("font_color", COLOR_JOB_INFO)
	bugs_value.add_theme_color_override("font_color", COLOR_JOB_INFO)

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
