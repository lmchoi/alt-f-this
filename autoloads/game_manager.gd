extends Node
signal money_changed(amount)
signal chaos_changed(amount)
signal event_occurred(event_data)

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

func do_work():
	money += 10
	chaos += 5

	var event_result := {"text": "", "money": 0, "chaos": 0}

	if randf() <= 0.3:  # 30% chance for event
		event_result = WORK_EVENTS[randi() % WORK_EVENTS.size()]
		money += event_result.money
		chaos += event_result.chaos

	event_occurred.emit(event_result)
