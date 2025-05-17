extends Node
signal next_day(nth)
signal money_changed(amount)
signal salary_changed(amount)
signal ducks_changed(amount)
signal event_occurred(event_data)
signal deadline_due()
signal work_completed()

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

var ducks := 7:
	set(value):
		ducks = value
		ducks_changed.emit(ducks)

var current_task = Task.new()

const WORK_EVENTS := [
	{"text": "Boss says: 'We’re a family.'", "ducks": -1, "money": 0},
	{"text": "Free pizza! (It's vegan.)", "ducks": 1, "money": 0},
	{"text": "Legacy code explodes. Debug for 3 hours.", "ducks": 0, "money": -50}
]

func _trigger_random_work_event():
	var event_result := {"text": "", "money": 0, "ducks": 0}

	if randf() <= 0.3:  # 30% chance for event
		event_result = WORK_EVENTS[randi() % WORK_EVENTS.size()]		
		money += event_result.money
		ducks += event_result.ducks
		event_occurred.emit(event_result)

func daily_updates():
	if current_task.due_day == day:
		# check progress to calculate bugs chance
		deadline_due.emit()

func do_work():
	# _trigger_random_work_event():
	# wait response to work_event

	if current_task.do_work():
		print("work completed")
		work_completed.emit()
		current_task = Task.new(day)

	# update player state
	money += salary

	# do this at the end
	# emit outcome
	day += 1

func slack_off():
	ducks += 1
	day += 1

	var event_result := {"text": "Slacker", "money": 0, "ducks": 0}
	event_occurred.emit(event_result)

func process_action(action: String):
	# Handle button press and forward signal
	match action:
		"mercy":
			salary -= 10
			print("mercy")
		"duck_it":
			ducks -= 1
			current_task = Task.new(day)
			print("duck it")
