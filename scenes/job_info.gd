extends PanelContainer

@onready var job_title := $MarginContainer/VBoxContainer/JobTitleLabel
@onready var salary_label := $"%SalaryLabel"
@onready var bugs_icon := $MarginContainer/VBoxContainer/StatusContainer/BugsIcon
@onready var bugs_value := $"%BugsValue"
@onready var pip_indicator := $"%PIPIndicator"
@onready var promotion_progress_bar := $"%PromotionProgressBar"

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
	GameManager.current_task_updated.connect(_update_promotion_progress)

	_update_bugs(GameManager.bugs)
	_update_payday(GameManager.day)
	_update_pip_indicator(GameManager.pip_warnings)
	_update_job_title(GameManager.job_level, GameManager.get_job_title(), GameManager.get_current_salary())
	_update_promotion_progress(null)

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
	_update_promotion_progress(null)  # Refresh after promotion

func _update_promotion_progress(_task):
	var tasks = GameManager.completed_tasks
	var max_level = GameManager.JOB_TITLES.size() - 1

	# Hide progress bar if at max level
	if GameManager.job_level >= max_level:
		promotion_progress_bar.visible = false
		return

	promotion_progress_bar.visible = true

	# Calculate progress within current level (0-10)
	var progress_in_level = tasks % GameManager.TASKS_PER_PROMOTION

	promotion_progress_bar.value = progress_in_level
