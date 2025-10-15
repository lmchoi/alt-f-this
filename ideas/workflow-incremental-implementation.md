# Incremental Implementation Workflow

How to implement features in small, testable, committable chunks.

---

## The Golden Rule

**One feature → One commit → One test cycle**

Each step should:
1. Add ONE visible/testable change
2. Be committable (working state)
3. Take 5-15 minutes to implement
4. Be testable immediately

---

## Example: Bugs System (Incremental Approach)

### ❌ What We Did (Big Bang)
```
Commit: "Add entire bugs system"
- 6 files changed
- 4 features added
- Can't test until all UI added
- 200+ lines changed
```

### ✅ What We Should Have Done

#### **Commit 1: Add bugs counter to UI**
**Files changed:**
- `autoloads/game_manager.gd` - Add bugs variable + signal
- `scenes/game_ui.gd` - Add bugs label connection
- `scenes/game_ui.tscn` - Add BugsLabel (you do in Godot)

**Test:**
- Run game
- See "🐛 0" displayed
- Manually change `GameManager.bugs = 50` in console
- Verify label updates to "🐛 50" and turns orange

**Commit message:**
```
Add bugs counter to UI

- Add bugs variable to GameManager with signal
- Display bugs in UI with color coding (white/orange/red)
- No game mechanics yet, just visual display
```

---

#### **Commit 2: Make task complexity slow work**
**Files changed:**
- `scripts/resources/task.gd` - Add complexity property, update do_work()
- `autoloads/task_manager.gd` - Load complexity from JSON
- `autoloads/game_manager.gd` - Use complexity in do_work()

**Test:**
- Run game
- Work on complexity 1 task → ~20% progress per work
- Work on complexity 5 task → ~4% progress per work
- Check console output shows complexity

**Commit message:**
```
Make task complexity affect work progress

- Task.do_work() now accepts complexity multiplier
- Progress = 20 / complexity (no bugs yet)
- TaskManager loads complexity from JSON
- Complexity 1 = 5 work actions, Complexity 5 = 25 work actions
```

---

#### **Commit 3: Make bugs slow work**
**Files changed:**
- `autoloads/game_manager.gd` - Add get_bug_multiplier(), use in do_work()

**Test:**
- Run game
- Manually set bugs: `GameManager.bugs = 40`
- Work on task
- Verify progress is slower (console shows multiplier)
- With 40 bugs, work should be ~40% slower

**Commit message:**
```
Bugs now slow down all work

- Added get_bug_multiplier() function
- Work progress reduced by bug percentage
- 40 bugs = 40% slower, 80 bugs = 80% slower
- Bug multiplier shown in console output
```

---

#### **Commit 4: Add Debug action to reduce bugs**
**Files changed:**
- `autoloads/game_manager.gd` - Add debug() function
- `scenes/game_ui.gd` - Add debug button handler
- `scenes/game_ui.tscn` - Add Debug button (you do in Godot)

**Test:**
- Set bugs to 50 manually
- Press Debug button
- Verify bugs reduce by 15
- Verify day advances, no money gained

**Commit message:**
```
Add Debug action to reduce bugs

- New debug() action removes 15 bugs
- No progress or money, but day advances
- Gives player tool to manage bug accumulation
```

---

#### **Commit 5: Rush shipping adds bugs**
**Files changed:**
- `autoloads/game_manager.gd` - Add rush_ship_task() function
- `scenes/deadline_dialog.gd` - Add rush ship option
- `autoloads/game_manager.gd` - Add "rush_ship" to process_action()

**Test:**
- Work task to 50%
- Wait for deadline
- Choose "Rush Ship It"
- Verify bugs increase by 5
- Verify task completes, new task appears

**Commit message:**
```
Add rush ship option that creates bugs

- Deadline dialog shows "Rush Ship It" if progress >= 50%
- Shipping incomplete adds bugs: (100 - progress) / 10
- Ship at 50% = +5 bugs, at 80% = +2 bugs
- Costs 2 ducks (guilt)
```

---

#### **Commit 6: Add deadline extensions**
**Files changed:**
- `autoloads/game_manager.gd` - Add "extension" to process_action()
- `scenes/deadline_dialog.gd` - Already has button from Commit 5

**Test:**
- Hit deadline
- Choose "Beg Extension"
- Verify deadline extended by 3 days
- Verify -$100, -1 duck

