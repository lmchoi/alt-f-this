extends Node
signal next_day(nth)
signal money_changed(amount)
signal salary_changed(amount)
signal ducks_changed(amount)
signal bugs_changed(amount)
signal event_occurred(event_data)
signal missed_deadline()
signal work_completed()
signal game_over(message)
signal current_task_updated(task)

var current_task := Task.new(1):
	set(value):
		current_task = value
		current_task_updated.emit(current_task)

var day := 1:
	set(value):
		day = value
		next_day.emit(day)

var money := 0:
	set(value):
		money = value
		money_changed.emit(money)

var salary := 100:
	set(value):
		salary = value
		salary_changed.emit(salary)

var ducks := 2:
	set(value):
		ducks = value
		ducks_changed.emit(ducks)
		if ducks <= 0:
			game_over.emit("Ran out of ducks to give...")

var bugs := 0:
	set(value):
		bugs = value
		bugs_changed.emit(bugs)

const WORK_EVENTS := [
	{"text": "Boss says: 'We’re a family.'", "ducks": -1, "money": 0},
	{"text": "Free pizza! (It's vegan.)", "ducks": 1, "money": 0},
	{"text": "Legacy code explodes. Debug for 3 hours.", "ducks": 0, "money": -50}
]

func add_bugs(amount: int) -> void:
	"""Add bugs from rushing or other sources."""
	bugs += amount
	print("Bugs added: +%d (total: %d)" % [amount, bugs])

func start_game():
	current_task = TaskManager.get_random_task()

func _trigger_random_work_event():
	var event_result := {"text": "", "money": 0, "ducks": 0}

	if randf() <= 0.3:  # 30% chance for event
		event_result = WORK_EVENTS[randi() % WORK_EVENTS.size()]		
		money += event_result.money
		ducks += event_result.ducks
		event_occurred.emit(event_result)

func daily_updates():
	if current_task.progress >= 100:
		print("work completed")
		work_completed.emit()
		current_task = TaskManager.get_random_task(day)

	if current_task.due_day == day:
		# check progress to calculate bugs chance
		missed_deadline.emit()		

func do_work():
	print('work')
	# _trigger_random_work_event():
	# wait response to work_event

	current_task.do_work()

	# update player state
	money += salary

	# do this at the end
	# emit outcome
	day += 1

func hustle():
	print('hustle')
	
	money += (salary * 2)

	# do this at the end
	# emit outcome
	day += 1

func process_action(action: String):
	# Handle button press and forward signal
	match action:
		"mercy":
			salary -= 10
			print("mercy")
		"duck_it":
			ducks -= 1
			add_bugs(5)
			current_task = TaskManager.get_random_task(day)
			print("duck it")
