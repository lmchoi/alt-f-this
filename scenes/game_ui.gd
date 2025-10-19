extends Node

@onready var day_label := $"%DayLabel"
@onready var work_button := $"%WorkButton" as ActionButton
@onready var slack_button := $"%SlackButton" as ActionButton
@onready var ship_it_button := $"%ShipItButton" as ActionButton
@onready var money_label := $"%MoneyLabel" as MoneyLabel
@onready var salary_label := $"%SalaryLabel"
@onready var ducks_bar := $"%DucksBar"
@onready var bugs_label := $"%BugsLabel"

@onready var deadline_label := $"%DeadlineLabel"
@onready var progress_bar := $"%ProgressBar"

func _ready():
	work_button.pressed.connect(_on_work_button_pressed)
	slack_button.pressed.connect(_on_slack_button_pressed)
	ship_it_button.pressed.connect(_on_ship_it_button_pressed)
	GameManager.money_changed.connect(money_label.update_amount)
	GameManager.salary_changed.connect(_update_salary_label)
	GameManager.ducks_changed.connect(_update_ducks_level)
	GameManager.bugs_changed.connect(_update_bugs_label)
	GameManager.event_occurred.connect(_on_event_occurred)
	GameManager.missed_deadline.connect(_on_deadline_due)
	GameManager.next_day.connect(_on_next_day)
	GameManager.game_over.connect(_on_game_over)
	GameManager.victory.connect(_on_victory)
	GameManager.production_outage_occurred.connect(_on_production_outage)
	GameManager.current_task_updated.connect(_on_current_task_updated)

	$DeadlineDialog.custom_action.connect(_on_deadline_action)
	$OutageDialog.outage_choice.connect(_on_outage_choice)
	GameManager.start_game()

	# Debug: Load test scenario in debug builds
	if OS.is_debug_build():
		_setup_test_scenario()

	_on_next_day(GameManager.day)

func _on_current_task_updated(current_task: Task):
	$"%TaskLabel".text = current_task.title
	_update_complexity_label(current_task.complexity)

func _on_work_button_pressed():
	GameManager.do_work()

func _on_slack_button_pressed():
	GameManager.hustle()

func _on_ship_it_button_pressed():
	if GameManager.current_task.progress < 20:
		# Cheeky punishment for trying to ship nothing
		var cheeky_message = GameManager.get_too_early_message()
		$EventPopup.show_event(cheeky_message)
	else:
		GameManager.ship_it()
	
func _update_ducks_level(new_amount: int):
	ducks_bar.current_ducks = new_amount

func _update_salary_label(new_amount: int):
	salary_label.text = "Salary: $" + str(new_amount)

func _update_bugs_label(new_amount: int):
	bugs_label.text = "🐛 " + str(new_amount)

func _update_complexity_label(complexity: int):
	# Spaghetti code indicator (more spaghetti = more complex)
	var spaghetti = ""
	for i in range(complexity):
		spaghetti += "🍝"
	$"%ComplexityLabel".text = "Complexity: " + spaghetti

func _on_event_occurred(event: Dictionary):
	if event.text != "":
		$EventPopup.show_event(event.text)

func _on_deadline_due():
	$DeadlineDialog.popup()

func _on_game_over(message):
	$GameOverDialog.dialog_text = message
	$GameOverDialog.title = "GAME OVER"
	$GameOverDialog.ok_button_text = "Rage Quit"
	$GameOverDialog.get_cancel_button().hide()
	$GameOverDialog.popup()

func _on_victory(message):
	$GameOverDialog.dialog_text = message
	$GameOverDialog.title = "VICTORY!"
	$GameOverDialog.ok_button_text = "I'm Free!"
	$GameOverDialog.get_cancel_button().hide()
	$GameOverDialog.popup()

func _update_deadline_label(days_left: int):
	if days_left < 0:
		deadline_label.text = str(abs(days_left)) + " days overdue"
	else:
		deadline_label.text = "Due in " + str(days_left) + " days"

func _on_next_day(nth_day: int):
	day_label.text = "Day " + str(nth_day)
	var days_left = GameManager.current_task.due_day - nth_day
	_update_deadline_label(days_left)
	progress_bar.value = GameManager.current_task.progress
	ducks_bar.current_ducks = GameManager.ducks
	GameManager.daily_updates()

func _on_deadline_action(action: String):
	GameManager.process_action(action)
	$DeadlineDialog.hide()

func _on_production_outage(task_name: String):
	$OutageDialog.show_outage(task_name)

func _on_outage_choice(choice: String):
	# For now, just print (no effect yet - Step 1 complete)
	print("Outage choice: %s" % choice)
	# TODO: Wire up to GameManager in Step 2

func _setup_test_scenario():
	"""Debug: Setup test scenario for production outage testing"""
	GameManager.bugs = 60  # High bugs = high outage chance (60 × 0.5% × 3 = 90% daily)
	GameManager.poorly_shipped_tasks = ["Blockchain", "Logo Fix", "Printer Bug"]
	GameManager.money = 2000
	GameManager.ducks = 2
	GameManager.day = 10
	print("🔧 DEBUG TEST SCENARIO LOADED:")
	print("  - Bugs: 60 (high outage chance)")
	print("  - 3 poorly shipped tasks ready to explode")
	print("  - Money: $2000")
	print("  - Ducks: 2")
	print("  - Day: 10")
	print("  → Outage should trigger soon! (~90% chance per day)")
