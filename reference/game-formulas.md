# Game Formulas & Balance

Quick reference for exact math and balance numbers.

---

## Core Formulas

### Work Progress
```gdscript
progress += 100 / (complexity × bug_multiplier)
bug_multiplier = 1 + (bugs × 0.01)
```

**Examples:**
- Complexity 5, 0 bugs: 100 / (5 × 1.0) = 20% per day → 5 days
- Complexity 5, 40 bugs: 100 / (5 × 1.4) = 14.3% per day → 7 days
- Complexity 5, 80 bugs: 100 / (5 × 1.8) = 11.1% per day → 9 days

### Bugs from Shipping
```gdscript
bugs_added = (100 - progress) / 10
```

**Examples:**
- Ship at 90%: +1 bug
- Ship at 70%: +3 bugs
- Ship at 40%: +6 bugs
- Ship at 20%: +8 bugs

### Hustle (Escape Progress)
```gdscript
escape_progress += randi_range(8, 12)  # ~10 hustles to reach 100%

if overdue:
    ducks -= 1  # Risk: neglecting corporate work
    overdue_days += 1  # Accelerates firing
else:
    ducks += 1  # Autonomy feels good
```

### Overdue Warnings & Firing
```gdscript
if overdue_days == 1:
    show_warning("Your task is overdue. Manager is asking questions.")
elif overdue_days == 2:
    show_warning("Task 2 days overdue. Manager is very unhappy. One more day...")
elif overdue_days >= 3:
    game_over("FIRED - Failure to complete assigned work")
```

### Payday System
```gdscript
# Payday every 5 days (Day 5, 10, 15, 20...)
days_until_payday = 5 - (day % 5)
is_payday = (day % 5 == 0)

# On payday: pay for all completed tasks that cycle
# Salary is fixed per task (e.g., $300-500)
```

### Task Categories (Risk Modifiers)
```gdscript
# Optics: Ship <70% = CEO anger, 30% chance CEO loves mediocrity
# Tech Debt: Ship <70% = bugs × 1.5, ship >85% = reduce bug impact 10%
# Critical: Ship <70% = high outage risk within 2 days, ship >80% = reputation boost
```

### Victory Conditions
```gdscript
money >= 5000  # Pure corporate grind
OR (money >= 3000 AND escape_progress >= 75)  # Balanced approach
OR (money >= 2000 AND escape_progress >= 100)  # Startup is viable
```

### Game Over Conditions
```gdscript
ducks <= 0  # Burnout
OR bugs >= 100  # Death spiral
OR overdue_days >= 3  # Fired for neglecting work
OR production_outages >= 3  # (Future: fired for poor quality)
```

---

## Balance Targets

### Work Speed by Bug Count
- **0 bugs:** Complexity 5 task = ~5 days of work
- **40 bugs:** Same task = ~7 days (40% slower)
- **80 bugs:** Same task = ~9 days (80% slower)

### Escape Timeline
- Target: 30-50 days depending on strategy
- Pure grind path: $5K in 35-45 days
- Balanced path: $3K + 75% escape in 30-40 days
- Hustler path: $2K + 100% escape in 35-50 days

### Resource Economy
- **Starting state:** $0, 3 ducks, 0 bugs, 0% escape
- **Salary:** $300-500 per task (fixed)
- **Payday:** Every 5 days
- **Ducks:** Rarely gain back (events, quality ships)

---

## Difficulty Curve (Escalating Pressure)

### Week 1-2 (Days 1-10): Onboarding
- **Task complexity:** 1-3
- **Deadlines:** 5-7 days
- **Player state:** Low bugs, learning
- **Expected behavior:** Ship at 80-90% quality

### Week 3-4 (Days 11-20): Reality Sets In
- **Task complexity:** 4-6
- **Deadlines:** 3-5 days
- **Player state:** 20-30 bugs accumulated
- **Expected behavior:** Tempted to ship at 60-70%

### Week 5-6 (Days 21-30): Crisis Mode
- **Task complexity:** 7-9
- **Deadlines:** 2-3 days
- **Player state:** 40-60 bugs, work 40-60% slower
- **Expected behavior:** Must ship at 40-50% to survive

### Week 7+ (Days 31+): Breaking Point
- **Task complexity:** 8-10
- **Deadlines:** 1-2 days
- **Player state:** 60+ bugs, near $5K goal
- **Expected behavior:** Desperate, ship at 20-30%

### Implementation
```gdscript
# Use TaskManager.get_random_task(day, min_complexity, max_complexity)
# to scale difficulty based on current day
```
