# Incremental Implementation Workflow

How to break features into small, testable commits.

---

## The Rule

**One feature → Multiple small commits → Test after each**

Each commit should:
1. Add ONE testable change
2. Be in a working state
3. Take 5-15 minutes
4. Have 20-100 lines changed, 1-3 files

---

## Process

### Step 1: Plan Commits
Break feature into 3-6 small commits before starting.

Example: "Add escape progress system"
1. Add escape_progress variable + UI display
2. HUSTLE increases escape_progress
3. Add overdue_days tracking
4. HUSTLE while overdue costs duck + increases overdue_days
5. Add multiple victory conditions
6. Fire player at 3+ overdue days

### Step 2: Implement One at a Time
- Write code for ONE commit
- Test immediately (run game to verify it works)
- Fix issues
- Commit with clear message

### Step 3: Repeat
Move to next commit.

---

## Testing Checklist

After EVERY commit, verify the game runs:

```bash
# Quick test - does the game load without errors?
godot --headless --quit 2>&1 | grep -i error

# Full test - run the game and manually verify
godot  # Press F5 to run, test the feature
```

**Common errors to watch for:**
- UID collisions (see [godot-best-practices.md](godot-best-practices.md))
- Missing node references (`Node not found`)
- Signal connection errors
- Type mismatches

---

## Commit Message Format

```
Brief description (what changed)

- Detail 1 (specific change)
- Detail 2 (specific change)
- Detail 3 (impact/behavior)
```

**Good:**
```
Add escape progress tracking

- Add escape_progress variable (0-100%) to GameManager
- Display progress bar in UI below salary
- No game mechanics yet, just visual display
```

**Bad:**
```
WIP
Update game manager
Fix stuff
```

---

## Benefits

- Test each piece works before moving on
- Easy to revert single commit if needed
- Clear what each change did
- Can pause/resume between commits
- "Bug appeared after commit 3" = know where to look

---

## Communication Pattern

**When starting:**
> "I'll break this into 5 commits:
> 1. Add escape progress variable + UI
> 2. HUSTLE increases progress
> 3. Track overdue days
> 4. Overdue penalty
> 5. Victory conditions
>
> Starting with #1..."

**After each commit:**
> "Commit 1 done. Test: run game, see progress bar at 0%.
> Ready for commit 2?"
