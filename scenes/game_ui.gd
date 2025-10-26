extends Node

@onready var work_button := $"%WorkButton" as ActionButton
@onready var slack_button := $"%SlackButton" as ActionButton
@onready var ship_it_button := $"%ShipItButton" as ActionButton
@onready var task_panel := $"%TaskPanel"

var end_game_panel: Panel

func _ready():
	work_button.pressed.connect(_on_work_button_pressed)
	slack_button.pressed.connect(_on_slack_button_pressed)
	task_panel.ship_it_pressed.connect(_on_ship_it_button_pressed)
	GameManager.event_occurred.connect(_on_event_occurred)
	GameManager.task_completed_awaiting_choice.connect(_on_task_completed)
	GameManager.game_over.connect(_on_game_over)
	GameManager.victory.connect(_on_victory)
	GameManager.production_outage_occurred.connect(_on_production_outage)
	GameManager.outage_consequence.connect(_on_outage_consequence)
	GameManager.pip_warning_occurred.connect(_on_pip_warning)

	$OutageDialog.outage_choice.connect(_on_outage_choice)
	$"%OutageConsequencePopup".consequence_dismissed.connect(_on_outage_consequence_dismissed)

	# Load end game panel
	var EndGamePanelScene = load("res://scenes/end_game_panel.tscn")
	end_game_panel = EndGamePanelScene.instantiate()
	add_child(end_game_panel)

	GameManager.start_game()

	# Debug: Load test scenario in debug builds
	if OS.is_debug_build():
		_setup_test_scenario()

func _on_work_button_pressed():
	GameManager.process_turn("work")

func _on_slack_button_pressed():
	GameManager.process_turn("hustle")

func _on_ship_it_button_pressed():
	GameManager.process_turn("ship")

func _on_event_occurred(event: Dictionary):
	if event.text != "":
		$EventPopup.show_event(event.text)

func _on_outage_consequence(text: String):
	# Show outage-specific consequence popup (with red styling)
	$"%OutageConsequencePopup".show_consequence(text)

func _on_pip_warning(text: String):
	# Show PIP warning with dramatic outage styling
	$"%PipWarningPopup".show_warning(text)

func _on_outage_consequence_dismissed():
	# Clean up outage UI and advance the day
	$"%OutageRedOverlay".visible = false
	GameManager.finish_outage_turn()

func _on_game_over(ending_type: String, stats: Dictionary):
	end_game_panel.show_game_over(ending_type, stats)

func _on_victory(stats: Dictionary):
	end_game_panel.show_victory(stats)

func _on_production_outage(task_name: String):
	$"%OutageRedOverlay".visible = true
	$OutageDialog.show_outage(task_name)

func _on_outage_choice(choice: String):
	# Keep red overlay visible - will hide after consequence popup dismissed
	GameManager.handle_outage_choice(choice)
	$OutageDialog.hide()

func _on_task_completed():
	$CompletionDialog.show_completion()

func _setup_test_scenario():
	"""Debug: Setup test scenario for production outage testing"""
	# GameManager.bugs = 60  # High bugs = high outage chance (60 × 0.5% × 3 = 90% daily)
	# GameManager.poorly_shipped_tasks = ["Blockchain", "Logo Fix", "Printer Bug"]
	# GameManager.money = 2000
	# GameManager.ducks = 2
	# GameManager.side_project.progress = 100
	# GameManager.day = 10
	# print("🔧 DEBUG TEST SCENARIO LOADED:")
	# # print("  - Bugs: 60 (high outage chance)")
	# print("  - 3 poorly shipped tasks ready to explode")
	# print("  - Money: $2000")
	# print("  - Ducks: 2")
	# print("  - Day: 10")
	# print("  → Outage should trigger soon! (~90% chance per day)")
