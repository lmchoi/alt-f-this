# The Daily Grind — Balance Reference

**Mode:** grind (V1)
**Source:** `autoloads/game_manager.gd` constants + V1 design

---

## Starting State

| Resource | Start Value |
|----------|-------------|
| Money | $0 |
| Ducks | 3 |
| Bugs | 0 |
| Escape Progress | 0% |
| Day | 1 |

---

## Win / Loss Thresholds

| Condition | Threshold |
|-----------|-----------|
| Victory (money goal) | $5,000 + 100% escape |
| Burnout | 0 ducks |
| Death spiral | 100+ bugs |
| Fired (deadline) | Overdue ≥ 3 days AND on PIP |
| Optics deadline | Overdue ≥ 1 day |
| Max PIP warnings before fired | 2 |
| Max blame strikes before collapse | 3 |

---

## Actions

### WORK
Work progress per day (timed mode: scaled over 60s, turn mode: applied per turn):

```
daily_work = 100.0 / (complexity × bug_multiplier)
bug_multiplier = 1.0 + (bugs × 0.01)
```

Examples:
| Complexity | Bugs | Days to Complete |
|------------|------|-----------------|
| 5 | 0 | 5 days |
| 5 | 40 | ~7 days |
| 5 | 80 | ~9 days |

### HUSTLE
- Progress: +5% escape per day
- Payment: $200

### SHIP IT
- Minimum shippable: 20% progress
- Bugs formula: `(100 - progress) / 10` rounded down
- Tech Debt multiplier: ×3.0
- Poor quality threshold (triggers outage risk): <50%
- Critical outage threshold: <80%

---

## Ship Quality Bands

| Progress | Bugs Added | Notes |
|----------|------------|-------|
| 90-100% | 0-1 | Earn clean code token |
| 70-89% | 1-3 | Acceptable |
| 50-69% | 3-5 | Poor |
| 20-49% | 5-8 | Terrible, outage risk |
| <20% | Blocked | Can't ship |

---

## Salary & Payday

| Job Level | Per Payday |
|-----------|------------|
| Junior Dev | $300 |
| Mid-Level Dev | $500 |
| Senior Dev | $800 |

- Payday every: 5 days
- Promotion threshold: every 10 tasks completed

---

## Production Outages

```
outage_chance = bugs × 0.005 × poorly_shipped_tasks.count
```

- Critical tasks shipped <80%: guaranteed outage next day
- Max blames before company collapse: 3

---

## Events (Random Work Events)

30% chance per day one fires:

| Event | Duck Change | Money Change |
|-------|-------------|--------------|
| "Boss says: 'We're a family.'" | -1 | $0 |
| "Free pizza! (It's vegan.)" | +1 | $0 |
| "Legacy code explodes." | 0 | -$50 |

---

## Task Difficulty Curve

| Phase | Complexity | Deadline |
|-------|------------|----------|
| Week 1-2 | Low | Long |
| Week 3-4 | Medium | Tight |
| Week 5-6 | High | Very tight |
| Week 7+ | High | Impossible |
