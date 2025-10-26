extends Node

# Action outcome types
enum ActionOutcome {
	NORMAL,              # Advance turn normally
	DO_NOTHING,
}

# Game balance constants
const MAX_PIP_WARNINGS = 2
const MAX_BLAMES = 3
const OUTAGE_CHANCE_PER_BUG = 0.005
const BUGS_PER_INCOMPLETE_PERCENT = 10.0
const POOR_QUALITY_THRESHOLD = 50
const MIN_SHIP_PROGRESS = 20
const MAX_BUGS_GAME_OVER = 100
const VICTORY_MONEY_GOAL = 5000
const HUSTLE_PAY = 200
const PAYDAY_SALARY = 500
const PAYDAY_INTERVAL = 5
const MAX_OVERDUE_DAYS = 3

signal next_day(nth)
signal money_changed(amount)
signal salary_changed(amount)
signal ducks_changed(amount)
signal bugs_changed(amount)
signal event_occurred(event_data)
signal game_over(ending_type: String, stats: Dictionary)
signal victory(stats: Dictionary)
signal production_outage_occurred(task_name)
signal outage_consequence(text)
signal current_task_updated(task)
signal task_progress_changed(progress)
signal payday_occurred(amount)
signal task_completed_awaiting_choice()
signal side_project_updated(side_project_data)
signal pip_warnings_changed(count)

var current_task: Task:
	set(value):
		current_task = value
		if current_task:
			current_task_updated.emit(current_task)

var days_at_100_percent := 0  # Track how long task has been sitting at 100%

var day := 1:
	set(value):
		day = value
		next_day.emit(day)

var days_until_payday := 5
var overdue_days := 0  # Track how many days past deadline

var job_level := 0  # Index into JOB_TITLES/JOB_SALARIES
var completed_tasks := 0

var money := 0:
	set(value):
		money = value
		money_changed.emit(money)

var salary := 100:
	set(value):
		salary = value
		salary_changed.emit(salary)

var ducks := 3:
	set(value):
		ducks = value
		ducks_changed.emit(ducks)

var bugs := 0:
	set(value):
		bugs = value
		bugs_changed.emit(bugs)

# Side project state
var side_project := {
	"progress": 0  # 0-100, escape progress
}:
	set(value):
		side_project = value
		side_project_updated.emit(side_project)

var production_outages := 0  # Track total outages for firing (3 = fired)
var poorly_shipped_tasks := []  # Tasks shipped at <50% (can trigger outages)
var outage_in_progress := false  # Track if outage consequence is being shown
var last_outage_choice := ""  # Track the most recent outage blame choice

# PIP and blame tracking
var pip_warnings := 0:  # 2 warnings = fired
	set(value):
		pip_warnings = value
		pip_warnings_changed.emit(pip_warnings)
var total_blames := 0  # 3 blames = company collapse
var blame_stats := {
	"responsibility": 0,  # Took personal responsibility
	"scapegoat": 0,       # Blamed others
	"systemic": 0         # Blamed system/process
}

var ship_messages: Dictionary = {}
var outage_messages: Dictionary = {}

const WORK_EVENTS := [
	{"text": "Boss says: 'We're a family.'", "ducks": -1, "money": 0},
	{"text": "Free pizza! (It's vegan.)", "ducks": 1, "money": 0},
	{"text": "Legacy code explodes. Debug for 3 hours.", "ducks": 0, "money": -50}
]

func _ready():
	load_ship_messages()
	load_outage_messages()

func load_ship_messages():
	var json_text = FileAccess.get_file_as_string("res://data/ship_messages.json")
	ship_messages = JSON.parse_string(json_text)

func load_outage_messages():
	var json_text = FileAccess.get_file_as_string("res://data/outage_messages.json")
	outage_messages = JSON.parse_string(json_text)

func get_bug_multiplier() -> float:
	"""Returns slowdown multiplier based on current bugs.
	Each bug = 1% slower
	"""
	return 1.0 + (bugs * 0.01)

func add_bugs(amount: int) -> void:
	"""Add bugs from rushing or other sources."""
	bugs += amount
	print("Bugs added: +%d (total: %d)" % [amount, bugs])

