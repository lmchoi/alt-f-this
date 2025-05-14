extends Node
signal next_day(nth)
signal money_changed(amount)
signal chaos_changed(amount)
signal event_occurred(event_data)

var day := 1:
	set(value):
		day = value
		next_day.emit(day)

var money := 0:
	set(value):
		money = value
		money_changed.emit(money)

var chaos := 0:
	set(value):
		chaos = value
		chaos_changed.emit(chaos)

const WORK_EVENTS := [
	{"text": "Boss says: 'We’re a family.'", "chaos": +20, "money": 0},
	{"text": "Free pizza! (It's vegan.)", "chaos": -5, "money": 0},
	{"text": "Legacy code explodes. Debug for 3 hours.", "chaos": +25, "money": -50}
]

var current_task = Task.new()

func do_work():
	money += 10
	chaos += 5
	current_task.do_work()

	var event_result := {"text": "", "money": 0, "chaos": 0}

	if randf() <= 0.3:  # 30% chance for event
		event_result = WORK_EVENTS[randi() % WORK_EVENTS.size()]
		money += event_result.money
		chaos += event_result.chaos

	event_occurred.emit(event_result)
#	// do this at the end
	day += 1
	if current_task.due_day == day:
		event_occurred.emit({"text": "DEADLINE"})		

func slack_off():
	chaos -= 10
	day += 1

	var event_result := {"text": "Slacker", "money": 0, "chaos": 0}
	event_occurred.emit(event_result)
