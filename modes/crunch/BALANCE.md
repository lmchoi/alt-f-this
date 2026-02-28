# Crunch Mode — Balance Reference

**Mode:** crunch
**Source:** `game_manager.gd` + `data/interruption_events.json` (branch: `feature/timed-mode`)

All values not listed here are identical to [../grind/BALANCE.md](../grind/BALANCE.md).

---

## Timer

| Setting | Value |
|---------|-------|
| Duration per day | 60 seconds |
| Constant | `TIMED_MODE_DURATION = 60.0` |

Work and hustle progress accumulate continuously over the 60s. Formula:

```
# Work
daily_work = 100.0 / (complexity × bug_multiplier)
work_per_second = daily_work / 60.0

# Hustle
daily_hustle = 5.0%
hustle_per_second = 5.0 / 60.0 = 0.083% per second
```

---

## Interruptions

Interruptions fire at random intervals while the timer runs. Timer pauses during resolution.

| Setting | Value |
|---------|-------|
| Interval | 10s ± 5s (5–15s range) |
| Data file | `data/interruption_events.json` |

### Interruption Events (from `interruption_events.json`)

| ID | Source | Handle Effect | Ignore Effect |
|----|--------|---------------|---------------|
| `slack_dm_urgent` | Slack | +1 duck | 0 |
| `meeting_invite` | Calendar | +1 duck | 0 |
| `coffee_break` | Kitchen | +1 duck | 0 |
| `email_from_ceo` | Email | +1 duck | -1 duck |
| `pr_review_request` | GitHub | +1 duck | 0 |
| `production_alert` | PagerDuty | +1 duck, -1 bug | 0 |
| `manager_checkin` | Slack | +1 duck | -1 duck |
| `stackoverflow_question` | Browser | +1 duck, -1 bug | 0 |

**Note:** Ignoring most interruptions is free. Ignoring `email_from_ceo` and `manager_checkin` costs -1 duck (high-visibility senders).