func start_game():
	current_task = TaskManager.get_random_task(day, job_level)

func check_time_bombs():
	"""Check for production outages based on bugs and poorly shipped tasks."""
	if poorly_shipped_tasks.size() == 0:
		return  # No poorly shipped tasks = no outages possible

	# Outage chance = (bugs × 0.5%) per poorly shipped task
	# Example: 60 bugs × 3 bad tasks = 90% daily chance
	var outage_chance = bugs * OUTAGE_CHANCE_PER_BUG * poorly_shipped_tasks.size()

	if randf() < outage_chance:
		# Pick a random poorly shipped task to blame
		var task_name = poorly_shipped_tasks.pick_random()
		trigger_production_outage(task_name)
		# Remove so it can't trigger again
		poorly_shipped_tasks.erase(task_name)

func trigger_production_outage(task_name: String):
	"""Handle a production outage - the Papers Please 'terrorist exploded' moment."""
	production_outages += 1
	outage_in_progress = true

	# Emit signal for UI to show outage dialog with choices
	production_outage_occurred.emit(task_name)

func handle_outage_choice(choice: String):
	"""Process the player's blame choice for a production outage."""
	# Track blame statistics and increment counters
	blame_stats[choice] += 1

	match choice:
		"responsibility":
			pip_warnings += 1
			outage_consequence.emit(outage_messages["responsibility"]["first_pip"])

		"scapegoat":
			total_blames += 1
			var message_key = "first" if total_blames == 1 else "second"
			outage_consequence.emit(outage_messages[choice][message_key])

		"systemic":
			total_blames += 1
			var message_key = "first" if total_blames == 1 else "second"
			outage_consequence.emit(outage_messages[choice][message_key])

	# Game-ending conditions checked in advance_turn()
	# Day advance happens in UI after consequence popup dismissed (see game_ui.gd)

func finish_outage_turn():
	"""Called after outage consequence popup is dismissed to advance the day."""
	outage_in_progress = false
	advance_turn()

func check_game_over():
	"""Check if player has reached victory: need both £5K AND 100% side project."""
	if money >= VICTORY_MONEY_GOAL and side_project.progress >= 100:
		victory.emit(get_game_stats())
		return

	# Check end game conditions once per turn
	if pip_warnings >= MAX_PIP_WARNINGS:
		game_over.emit("fired_pip", get_game_stats())
		return

	if total_blames >= MAX_BLAMES:
		# Determine which type of blame caused collapse
		# TODO: Could track which blame type caused the final strike instead
		var ending = "company_collapse_scapegoat" if blame_stats["scapegoat"] > blame_stats["systemic"] else "company_collapse_systemic"
		game_over.emit(ending, get_game_stats())
		return

	if ducks <= 0:
		game_over.emit("burnout", get_game_stats())
		return

	if bugs >= MAX_BUGS_GAME_OVER:
		game_over.emit("death_spiral", get_game_stats())
		return

	if overdue_days >= MAX_OVERDUE_DAYS and pip_warnings != 0:
		game_over.emit("fired_deadline", get_game_stats())
		return

func get_game_stats() -> Dictionary:
	"""Generate stats dictionary for game over/victory screens."""
	return {
		"tasks_completed": completed_tasks,
		"days_survived": day,
		"bugs": bugs,
		"ducks": ducks,
		"side_project_progress": side_project.progress,
		"money": money
	}

func _trigger_random_work_event():
	var event_result := {"text": "", "money": 0, "ducks": 0}

	if randf() <= 0.3:  # 30% chance for event
		event_result = WORK_EVENTS[randi() % WORK_EVENTS.size()]		
		money += event_result.money
		ducks += event_result.ducks
		event_occurred.emit(event_result)

