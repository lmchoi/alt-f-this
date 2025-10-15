# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Alt+F+This** is a darkly comedic mobile game built in Godot 4.5 about surviving the corporate tech grind. The game uses GDScript and follows a signal-driven architecture with autoloaded singleton managers.

## Running the Game

Open the project in Godot 4.5 and press F5 to run. The main scene is [game_ui.tscn](scenes/game_ui.tscn).

## Architecture

### Core Systems

The game uses two autoloaded singleton managers that handle all game state:

- **GameManager** ([autoloads/game_manager.gd](autoloads/game_manager.gd)): Central game state controller
  - Manages game variables: day, money, salary, ducks, current_task
  - Uses setter properties that emit signals on value changes (e.g., `money_changed`, `ducks_changed`)
  - Handles game actions: `do_work()`, `hustle()`, `process_action()`
  - Emits game events: `next_day`, `missed_deadline`, `work_completed`, `game_over`
  - All game logic flows through this manager

- **TaskManager** ([autoloads/task_manager.gd](autoloads/task_manager.gd)): Task data provider
  - Loads tasks from [data/tasks.json](data/tasks.json)
  - Provides `get_random_task(today_date)` to generate new tasks
  - Tasks are humorous corporate tech scenarios (e.g., "Make the Logo Bigger (Again)")

### Data Model

- **Task** ([scripts/resources/task.gd](scripts/resources/task.gd)): Resource class representing work assignments
  - Properties: `title`, `due_day` (absolute day number), `progress` (0-100)
  - `do_work()` increases progress by 20 per call

### UI Architecture

The UI follows a signal-driven reactive pattern:

1. UI components connect to GameManager signals in `_ready()`
2. GameManager emits signals when state changes
3. UI updates automatically through signal handlers

Main UI controller: [scenes/game_ui.gd](scenes/game_ui.gd)
- Connects all UI elements to GameManager signals
- Routes button presses to GameManager actions
- Handles dialogs (deadline, events, game over)

### Game Flow

1. Game starts in [game_ui.gd](scenes/game_ui.gd) → calls `GameManager.start_game()`
2. Player presses "Work" or "Hustle" buttons → triggers `do_work()` or `hustle()`
3. Actions update state and advance day → emits `next_day` signal
4. `daily_updates()` checks for task completion and deadlines
5. UI reacts to all state changes via signals

### Critical Game Mechanics

- **Ducks**: Player's "patience" resource. Lose a duck when missing deadlines. Game over at 0 ducks.
- **Day cycle**: Each action (work/hustle) advances 1 day and triggers `daily_updates()`
- **Deadlines**: When `current_task.due_day == day`, a deadline dialog appears
- **Progress**: Tasks complete at 100% progress (5 work actions at 20% each)
- **Hustle**: Earn 2x salary but make no task progress

## Development Notes

- The game is configured for mobile (720x1280 portrait, touch emulation enabled)
- Uses Godot's unique node syntax (`$"%NodeName"`) for accessing UI elements
- Tasks are stored in JSON format in [data/tasks.json](data/tasks.json) with properties: title, description, allowed_time, complexity, category, completion_text
- Signal-driven architecture means state changes propagate automatically—avoid direct UI updates

## Current TODO Items

See [TODO.md](TODO.md) for active development tasks, including:
- Visual indicators for events and progress
- Game over conditions (escape funds, 3 days overdue)
- Restart functionality
