# Job Promotion Feature - Design Prompt

## Goal
Implement a promotion system that:
1. **Increases difficulty** as player progresses (harder tasks, tighter deadlines)
2. **Creates false sense of progression** - "You're doing great!" while trapping player in golden handcuffs
3. **Supports potential "golden handcuffs" bad ending** - Too successful to quit, too deep to escape

---

## Current State

### What Exists
- `job_level` variable in GameManager ([autoloads/game_manager.gd:61](autoloads/game_manager.gd#L61))
- Job level affects task difficulty in TaskManager:
  - Min complexity: `1 + (job_level * 2)`
  - Max complexity: `3 + (job_level * 2)`
  - Deadline bonus: Junior (+2 days), Mid (+1 day), Senior (+0 days)
- `completed_tasks` counter tracks progress ([autoloads/game_manager.gd:62](autoloads/game_manager.gd#L62))
- Job info panel shows job title ([scenes/job_info.gd](scenes/job_info.gd))

### What's Missing
- ❌ No actual JOB_TITLES or JOB_SALARIES constants defined
- ❌ No promotion logic (when to promote)
- ❌ No promotion event/dialog
- ❌ No UI indication that promotion happened
- ❌ No salary increase on promotion
- ❌ No "golden handcuffs" ending

---

## Design Requirements

### Promotion Triggers
**When should player get promoted?**
- Every 5 completed tasks? (predictable but simple)
- Based on quality/bugs? (skill-based but complex)
- Time-based? (punishes hustlers)
- Random + tasks? (unpredictable corporate vibes)

**Suggested approach:** Every 4-6 completed tasks (slight randomness feels corporate)

### Job Progression
**Define the corporate ladder:**

| Level | Title | Salary/5 days | Task Complexity | Deadline Buffer | Notes |
|-------|-------|---------------|-----------------|-----------------|-------|
| 0 | Junior Developer | £500 | 1-3 | +2 days | Tutorial difficulty |
| 1 | Mid-Level Developer | £750 | 3-5 | +1 day | Comfortable zone |
| 2 | Senior Developer | £1,200 | 5-7 | +0 days | Pressure increases |
| 3 | Lead Developer | £1,800 | 6-8 | -1 day | Actively harder |
| 4 | Engineering Manager | £2,500 | 7-9 | -1 day | Golden handcuffs territory |
| 5 | Senior Manager | £3,500 | 8-10 | -2 days | Nearly impossible |

**Salary progression:** Increases significantly, making escape harder to justify financially
**Complexity progression:** Starts reasonable, becomes brutal
**Deadline progression:** Eventually NEGATIVE buffer (due sooner than complexity suggests)

### Promotion Event
**What happens when promoted?**
1. Dialog appears: "CONGRATULATIONS! You've been promoted to [TITLE]!"
2. Show salary increase: "New salary: £X/payday (+£Y)"
3. Subtle dark hint: "With great responsibility comes... more responsibility."
4. Player continues (no choice, just acknowledgment)

**Tone:**
- Positive surface text (corporate celebration)
- Subtle undertones of dread ("more responsibility", "increased expectations")
- No explicit warning it's a trap

### False Sense of Progress
**How to make it feel like winning while losing:**
- 💰 Salary increases are REAL and substantial
- 📈 Title upgrades feel prestigious
- ✅ Recognition for "good performance"
- 🎉 Celebration dialog has positive tone

**BUT:**
- ⚠️ Harder tasks mean MORE bugs accumulated
- ⏰ Tighter deadlines mean MUST ship incomplete work
- 🔒 Higher salary makes escape goal *easier* BUT escape *harder* (less time to hustle)
- 🎭 You're earning more... while dying faster

### Golden Handcuffs Ending (Future)
**Setup for later:**
- If player reaches Level 4-5 AND hasn't hustled much (escape progress <50%)
- High salary but trapped in death spiral
- Game over condition: "GOLDEN HANDCUFFS - You're making too much to quit, but too stressed to stay."
- Stats show: High salary, low escape progress, medium-high bugs

**Don't implement ending yet**, just design promotion system to support it.

---

## Questions to Answer Before Implementing

### 1. Promotion Frequency
- Should it be every 5 tasks exactly? Or 4-6 tasks (randomized)?
- Should promotions slow down at higher levels? (realistic but less dramatic)
- What's the max level? (5-6 levels seems right for 30-50 day games)

### 2. Salary Design
- Should salary increase be flat (+£250) or percentage-based (+50%)?
- Should salary affect escape goal? (e.g., "You need 2x salary to quit comfortably")
- Should there be a way to DECLINE promotion? (interesting choice, but adds complexity)

### 3. UI/UX
- Dialog or event popup?
- Show stats before/after promotion?
- Animate salary increase in top bar?
- Visual "congratulations" effect or keep it deadpan?

### 4. Job Titles
**Proposed titles (dry corporate humor):**
- Junior Developer
- Mid-Level Developer
- Senior Developer
- Lead Developer (or "Tech Lead")
- Engineering Manager (or "Senior Lead Developer")
- Senior Engineering Manager (or "Principal Engineer")

Should titles be realistic or satirical? ("Synergy Architect", "Chief Zoom Officer")

### 5. Difficulty Curve Integration
- Current difficulty is based on `day` AND `job_level`
- Should promotion accelerate difficulty FASTER than time alone?
- What if player grinds tasks quickly? (Level 3 by day 15 = brutal)

### 6. Payday Integration
- Promotion happens immediately on task completion?
- Or on payday? (corporate HR timing)
- Should first promotion come with a "signing bonus"?

---

## Implementation Approach

**If following incremental pattern (3-6 small commits):**

### Commit 1: Define job progression constants
- Add JOB_TITLES, JOB_SALARIES arrays to GameManager
- Update salary on game start based on job_level
- Test: Manually change job_level, verify salary updates
**Files:** game_manager.gd (~15 lines)

### Commit 2: Add promotion check logic
- Check completed_tasks in ship_it()
- Trigger promotion at threshold (e.g., every 5 tasks)
- Update job_level, salary, emit signal
- Test: Complete 5 tasks, verify promotion happens
**Files:** game_manager.gd (~20 lines)

### Commit 3: Create promotion event/dialog
- Listen for promotion signal
- Show dialog with title, salary increase
- Keep tone positive with dark undertones
- Test: See promotion dialog appear
**Files:** game_ui.gd or new dialog scene (~30 lines)

### Optional Commit 4: Polish and tuning
- Adjust promotion frequency based on playtesting
- Tweak salary numbers for balance
- Add subtle visual feedback
**Files:** Various (~10-20 lines)

---

## Gotchas & Considerations

### Balance Risk
- Promoting too fast = impossible difficulty spike
- Promoting too slow = no impact on gameplay
- **Suggested:** First promotion at 5 tasks, then every 5 tasks (levels 0→1→2→3 by ~day 20-30)

### Death Spiral Acceleration
- Higher job_level → harder tasks → more bugs → slower work → ship worse quality → even more bugs
- This is INTENTIONAL (design principle #3: "Death spiral is the game")
- Don't "fix" this - lean into it

### Salary Trap
- Higher salary feels good but makes escape *psychologically* harder
- "Why quit at £2,500/payday when I'm so close to £5K?"
- Mirrors real-world golden handcuffs perfectly

### Edge Cases
- What if player completes 30 tasks in 15 days? (Level cap needed)
- What if promoted during outage/event? (Queue promotion for after)
- What if promoted on payday? (Show promotion, THEN payday)

---

## Success Criteria

**You'll know it's working when:**
- ✅ Players feel proud of promotions initially
- ✅ Players realize "wait, this is harder now" after 2nd/3rd promotion
- ✅ Higher salaries tempt players to grind instead of hustle
- ✅ Difficulty curve feels intentional, not random
- ✅ "Golden handcuffs" ending feels earned/inevitable for certain playstyles

---

## Next Steps

Before implementing:
1. **Decide on promotion frequency** (every X tasks)
2. **Finalize job titles** (realistic or satirical?)
3. **Balance salary progression** (affects escape goal viability)
4. **Choose dialog tone** (deadpan corporate or subtle dread?)
5. **Plan implementation commits** (3-6 small, testable changes)

**Ask me questions and gather more context before coding!**

---

## Reference Files
- [ideas/game-design.md](ideas/game-design.md) - Core design principles
- [ideas/todo.md](ideas/todo.md#L49) - Item #12: "promotion (increase job_level) after X tasks"
- [reference/implementation-status.md](reference/implementation-status.md#L33-34) - Task difficulty scaling by job level
- [reference/game-formulas.md](reference/game-formulas.md#L107-137) - Difficulty curve by week
- [autoloads/game_manager.gd:61](autoloads/game_manager.gd#L61) - Current job_level variable
- [autoloads/task_manager.gd:16-17](autoloads/task_manager.gd#L16-L17) - Complexity scaling formula
