extends PanelContainer

@onready var salary_label := $"%SalaryLabel"

func _ready():
	GameManager.salary_changed.connect(_update_salary)

	# Initialize with current value
	_update_salary(GameManager.salary)

func _update_salary(amount: int):
	salary_label.text = "Salary: £" + str(amount)
