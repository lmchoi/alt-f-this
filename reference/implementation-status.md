# Implementation Status

Quick reference for what's built vs what's next.

---

## ✅ IMPLEMENTED (Playable Core Loop)

### Core Actions
- ✅ **WORK** - Makes progress, complexity + bugs affect speed
  - ✅ **Gold-plating protection** - Working at 100% shows cheeky message ("Stop gold-plating. Ship it.")
- ✅ **HUSTLE** - Builds side project progress (+10% per action), no duck effects
- ✅ **SHIP IT** - Completes task, payment on payday (every 5 days)
- ✅ **20% minimum** - Can't ship below 20% (cheeky messages)
- ✅ **ActionOutcome system** - Actions return outcome enum to control turn flow (prevents bugs like double day advance)

### Resources
- ✅ Money (tracks escape fund)
- ✅ **Ducks** - Mental health, 0 = game over, starts at 3
- ✅ Bugs (slow work, 100+ = game over)
- ✅ Day counter
- ✅ Salary (£500 every 5 days via payday system)
- ✅ Days Until Payday (5-day cycle, tracked in GameManager)
- ✅ Completed Tasks (tracked, shown in end game stats)
- ✅ **Overdue Days** - Tracks days past deadline, fired at 3 days overdue
- ✅ **Side Project** - Progress (0-100%), product name, tracked in GameManager
- ✅ **Side Project UI** - Panel showing project name and progress percentage
- ✅ **Clean Code Tokens** - Earned by shipping any task at 100%, shown in end game stats

### Task System
- ✅ Tasks from JSON with complexity (1-10)
- ✅ Complexity affects work speed: `100 / (complexity × bug_multiplier)` → 1 complexity = 1 day
- ✅ **Task difficulty scaling by job level** - Junior (1-3), Mid (3-5), Senior (5-7)
- ✅ **Deadline scaling by job level** - Junior (+2 days), Mid (+1 day), Senior (+0 days)
- ✅ Deadlines (affects hustle duck cost)
- ✅ Progress bar (updates in real-time)
- ✅ Quality messages on ship (rock_bottom → excellent)
- ✅ "Too early to ship" messages
- ✅ **Task categories** - Critical, Optics, Tech Debt with special mechanics:
  - **Critical**: Ship <80% → guaranteed outage next turn (via time bomb system)
  - **Optics**: 1 day late → instant PIP (vs 3 days for normal tasks)
  - **Tech Debt**: Bugs × 3 when shipped incomplete

### Production Outages
- ✅ Ship <50% → time bomb (poorly_shipped_tasks array)
- ✅ Outage chance: `bugs × 0.5% × poorly_shipped_count`
- ✅ Outage dialog with choices (Blame/Responsibility/Systemic)
- ✅ Outage consequences loaded from JSON
- ✅ Track production_outages, pip_warnings, total_blames

### Win/Lose Conditions
- ✅ Victory at £5,000 (corporate grind path)
- ❌ **MISSING:** Victory at 100% side project (escape path)
- ✅ Game over at 0 ducks (burnout)
- ✅ Game over at 100+ bugs (death spiral)
- ✅ Game over at 3 PIP warnings (fired - production outages)
- ✅ Game over at 3+ blames (company collapse - scapegoat)
- ✅ Game over at 3+ systemic blames (company collapse - systemic)
- ✅ **Game over at 3 days overdue** (fired for missing deadline)

### UI Components
- ✅ Top bar (money, ducks, bugs, day) - separate component
- ✅ Job info panel (job title, salary) - separate component
- ✅ Task panel (title, complexity, deadline, progress) - separate component
- ✅ **Side project panel** - Shows product name and progress percentage
- ✅ **End game panel** - Shows ending type, message, and stats (from [data/endings.json](../data/endings.json))
- ✅ Retro CRT terminal styling (dark grey/green)
- ✅ Signal-driven updates (no direct UI modification)

### Data-Driven Systems
- ✅ **Tasks** - [data/tasks.json](../data/tasks.json) - All task content (title, description, complexity, categories)
- ✅ **Ship messages** - [data/ship_messages.json](../data/ship_messages.json) - Quality-based messages when shipping
- ✅ **Outage messages** - [data/outage_messages.json](../data/outage_messages.json) - Production outage scenarios and choices
- ✅ **Endings** - [data/endings.json](../data/endings.json) - Game over/victory messages with structured data

---

## 📋 Next Steps

See [ideas/TODO.md](ideas/TODO.md) for immediate implementation tasks.

---

## 📐 FORMULAS & BALANCE

See [reference/game-formulas.md](reference/game-formulas.md) for all formulas, balance targets, and difficulty curve.

---

## 🗺️ ROADMAP & FUTURE IDEAS

See [ideas/roadmap.md](ideas/roadmap.md) for design decisions, deferred features, and future ideas.
