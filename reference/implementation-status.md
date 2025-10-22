# Implementation Status

Quick reference for what's built vs what's next.

---

## ✅ IMPLEMENTED (Playable Core Loop)

### Core Actions
- ✅ **WORK** - Makes progress, complexity + bugs affect speed
- ⚠️ **HUSTLE** - Currently gives $200 + duck, NEEDS UPDATE to escape progress system
- ⚠️ **SHIP IT** - Currently pays immediately, NEEDS UPDATE to payday system
- ✅ **20% minimum** - Can't ship below 20% (cheeky messages)
- ✅ **Deadline duck cost** - Hustle while overdue: -1 duck (prevents exploit)

### Resources
- ✅ Money (tracks escape fund)
- ✅ Ducks (mental health, 0 = game over)
- ✅ Bugs (slow work, 100+ = game over)
- ✅ Day counter
- ✅ Salary (fixed per task)
- ❌ **MISSING:** Escape Progress (0-100%, for HUSTLE system)
- ❌ **MISSING:** Overdue Days (tracking for firing at 3 days)
- ❌ **MISSING:** Days Until Payday (5-day cycle)

### Task System
- ✅ Tasks from JSON with complexity (1-10)
- ✅ Complexity affects work speed: `20 / (complexity × bug_multiplier)`
- ✅ Deadlines (affects hustle duck cost)
- ✅ Progress bar (updates in real-time)
- ✅ Quality messages on ship (rock_bottom → excellent)
- ✅ "Too early to ship" messages

### Production Outages
- ✅ Ship <50% → time bomb (poorly_shipped_tasks array)
- ✅ Outage chance: `bugs × 0.5% × poorly_shipped_count`
- ✅ Outage dialog with choices (Blame/Responsibility/Systemic)
- ✅ Outage consequences loaded from JSON
- ✅ Track production_outages, pip_warnings, total_blames

### Win/Lose Conditions
- ✅ Victory at $5,000 (only path implemented)
- ❌ **MISSING:** Victory at $3K + 75% escape
- ❌ **MISSING:** Victory at $2K + 100% escape
- ✅ Game over at 0 ducks
- ✅ Game over at 100+ bugs
- ❌ **MISSING:** Game over at 3 days overdue (fired)
- ✅ Death spiral ending message

### UI Components
- ✅ Top bar (money, ducks, bugs, day) - separate component
- ✅ Job info panel (job title, salary) - separate component
- ✅ Task panel (title, complexity, deadline, progress) - separate component
- ✅ Retro CRT terminal styling (dark grey/green)
- ✅ Signal-driven updates (no direct UI modification)

---

## 📋 Next Steps

See [ideas/TODO.md](ideas/TODO.md) for immediate implementation tasks.

---

## 📐 FORMULAS & BALANCE

See [reference/game-formulas.md](reference/game-formulas.md) for all formulas, balance targets, and difficulty curve.

---

## 🗺️ ROADMAP & FUTURE IDEAS

See [ideas/roadmap.md](ideas/roadmap.md) for design decisions, deferred features, and future ideas.