**Commit message:**
```
Add extension option to deadlines

- Player can beg for +3 day extension
- Costs $100 and 1 duck (humiliation)
- Gives alternative to rushing
```

---

## Workflow Process

### Step 1: Plan Commits
Before starting, break feature into commits:
```
Bugs System:
1. UI display only (visual)
2. Complexity slowdown (mechanics)
3. Bugs slowdown (mechanics)
4. Debug action (player tool)
5. Rush ship (bug source)
6. Extensions (alternative choice)
```

### Step 2: Implement One Commit
- I write code for ONE commit
- You add UI in Godot (if needed)
- Test immediately
- Fix any issues

### Step 3: Commit
```bash
git add .
git commit -m "Add bugs counter to UI"
```

### Step 4: Repeat
Move to next commit.

---

## Commit Size Guidelines

### ✅ Good Commit
- **Lines changed**: 20-100
- **Files changed**: 1-3
- **Time to implement**: 5-15 minutes
- **Test time**: 2-5 minutes
- **Can revert safely**: Yes

### ⚠️ Too Small
- **Lines changed**: 1-5
- **Example**: "Fix typo in comment"
- **When it's okay**: Bug fixes, typos, formatting

### ❌ Too Large
- **Lines changed**: 200+
- **Files changed**: 5+
- **Time to implement**: 1+ hour
- **Test time**: 15+ minutes
- **Can revert safely**: No (breaks other features)

---

## Communication Pattern

### When Starting Work

**You say:**
> "Let's implement the bugs system"

**I respond:**
> "Let me break this into commits:
> 1. Add bugs UI counter
> 2. Make complexity slow work
> 3. Make bugs slow work
> 4. Add debug action
> 5. Add rush ship option
>
> Ready to start with #1?"

### Between Commits

**I say:**
> "Commit 1 complete! Code changes done.
>
> **You need to do:**
> - Add BugsLabel in Godot (2 min)
>
> **Test:**
> - Run game, see 🐛 0
>
> When done, commit and we'll move to #2."

**You test, commit, then say:**
> "Committed! Ready for #2"

---

## Example Messages

### Good Commit Messages
```
Add bugs counter to UI

- Display current bug count with 🐛 emoji
- Color codes: white (0-39), orange (40-79), red (80+)
- Connected to GameManager.bugs_changed signal
```

```
Make bugs slow work progress

- Work progress = 20 / (complexity * bug_multiplier)
- Bug multiplier = 1 + (bugs / 100)
- 40 bugs = 40% slower, 80 bugs = 80% slower
```

### Bad Commit Messages
```
WIP
```

```
Update game manager
```

```
Fix stuff
```

---

## Benefits of This Approach

### For You:
- ✅ See progress immediately
- ✅ Test each piece works
- ✅ Can stop/resume easily
- ✅ Clear git history
- ✅ Can show others incremental progress

### For Me:
- ✅ Focus on one thing at a time
- ✅ Get feedback faster
- ✅ Easier to explain what I did
- ✅ Can course-correct if wrong

### For Debugging:
- ✅ "Bugs appeared after Commit 3" → Know where to look
- ✅ Can revert Commit 3 without losing Commits 1-2
- ✅ Bisect issues easily

---

## Template for Planning

When starting a new feature:

```markdown
## Feature: [Name]

### Commit Plan:
1. **[Commit name]**
   - Files: [list]
   - What it does: [description]
   - Test: [how to verify]

2. **[Next commit]**
   - ...

### Estimated time: [X commits × 10 min = Y minutes]
```

---

## Special Cases

### UI-Only Changes (You Do All)
If a commit is pure UI (no code), I skip it:
```
Commit 2: Rearrange UI layout
- You do: Move buttons around in Godot
- I do: Nothing
```

### Code-Only Changes (I Do All)
If no UI needed, you just test:
```
Commit 3: Refactor bug calculation
- I do: Extract function
- You do: Run game, verify no behavior change
```

---

## Your Approval Needed

Does this workflow sound good? Want to modify anything?

Suggested adjustments:
- Smaller commits (5 lines each)?
- Larger commits (100-200 lines)?
- Different breakdown strategy?
- Add pair programming check-ins?

Let me know and I'll adapt! 🚀
