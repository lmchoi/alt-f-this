extends PanelContainer

@onready var job_title := $MarginContainer/VBoxContainer/JobTitleLabel
@onready var salary_label := $"%SalaryLabel"
@onready var bugs_icon := $MarginContainer/VBoxContainer/BugsContainer/BugsIcon
@onready var bugs_value := $"%BugsValue"
@onready var pip_indicator := $"%PIPIndicator"

func _ready():
	# Apply color theme
	job_title.add_theme_color_override("font_color", UIColors.JOB_SILVER)
	salary_label.add_theme_color_override("font_color", UIColors.JOB_INFO_BLUE)
	bugs_icon.add_theme_color_override("font_color", UIColors.JOB_INFO_BLUE)
	bugs_value.add_theme_color_override("font_color", UIColors.JOB_INFO_BLUE)

	GameManager.bugs_changed.connect(_update_bugs)
	GameManager.next_day.connect(_update_payday)
	GameManager.payday_occurred.connect(_on_payday)
	GameManager.pip_warnings_changed.connect(_update_pip_indicator)
	GameManager.promotion_earned.connect(_update_job_title)

	_update_bugs(GameManager.bugs)
	_update_payday(GameManager.day)
	_update_pip_indicator(GameManager.pip_warnings)
	_update_job_title(GameManager.job_level, GameManager.get_job_title(), GameManager.get_current_salary())

func _update_bugs(amount: int):
	bugs_value.text = str(amount)

func _update_pip_indicator(warnings: int):
	if warnings > 0:
		pip_indicator.modulate = Color(1, 0.3, 0.3, 1)  # Red warning color
	else:
		pip_indicator.modulate = Color(1, 1, 1, 0)  # Invisible

func _update_payday(_day: int):
	var days = GameManager.days_until_payday - 1
	var salary = GameManager.get_current_salary()
	if days == 1:
		salary_label.text = "Payday: Tomorrow ($%d)" % salary
	else:
		salary_label.text = "Payday: %d days ($%d)" % [days, salary]

func _on_payday(_amount: int):
	var salary = GameManager.get_current_salary()
	salary_label.text = "Payday: Today!!! ($%d)" % salary

func _update_job_title(new_level: int, new_title: String, new_salary: int):
	job_title.text = "🐵 JOB (%s)" % new_title
