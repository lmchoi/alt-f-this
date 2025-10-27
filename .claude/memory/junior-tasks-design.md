# Junior Level Tasks Design Decision

## Context

Currently implementing Jr → Mid promotion system. Jr level filters out tasks with categories (tech_debt, critical, optics), but we don't have any tasks WITHOUT categories in the task pool yet.

**Current code:** [autoloads/task_manager.gd:25-27](autoloads/task_manager.gd#L25-L27)
```gdscript
# Jr level (0): Filter out tasks with categories (no tech debt yet)
if job_level == 0:
    valid_tasks = valid_tasks.filter(func(task): return task["categories"].size() == 0)
```

**Problem:** This currently returns empty set → fallback to all tasks.

---

## Design Options

### Option 1: Strip categories from existing tasks
- Random tasks from existing pool, just set `categories = []` at Jr level
- **Pro:** Simple, reuses existing content
- **Con:** Wastes the category system already built
- **Con:** Less intentional about Jr experience

### Option 2: Create baby set / tutorial tasks
- Curated first 10-15 tasks specifically for Jr level
- Strong writing to set up premise and dark comedy tone
- Could be fixed sequence OR random from Jr pool
- **Pro:** Papers Please style - scripted early narrative
- **Pro:** Introduce mechanics gradually (SHIP IT, bugs, deadlines)
- **Pro:** Can establish game tone with strong writing
- **Con:** More writing work upfront

Sub-options:
- A) Fixed sequence (everyone gets same 10 tasks in order)
- B) Random Jr pool (15-20 Jr tasks, pick randomly)
- C) Hybrid (first 3 fixed for tutorial, then random from Jr pool)

### Option 3: Categories with no consequences (tutorial mode)
- Jr level gets regular tasks WITH categories
- Categories are visible but have NO mechanical impact
- Acts as tutorial to teach what each category means
- At Mid level, categories start having real consequences
- **Pro:** Educational - player learns categories risk-free
- **Pro:** No need for separate task pool
- **Pro:** Smooth transition to Mid level (already familiar with categories)
- **Con:** May be confusing why categories don't matter
- **Con:** Less distinct Jr experience

### Option 4: Hybrid stripped + tutorial
- Jr level: Use existing tasks but strip categories from display
- Add tutorial popups/tooltips explaining mechanics
- Mid level: Categories appear and matter
- **Pro:** Reuses content, adds learning layer
- **Con:** Still feels like we're hiding existing system

---

## Questions to Answer

1. **Narrative importance:** How important is the Jr → Mid transition narratively? Is it just mechanical or story beat?

2. **Tutorial needs:** Do we need to teach mechanics gradually, or throw players in deep end?

3. **Replayability:** Fixed sequence vs random - which serves the game better?

4. **Writing bandwidth:** How much new content can we create for Jr tasks?

5. **Category education:** Should players learn what categories mean before they matter?

---

## Recommendation Needed

Pick one option and implement:
- If Option 2: Create Jr task pool in [data/tasks.json](data/tasks.json)
- If Option 3: Modify category impact logic in [autoloads/game_manager.gd](autoloads/game_manager.gd) to check job level
- If Option 1/4: Modify filtering logic in [autoloads/task_manager.gd](autoloads/task_manager.gd)

**Current state:** Jr level promotion system is implemented but Jr tasks are undefined. Game currently falls back to full task pool.

---

## User's Preferred Direction: Option 3 with Educational Feedback

**"They don't get penalized but they are informed what it does if they fail"**

### How this would work:

**Jr Level behavior:**
- Tasks have categories (tech_debt, critical, optics) visible
- Categories have NO mechanical impact (no extra bugs, no guaranteed outages, no deadline penalties)
- When player ships poorly or misses deadline, show educational message explaining what WOULD happen at Mid level

**Example messages:**

*Ship tech_debt task at 60%:*
```
"You shipped incomplete code with technical debt.

At Mid-Level, this would add 3× bugs.
(But you're Junior, so management expects this.)"
```

*Ship critical task at 70%:*
```
"Critical system shipped at 70%.

At Mid-Level, this would cause guaranteed production outage.
(But you're Junior, so seniors will clean it up.)"
```

*Miss optics task deadline:*
```
"Optics task missed deadline.

At Mid-Level, you'd get PIP warning after 1 day late.
(But you're Junior, you get 3 days grace period.)"
```

### Benefits:
- ✅ Players learn category mechanics risk-free
- ✅ Builds anticipation for Mid level ("oh no, this will matter soon")
- ✅ Teaches without punishing
- ✅ Fits narrative (juniors get more slack)
- ✅ No need for separate task pool

### Implementation:
1. Modify category impact checks in [autoloads/game_manager.gd](autoloads/game_manager.gd) to check `job_level`
2. Add educational messages for Jr level in ship_it() and deadline logic
3. Keep categories visible in UI (no changes to task display)
4. Full consequences activate at `job_level >= 1` (Mid+)

### Code locations to modify:
- `ship_it()` tech debt multiplier (line 383)
- `ship_it()` critical/poor quality tracking (line 394-399)
- `advance_turn()` deadline PIP logic (line 266)
- Add new messages to [data/ship_messages.json](data/ship_messages.json) or inline

---

## Decision: Implement Option 3 with Educational Feedback

This approach:
- Uses existing task pool (no new content needed)
- Teaches mechanics through play
- Fits the "junior protection" narrative
- Creates smooth learning curve
