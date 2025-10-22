# TODO: Next Implementation Steps

Core mechanics to implement for the redesigned game loop.

---

## 1. Payday System
**Payment every 5 days instead of immediate**

- [ ] Add `days_until_payday` property to GameManager (counts down 5→1)
- [ ] Add `completed_tasks_this_cycle` array to track pending payments
- [ ] Update `ship_it()`: Complete task but don't pay immediately
- [ ] Add payday logic to `next_day()`: Pay all completed tasks on day % 5 == 0
- [ ] Update UI to show "Payment pending - Payday in X days"

---

## 2. HUSTLE Redesign
**Build escape progress instead of immediate money**

- [ ] Add `escape_progress` property to GameManager (0-100%)
- [ ] Add escape progress bar to UI
- [ ] Update `hustle()`:
  - Add 8-12% escape progress
  - +1 duck if not overdue, -1 duck if overdue
  - Remove immediate money payment
- [ ] Add escape progress thresholds (25/50/75/100%) with flavor text
- [ ] Update victory conditions: $5K OR ($3K + 75%) OR ($2K + 100%)

---

## 3. Overdue Firing System
**Get fired after 3 days overdue**

- [ ] Add `overdue_days` property to GameManager
- [ ] Track overdue status in `next_day()`: If deadline passed, increment overdue_days
- [ ] Add warning dialogs:
  - Day 1: "Your task is overdue. Manager is asking questions."
  - Day 2: "Task 2 days overdue. Manager is very unhappy. One more day..."
  - Day 3: "FIRED - Failure to complete assigned work"
- [ ] Reset overdue_days when task is shipped
- [ ] Update HUSTLE to increment overdue_days (makes it risky)

---

## 4. Post-Completion Choice Screen
**Show clear options after shipping**

- [ ] Create post-ship dialog with two options:
  - [ACCEPT NEW TASK] - Get new task immediately
  - [HUSTLE] - Build escape progress (if not at deadline)
- [ ] Show payment status: "Payment pending - Payday in X days"
- [ ] Show current escape progress %
- [ ] Update game flow to pause after ship until choice is made
