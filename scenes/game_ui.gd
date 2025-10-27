extends Node

@onready var work_button := $"%WorkButton" as ActionButton
@onready var slack_button := $"%SlackButton" as ActionButton
@onready var ship_it_button := $"%ShipItButton" as ActionButton
@onready var task_panel := $"%TaskPanel"
@onready var debug_mode_toggle := $"%DebugModeToggle"
@onready var top_bar := $MainThemeContainer/VBoxContainer/TopBar

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
	GameManager.promotion_earned.connect(_on_promotion_earned)
	GameManager.optics_warning_shown.connect(_on_optics_warning)
	GameManager.critical_warning_shown.connect(_on_critical_warning)
	GameManager.next_day.connect(_on_next_day)

	$OutageDialog.outage_choice.connect(_on_outage_choice)
	$"%OutageConsequencePopup".consequence_dismissed.connect(_on_outage_consequence_dismissed)
	$PromotionDialog.promotion_dismissed.connect(_on_promotion_dismissed)
	$CompletionDialog.popup_hide.connect(_on_completion_dialog_dismissed)
	$OpticsWarningDialog.warning_acknowledged.connect(_on_category_warning_acknowledged)

	TimedModeController.timer_expired.connect(_on_timer_expired)

	# Debug: Show mode toggle in debug builds
	if OS.is_debug_build():
		debug_mode_toggle.visible = true
		debug_mode_toggle.toggled.connect(_on_debug_mode_toggled)
		debug_mode_toggle.button_pressed = (GameManager.game_mode == GameManager.GameMode.TIMED)

	# Load end game panel
	var EndGamePanelScene = load("res://scenes/end_game_panel.tscn")
	end_game_panel = EndGamePanelScene.instantiate()
	add_child(end_game_panel)

	GameManager.start_game()

	# Start timer if in timed mode
	if GameManager.game_mode == GameManager.GameMode.TIMED:
		TimedModeController.start_timer(GameManager.TIMED_MODE_DURATION)

	# Debug: Load test scenario in debug builds
	if OS.is_debug_build():
		_setup_test_scenario()

func _on_work_button_pressed():
	GameManager.process_turn("work")
	# Timer will reset via _on_next_day after turn processes

func _on_slack_button_pressed():
	GameManager.process_turn("hustle")
	# Timer will reset via _on_next_day after turn processes

func _on_ship_it_button_pressed():
	GameManager.process_turn("ship")
	# Timer will reset via _on_next_day after turn processes

func _on_event_occurred(event: Dictionary):
	if event.text != "":
		$EventPopup.show_event(event.text)

func _on_outage_consequence(text: String):
	# Show outage-specific consequence popup (with red styling)
	TimedModeController.pause_timer()
	$"%OutageConsequencePopup".show_consequence(text)

func _on_pip_warning(text: String):
	# Show PIP warning with dramatic outage styling
	TimedModeController.pause_timer()
	$"%PipWarningPopup".show_warning(text)

func _on_outage_consequence_dismissed():
	# Clean up outage UI and advance the day
	$"%OutageRedOverlay".visible = false
	GameManager.finish_outage_turn()
	TimedModeController.resume_timer()

func _on_game_over(ending_type: String, stats: Dictionary):
	TimedModeController.stop_timer()
	end_game_panel.show_game_over(ending_type, stats)

func _on_victory(stats: Dictionary):
	TimedModeController.stop_timer()
	end_game_panel.show_victory(stats)

func _on_production_outage(task_name: String):
	TimedModeController.pause_timer()
	$"%OutageRedOverlay".visible = true
	$OutageDialog.show_outage(task_name)

func _on_outage_choice(choice: String):
	# Keep red overlay visible - will hide after consequence popup dismissed
	# Timer stays paused until consequence is dismissed
	GameManager.handle_outage_choice(choice)
	$OutageDialog.hide()

func _on_task_completed():
	TimedModeController.pause_timer()
	$CompletionDialog.show_completion()

func _on_promotion_earned(new_level: int, new_title: String, new_salary: int):
	TimedModeController.pause_timer()
	$PromotionDialog.show_promotion(new_title, new_salary)

func _on_promotion_dismissed():
	# Continue game after promotion dialog closes
	TimedModeController.resume_timer()

func _on_completion_dialog_dismissed():
	# Resume timer after dismissing gold-plating warning
	TimedModeController.resume_timer()

func _on_optics_warning(message: String):
	TimedModeController.pause_timer()
	$OpticsWarningDialog.show_optics_warning(message)

func _on_critical_warning(message: String):
	TimedModeController.pause_timer()
	$OpticsWarningDialog.show_optics_warning(message)

func _on_category_warning_acknowledged():
	# Resume timer after acknowledging category warning (optics/critical)
	TimedModeController.resume_timer()

func _on_timer_expired():
	"""Handle timer expiration in timed mode - auto-advance with WORK action."""
	if GameManager.game_mode == GameManager.GameMode.TIMED:
		print("⏱️ Timer expired - auto-advancing with WORK action")
		GameManager.process_turn("work")

func _on_next_day(_day: int):
	"""Reset timer when advancing to next day in timed mode."""
	if GameManager.game_mode == GameManager.GameMode.TIMED:
		TimedModeController.reset_timer(GameManager.TIMED_MODE_DURATION)

func _on_debug_mode_toggled(enabled: bool):
	"""Debug: Toggle between classic and timed mode."""
	if enabled:
		GameManager.game_mode = GameManager.GameMode.TIMED
		TimedModeController.start_timer(GameManager.TIMED_MODE_DURATION)
		print("🎮 Switched to TIMED mode")
	else:
		GameManager.game_mode = GameManager.GameMode.CLASSIC
		TimedModeController.stop_timer()
		print("🎮 Switched to CLASSIC mode")

	# Update top bar timer visibility
	top_bar._update_timer_visibility()

func _setup_test_scenario():
	"""Debug: Setup test scenario for production outage testing"""
	# GameManager.bugs = 60  # High bugs = high outage chance (60 × 0.5% × 3 = 90% daily)
	# GameManager.poorly_shipped_tasks = [{"name": "Blockchain", "is_critical": false}, {"name": "Logo Fix", "is_critical": false}, {"name": "Printer Bug", "is_critical": false}]
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

	# # TEST CRITICAL: Force a critical task
	# var test_task = Task.new()
	# test_task.task_id = "ALT-TEST"
	# test_task.title = "Fix Production Database Outage"
	# test_task.complexity = 3
	# test_task.due_day = GameManager.day + 3
	# var categories_array: Array[String] = ["critical"]
	# test_task.categories = categories_array
	# GameManager.current_task = test_task
	# GameManager.bugs = 10
	# print("🔧 DEBUG: Critical task loaded → Ship at <80% to trigger guaranteed outage next turn")
