extends Node

@onready var work_button := $"%WorkButton" as ActionButton
@onready var slack_button := $"%SlackButton" as ActionButton
@onready var ship_it_button := $"%ShipItButton" as ActionButton

var end_game_panel: Panel

func _ready():
	work_button.pressed.connect(_on_work_button_pressed)
	slack_button.pressed.connect(_on_slack_button_pressed)
	ship_it_button.pressed.connect(_on_ship_it_button_pressed)
	GameManager.event_occurred.connect(_on_event_occurred)
	GameManager.missed_deadline.connect(_on_deadline_due)
	GameManager.game_over.connect(_on_game_over)
	GameManager.victory.connect(_on_victory)
	GameManager.production_outage_occurred.connect(_on_production_outage)

	$DeadlineDialog.custom_action.connect(_on_deadline_action)
	$OutageDialog.outage_choice.connect(_on_outage_choice)

	# Load end game panel
	var EndGamePanelScene = load("res://scenes/end_game_panel.tscn")
	end_game_panel = EndGamePanelScene.instantiate()
	add_child(end_game_panel)

	GameManager.start_game()

	# Debug: Load test scenario in debug builds
	if OS.is_debug_build():
		_setup_test_scenario()

func _on_work_button_pressed():
	GameManager.do_work()

func _on_slack_button_pressed():
	GameManager.hustle()

func _on_ship_it_button_pressed():
	if GameManager.current_task.progress < GameManager.MIN_SHIP_PROGRESS:
		# Cheeky punishment for trying to ship nothing
		var cheeky_message = GameManager.get_too_early_message()
		$EventPopup.show_event(cheeky_message)
	else:
		GameManager.ship_it()

func _on_event_occurred(event: Dictionary):
	if event.text != "":
		$EventPopup.show_event(event.text)

func _on_deadline_due():
	$DeadlineDialog.popup()

func _on_game_over(ending_type: String, stats: Dictionary):
	end_game_panel.show_game_over(ending_type, stats)

func _on_victory(stats: Dictionary):
	end_game_panel.show_victory(stats)

func _on_deadline_action(action: String):
	GameManager.process_action(action)
	$DeadlineDialog.hide()

func _on_production_outage(task_name: String):
	$OutageDialog.show_outage(task_name)

func _on_outage_choice(choice: String):
	GameManager.handle_outage_choice(choice)
	$OutageDialog.hide()

func _setup_test_scenario():
	"""Debug: Setup test scenario for production outage testing"""
	# # GameManager.bugs = 60  # High bugs = high outage chance (60 × 0.5% × 3 = 90% daily)
	# GameManager.poorly_shipped_tasks = ["Blockchain", "Logo Fix", "Printer Bug"]
	# GameManager.money = 2000
	# GameManager.ducks = 2
	# GameManager.day = 10
	# print("🔧 DEBUG TEST SCENARIO LOADED:")
	# # print("  - Bugs: 60 (high outage chance)")
	# print("  - 3 poorly shipped tasks ready to explode")
	# print("  - Money: $2000")
	# print("  - Ducks: 2")
	# print("  - Day: 10")
	# print("  → Outage should trigger soon! (~90% chance per day)")
