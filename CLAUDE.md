# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

---

## Project Overview

**Alt+F+This** - *"Papers Please meets Office Space with duck-based emotional damage"*

A darkly comedic inspection/management game built in Godot 4.5 where you're a tech worker trapped in corporate hell. Inspect work tickets, make impossible decisions, and escape with $5K before you run out of ducks to give.

---

## Game Design Vision

See [ideas/game-plan.md](ideas/game-plan.md) for the complete design document.

### Core Pillars
1. **Inspection Gameplay** (Papers Please) - Examine tickets, check resources, make deliberate decisions
2. **Dark Corporate Satire** (Office Space) - Absurd tasks, impossible deadlines, TPS report energy
3. **Emotional Resource Management** - Ducks = patience/sanity. Every compromise costs ducks.
4. **Consequence Cascades** - Rushed work → bugs → slower work → forced to rush more → death spiral

### Goal (Act 1)
Save $5,000 to escape while keeping ducks > 0. If you run out of ducks, you burn out.

---

## Running the Game

Open project in Godot 4.5 and press F5. Main scene: [scenes/game_ui.tscn](scenes/game_ui.tscn)

---

## Architecture

### Signal-Driven Design
The game uses a reactive signal architecture where:
1. GameManager holds all state with property setters that emit signals
2. UI components connect to signals in `_ready()`
3. State changes propagate automatically through signals
4. **Never update UI directly** - always emit signals from GameManager

### Autoloaded Singletons

**GameManager** ([autoloads/game_manager.gd](autoloads/game_manager.gd))
- Central game state: `day`, `money`, `salary`, `ducks`, `bugs`, `strikes`, `current_task`
- All properties use setters that emit signals (e.g., `money_changed`, `ducks_changed`)
- Game actions: `do_work()`, `hustle()`, `debug()`, `rest()`
- Events: `next_day`, `missed_deadline`, `work_completed`, `game_over`, `production_outage`

**TaskManager** ([autoloads/task_manager.gd](autoloads/task_manager.gd))
- Loads tasks from [data/tasks.json](data/tasks.json)
- Provides `get_random_task(today_date, min_complexity, max_complexity)` for difficulty scaling
- Tasks have: title, description, complexity (1-10), allowed_time, category, completion_text

---

## Key Systems to Implement

### 1. Bugs System (CRITICAL)
```gdscript
# In GameManager
var bugs := 0  # Accumulates from rushed work

# When shipping incomplete task
func rush_ship_task(progress: int):
    bugs += (100 - progress) / 10  # Ship at 50% = +5 bugs

# Bugs slow ALL future work
func calculate_work_progress(base_progress: int, complexity: int) -> int:
    var bug_multiplier = 1.0 + (bugs / 100.0)  # 40 bugs = 40% slower
    return base_progress / (complexity * bug_multiplier)
```

### 2. Time Bombs (Production Outages)
```gdscript
# In GameManager
var time_bombs := []  # Consequences waiting to explode

func rush_ship_task(progress: int):
    time_bombs.append({
        "type": "production_outage",
        "trigger_day": day + randi_range(2, 5),  # Explodes 2-5 days later
        "severity": (100 - progress) / 10,
        "task_name": current_task.title
    })

func daily_updates():
    for bomb in time_bombs:
        if bomb.trigger_day == day:
            trigger_production_outage(bomb)
```

### 3. Task Complexity Scaling
```gdscript
# Task progress should respect complexity
func do_work():
    var base_progress = 20
    var bug_multiplier = 1.0 + (bugs / 100.0)
    var actual_progress = base_progress / (current_task.complexity * bug_multiplier)
    current_task.progress += actual_progress
```

### 4. Escalating Difficulty
- Week 1-2: Complexity 1-3, deadlines 5-7 days
- Week 3-4: Complexity 4-6, deadlines 3-5 days, salary +$20/week
- Week 5+: Complexity 7-10, deadlines 2-3 days, bugs accumulating

### 5. Decision Points (Stamp Mechanic)
When new task arrives, player chooses:
- **ACCEPT** - Standard work path
- **NEGOTIATE** - Extension (+3 days, -$100, -1 duck) or Get Help (reduce complexity, owe favor)
- **RUSH** - Ship incomplete immediately, add bugs, create time bomb
- **REFUSE** - Get new task, -$200, -1 duck, +1 strike (3 strikes = fired)

---

## Data Structure

### Task (Resource)
```gdscript
class_name Task
extends Resource

var title: String
var complexity: int  # 1-10
var due_day: int     # Absolute day number
var progress: int    # 0-100
var allowed_time: int
```