func advance_turn():
	"""Advance day and check all daily events."""
	# Advance to next day
	day += 1

	if day > current_task.due_day:
		overdue_days += 1

	check_game_over()

	# Track days sitting at 100%
	if current_task.progress >= 100:
		days_at_100_percent += 1


	if overdue_days >= MAX_OVERDUE_DAYS:
		pip_warnings += 1
		pick_up_new_task()

	# Check for payday
	days_until_payday -= 1
	if days_until_payday <= 0:
		days_until_payday = PAYDAY_INTERVAL
		money += PAYDAY_SALARY
		payday_occurred.emit(PAYDAY_SALARY)

	# Check for production outages (time bombs)
	check_time_bombs()


func process_turn(action: String):
	"""Complete turn cycle: execute action, advance day, check events."""
	# 1. Execute player action (returns outcome)
	var outcome = ActionOutcome.NORMAL
	match action:
		"work":
			outcome = do_work()
		"hustle":
			outcome = hustle()
		"ship":
			outcome = ship_it()

	# 2. Advance day and check events (only for normal outcomes)
	if outcome == ActionOutcome.NORMAL:
		advance_turn()

func do_work() -> ActionOutcome:
	print('work')

	# Cheeky punishment for gold-plating
	if current_task.progress >= 100:
		task_completed_awaiting_choice.emit()
		return ActionOutcome.DO_NOTHING

	# _trigger_random_work_event():
	# wait response to work_event

	var bug_multiplier = get_bug_multiplier()
	# 100 / complexity = days to complete (1 complexity = 1 day)
	var work = 100.0 / (current_task.complexity * bug_multiplier)
	current_task.do_work(work)
	task_progress_changed.emit(current_task.progress)
	print("Progress: +%.1f%% (complexity: %d, bugs: %d)" % [work, current_task.complexity, bugs])

	return ActionOutcome.NORMAL

func pick_up_new_task():
	completed_tasks += 1
	overdue_days = 0
	days_at_100_percent = 0
	current_task = TaskManager.get_random_task(day, job_level)

func hustle() -> ActionOutcome:
	print('hustle')

	# Check if already complete
	if side_project.progress >= 100:
		event_occurred.emit({"text": "Side project is complete!\n\nNow you just need the money to escape...", "money": 0, "ducks": 0})
		return ActionOutcome.DO_NOTHING

	# Progress side project (10% per hustle)
	var progress_gain = 10
	side_project.progress = min(100, side_project.progress + progress_gain)
	side_project_updated.emit(side_project)

	return ActionOutcome.NORMAL

func get_ship_quality_message(progress: int) -> String:
	"""Get random quality flavor text based on progress percentage."""
	var tier_key = ""

	# Find the appropriate tier
	if progress >= 90:
		tier_key = "excellent"
	elif progress >= 70:
		tier_key = "acceptable"
	elif progress >= 50:
		tier_key = "compromised"
	elif progress >= 30:
		tier_key = "shameful"
	else:
		tier_key = "rock_bottom"

	# Get random message from tier
	var messages = ship_messages["quality_tiers"][tier_key]["messages"]
	return messages[randi() % messages.size()]

func get_too_early_message() -> String:
	"""Get random message for trying to ship at <20% progress."""
	var messages = ship_messages["too_early"]
	return messages[randi() % messages.size()]

func ship_it() -> ActionOutcome:
	"""Complete task early at current progress. Adds bugs based on incompleteness."""
	if GameManager.current_task.progress < GameManager.MIN_SHIP_PROGRESS:
		# Cheeky punishment for trying to ship nothing
		var cheeky_message = get_too_early_message()
		event_occurred.emit({"text": cheeky_message, "money": 0, "ducks": 0})
		return ActionOutcome.DO_NOTHING

	print('ship it at %d%%' % current_task.progress)

	var progress = current_task.progress

	# Calculate bugs to add: (100 - progress) / 10
	var bugs_to_add = (100 - progress) / BUGS_PER_INCOMPLETE_PERCENT
	add_bugs(int(bugs_to_add))

	# Track poorly shipped tasks (can cause outages later)
	if progress < POOR_QUALITY_THRESHOLD:
		poorly_shipped_tasks.append(current_task.title)
		print("⚠️ Poor quality ship: '%s' added to outage risk pool" % current_task.title)

	pick_up_new_task()

	return ActionOutcome.NORMAL
