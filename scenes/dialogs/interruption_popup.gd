extends PopupPanel

signal interruption_dismissed(event_id: String)

var current_event: Dictionary = {}

func _ready() -> void:
	popup_hide.connect(_on_popup_hide)

	# Connect button signals
	if has_node("%DismissButton"):
		$"%DismissButton".pressed.connect(_on_dismiss_pressed)
	if has_node("%AcceptButton"):
		$"%AcceptButton".pressed.connect(_on_accept_pressed)
	if has_node("%DeclineButton"):
		$"%DeclineButton".pressed.connect(_on_decline_pressed)

func show_interruption(event_data: Dictionary) -> void:
	"""Show interruption popup with event details."""
	current_event = event_data

	# Always show source and message
	$"%SourceLabel".text = event_data.get("source", "Interruption")
	$"%MessageLabel".text = event_data.get("message", "Something needs your attention")

	# Check if this is a task offer
	var is_task_offer = event_data.get("type", "") == "task_offer"

	# Show/hide task details panel
	if has_node("%TaskDetailsPanel"):
		$"%TaskDetailsPanel".visible = is_task_offer

	# Show/hide appropriate buttons and consequence label
	if has_node("%DismissButton"):
		$"%DismissButton".visible = not is_task_offer
	if has_node("%AcceptButton"):
		$"%AcceptButton".visible = is_task_offer
	if has_node("%DeclineButton"):
		$"%DeclineButton".visible = is_task_offer
	if has_node("%ConsequenceLabel"):
		$"%ConsequenceLabel".visible = is_task_offer

	# Populate task details if task offer
	if is_task_offer and event_data.has("task_data"):
		var task_data = event_data["task_data"]
		if has_node("%TaskTitleLabel"):
			$"%TaskTitleLabel".text = "Task: " + task_data.get("title", "Unknown Task")
		if has_node("%DueLabel"):
			var due_text = "TODAY" if task_data.get("due_in_days", 0) == 0 else str(task_data.get("due_in_days", 0)) + " days"
			$"%DueLabel".text = "• Due: " + due_text
		if has_node("%ComplexityLabel"):
			var complexity = task_data.get("complexity", 1)
			var spaghetti = "🍝".repeat(complexity)
			$"%ComplexityLabel".text = "• Complexity: " + spaghetti
		if has_node("%CategoriesLabel"):
			var categories = task_data.get("categories", [])
			$"%CategoriesLabel".text = "• Categories: " + ", ".join(categories).to_upper()

		# Show decline consequences
		if has_node("%ConsequenceLabel") and event_data.has("consequences"):
			var consequences = event_data["consequences"]
			var parts = []
			if consequences.has("ducks"):
				parts.append(str(consequences["ducks"]) + " ducks")
			if consequences.has("bugs"):
				parts.append("+" + str(consequences["bugs"]) + " bugs")
			$"%ConsequenceLabel".text = "Decline: " + ", ".join(parts)

	popup()

func _on_accept_pressed() -> void:
	"""Accept the task offer and add it to the queue."""
	if current_event.has("task_data"):
		var task_data = current_event["task_data"]

		# Create new task
		var new_task = Task.new()
		new_task.task_id = "INT-%d" % randi()  # Interruption task ID
		new_task.title = task_data.get("title", "Interruption Task")
		new_task.description = "Urgent interruption task"
		new_task.complexity = task_data.get("complexity", 3)
		new_task.due_day = GameManager.day + task_data.get("due_in_days", 1)
		new_task.progress = 0

		# Convert generic Array from JSON to Array[String] for categories
		var cats: Array[String] = []
		if task_data.has("categories"):
			for cat in task_data["categories"]:
				cats.append(str(cat))
		new_task.categories = cats

		# Add to GameManager task list
		GameManager.add_task(new_task)
		print("✅ Accepted task: %s" % new_task.title)

	# Dismiss the interruption
	InterruptionManager.dismiss_interruption(current_event["id"])
	hide()

func _on_decline_pressed() -> void:
	"""Decline the task offer and apply consequences."""
	if current_event.has("consequences"):
		var consequences = current_event["consequences"]

		# Apply ducks penalty
		if consequences.has("ducks"):
			GameManager.ducks += consequences["ducks"]  # Note: already negative in JSON

		# Apply bugs penalty
		if consequences.has("bugs"):
			GameManager.bugs += consequences["bugs"]

		# Show consequence message as an event
		if consequences.has("message"):
			GameManager.event_occurred.emit({
				"text": consequences["message"],
				"money": 0,
				"ducks": 0
			})

	# Dismiss the interruption
	InterruptionManager.dismiss_interruption(current_event["id"])
	hide()

func _on_dismiss_pressed() -> void:
	"""Dismiss a simple interruption (non-task-offer)."""
	hide()

func _on_popup_hide() -> void:
	if current_event.has("id"):
		interruption_dismissed.emit(current_event["id"])
