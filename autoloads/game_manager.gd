extends Node
signal next_day(nth)
signal money_changed(amount)
signal ducks_changed(amount)
signal event_occurred(event_data)

var day := 1:
	set(value):
		day = value
		next_day.emit(day)

var money := 0:
	set(value):
		money = value
		money_changed.emit(money)

var ducks := 7:
	set(value):
		ducks = value
		ducks_changed.emit(ducks)

const WORK_EVENTS := [
	{"text": "Boss says: 'We’re a family.'", "ducks": -1, "money": 0},
	{"text": "Free pizza! (It's vegan.)", "ducks": 1, "money": 0},
	{"text": "Legacy code explodes. Debug for 3 hours.", "ducks": 0, "money": -50}
]

var current_task = Task.new()

func do_work():
# trigger random event
# wait response
# update task
# update player state
# emit outcome

	money += 100
	current_task.do_work()

	var event_result := {"text": "", "money": 0, "ducks": 0}

	if randf() <= 0.3:  # 30% chance for event
		event_result = WORK_EVENTS[randi() % WORK_EVENTS.size()]
		money += event_result.money
		ducks += event_result.ducks

	event_occurred.emit(event_result)
#	// do this at the end
	day += 1
	if current_task.due_day == day:
		event_occurred.emit({"text": "DEADLINE"})
	

func slack_off():
	ducks += 1
	day += 1

	var event_result := {"text": "Slacker", "money": 0, "ducks": 0}
	event_occurred.emit(event_result)
