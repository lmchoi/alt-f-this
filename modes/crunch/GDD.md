# Crunch Mode — Game Design Document

**Mode:** crunch
**Tagline:** "Grind mode, but the clock is real"

---

## Overview

Crunch Mode is The Daily Grind with a 60-second real-time countdown per day. The same three actions exist (WORK / HUSTLE / SHIP IT), but your choice must be made before the timer expires — and interruptions fire automatically on a clock instead of being a random daily roll.

**Base design:** Identical to [grind](../grind/GDD.md).
**Only differences:** Timer + interruption timing (documented below).

---

## Core Loop

```
[Timer starts: 60s]
     ↓
Player picks action (WORK / HUSTLE / SHIP IT)
     ↓
Timer counts down — interruptions fire at random intervals
     ↓
Timer hits zero → day auto-advances
     ↓
Event popup resolves (if pending)
     ↓
Next day
```

Work and hustle progress accumulate in real time as the timer runs. The player must choose their action *before* the timer expires, or the day ends with no action taken.

---

## Interruptions

Interruptions fire on a timer interval (not once per day like grind). They pause the timer while the player resolves them.

- **Source data:** `data/interruption_events.json` (branch: `feature/timed-mode`)
- **Sources:** Slack, Email, Calendar, GitHub, PagerDuty, Browser, Kitchen
- **Mechanic:** Handle or Ignore — handling costs time but may give +1 duck or -1 bug

Each interruption event has:
- A handle consequence (resolve it — usually +1 duck or -1 bug)
- An ignore consequence (dismiss it — usually no cost, occasionally -1 duck for high-visibility ones)

Unlike grind's production outages, crunch interruptions are lower-stakes distractions. They represent the constant noise of a real workday.

---

## Key Differences from Grind

| | Grind | Crunch |
|---|---|---|
| Day structure | Turn-based | 60s real-time countdown |
| Interruptions | ~30% daily random chance | Fire at intervals (10s ± 5s) |
| Player pressure | Strategic (time to think) | Reactive (must decide fast) |
| Interruption stakes | High (outages, blames) | Low (Slack DMs, coffee breaks) |

Win/loss conditions, resources, and task mechanics are identical to grind.

---

## Implementation Notes

- Branch: `feature/timed-mode`
- Timer controller: `autoloads/timed_mode_controller.gd`
- Interruption data: `data/interruption_events.json`
- Timer constant in `game_manager.gd`: `TIMED_MODE_DURATION = 60.0`

---

*Balance values: [BALANCE.md](BALANCE.md)*
*Base mode design: [../grind/GDD.md](../grind/GDD.md)*