### Task JSON Format
```json
{
  "title": "Add Blockchain (For Some Reason)",
  "complexity": 5,
  "allowed_time": 4,
  "category": "Buzzword Compliance",
  "completion_text": "Added a button that says 'Blockchain Enabled!'"
}
```

---

## Development Phases

### Phase 1: Core Loop (Current Focus)
- [ ] Bugs system (accumulation + slowdown multiplier)
- [ ] Task complexity affects progress
- [ ] 4 stamp decisions (Accept/Negotiate/Rush/Refuse)
- [ ] Time bombs (production outages)
- [ ] Strikes system (3 strikes = fired)

### Phase 2: Escalation
- [ ] Salary increases over time (+$20/week)
- [ ] Task difficulty scaling by week
- [ ] Deadline lengths decrease
- [ ] Company rulebook updates

### Phase 3: Events & Personality
- [ ] Random events (30% Work, 50% Hustle)
- [ ] Choice events with moral dilemmas
- [ ] Consequence tracking and callbacks
- [ ] Event system in GameManager

### Phase 4: Polish
- [ ] Visual feedback (screen shake, animations)
- [ ] Sound effects (keyboard, duck quack, cash register)
- [ ] Progress bar color changes
- [ ] Juice and game feel

---

## Critical Implementation Notes

### Task Complexity Usage
**ALWAYS use task complexity** when calculating progress:
```gdscript
# WRONG (current code)
progress += 20

# CORRECT (what it should be)
var bug_multiplier = 1.0 + (bugs / 100.0)
progress += 20 / (complexity * bug_multiplier)
```

### Event System
Events are currently commented out in `do_work()` - they need to be re-enabled and expanded:
```gdscript
# Current (disabled)
# _trigger_random_work_event()

# Should be
if action_type == "work":
    _trigger_random_event(0.3)  # 30% chance
elif action_type == "hustle":
    _trigger_random_event(0.5)  # 50% chance
```

### Death Spiral Mechanics
The bugs system creates intentional difficulty spirals:
1. Rush task → add bugs
2. Bugs slow future work
3. Can't meet next deadline naturally
4. Must rush again → more bugs
5. Eventually need to spend days debugging

This is **intentional game design** - not a bug to fix!

---

## Mobile Configuration

- **Resolution**: 720x1280 portrait
- **Touch emulation**: Enabled for testing
- **UI**: Large touch-friendly buttons
- **Performance**: Mobile rendering method

---

## Writing Style

All game text should be:
- **Dry, deadpan humor** - Not silly or over-the-top
- **Specific tech references** - "blockchain todo app", not generic "do the thing"
- **Absurdist but grounded** - Corporate demands are ridiculous but recognizable
- **Dark without being mean** - Satirical, not cruel

Examples from [data/tasks.json](data/tasks.json):
- "Make the Logo Bigger (Again)"
- "Fix the 'Sent with Wrong Font' Email"
- "CEO's 'Simple' Excel Macro"

---

## Quick Reference

### Win Conditions
- **Victory**: Reach $5,000 and quit
- **Game Over**: Ducks reach 0 (burnout)
- **Game Over**: 3 strikes (fired)
- **Game Over**: Salary reaches $2,500/5 days (golden handcuffs)

### Resource Costs
- **Work**: +progress, +salary
- **Hustle**: +salary×2, no progress, -1 duck
- **Debug**: -15 bugs, no progress, no money
- **Rest**: +1 duck, no progress, no money
- **Rush ship**: Complete task, add bugs, -2 ducks, create time bomb
- **Negotiate extension**: +3 days, -$100, -1 duck
- **Refuse task**: New task, -$200, -1 duck, +1 strike

---

## Testing Notes

When testing game balance:
- With 0 bugs: Complexity 5 task should take ~5 days of work
- With 40 bugs: Same task takes ~7 days (40% slower)
- With 80 bugs: Same task takes ~9 days (80% slower)
- Salary should increase from $100 → $500 over ~40 days
- Escape goal ($5K) should take 30-50 days depending on choices
- Ducks should be scarce (start with 2-3, rarely gain them back)

---

## Files to Reference

- **Complete game plan**: [ideas/game-plan.md](ideas/game-plan.md)
- **Fun improvement checklist**: [ideas/fun-improvements.md](ideas/fun-improvements.md)
- **Code review items**: [ideas/code-review-checklist.md](ideas/code-review-checklist.md)
- **Active TODOs**: [TODO.md](TODO.md)
- **Original game design**: [GAME.md](GAME.md)
