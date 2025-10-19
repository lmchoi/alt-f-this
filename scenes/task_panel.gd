extends PanelContainer

@onready var task_label := $"%TaskLabel"
@onready var complexity_label := $"%ComplexityLabel"
@onready var deadline_label := $"%DeadlineLabel"
@onready var progress_bar := $"%ProgressBar"
@onready var salary_label := $"%SalaryLabel"

func _ready():
	GameManager.current_task_updated.connect(_on_current_task_updated)
	GameManager.next_day.connect(_on_next_day)
	GameManager.salary_changed.connect(_update_salary)
	GameManager.task_progress_changed.connect(_update_progress)

	# Initialize with current values
	if GameManager.current_task:
		_on_current_task_updated(GameManager.current_task)
		_on_next_day(GameManager.day)
	_update_salary(GameManager.salary)

func _on_current_task_updated(current_task: Task):
	task_label.text = current_task.title
	_update_complexity_label(current_task.complexity)

func _on_next_day(nth_day: int):
	var days_left = GameManager.current_task.due_day - nth_day
	_update_deadline_label(days_left)
	progress_bar.value = GameManager.current_task.progress

func _update_complexity_label(complexity: int):
	# Spaghetti code indicator (more spaghetti = more complex)
	var spaghetti = ""
	for i in range(complexity):
		spaghetti += "🍝"
	complexity_label.text = "Complexity: " + spaghetti

func _update_deadline_label(days_left: int):
	if days_left < 0:
		deadline_label.text = str(abs(days_left)) + " days overdue"
	else:
		deadline_label.text = "Due in " + str(days_left) + " days"

func _update_salary(amount: int):
	salary_label.text = "Salary: £" + str(amount)

func _update_progress(progress: float):
	progress_bar.value = progress
