# Next Session Plan - Task Panel Polish & Refinements

**Context:** We've completed the unified task panel with JOB/ESCAPE tabs. Now polishing the UI based on initial feedback.

---

## What We Just Completed

### ✅ Unified Task Panel with Tabs
**Status:** Complete and working

**Commit:** `b43c743` - Add unified task panel with JOB/ESCAPE tabs

**What works:**
- Tab switching between 💼 JOB and 🚀 ESCAPE
- JOB tab: Shows work tasks with WORK/SHIP IT buttons
- ESCAPE tab: Shows side project with HUSTLE button
- Gold border theme for ESCAPE tab
- Button visibility toggles based on active tab
- Progress updates for both job tasks and side project

**Files modified:**
- `scenes/task_panel_v2.tscn` - Added tabs, HUSTLE button, gold theme
- `scenes/task_panel_v2.gd` - Tab logic, theme switching, split display
- `scenes/game_ui.gd` - Wired hustle_pressed signal

---

## Next Tasks: UI Polish & Refinements

### Task 1: Fix Interruption Stack Layout (High Priority)
**Problem:** Interruption cards push the rest of the UI up when they appear

**Solution:**
- Add fixed/max height container for interruption stack
- Make it scrollable if too many interruptions
- Prevent layout shift when cards are added/removed

**Files to modify:**
- `scenes/game_ui.tscn` - Add ScrollContainer or fixed height container
- Check InterruptionStack node configuration

**Estimated time:** 30 mins

---

### Task 2: Clean Up ESCAPE Tab Progress Display (Medium Priority)
**Problem:** Too much text below the progress bar on ESCAPE tab

**Current ESCAPE display:**
- Progress bar with color
- **48px** percentage below bar
- **24px** "$X / $5000" below that
- Quality guide with emojis (not relevant for escape)

**Changes needed:**
- Remove the "$X / $5000" text (redundant with percentage)
- Remove quality guide (job-specific, not needed for escape)
- Keep percentage visible (or move inside bar if preferred)

**Files to modify:**
- `scenes/task_panel_v2.gd` - Update `_show_escape_task()` function
- Possibly hide quality_guide element when on ESCAPE tab

**Estimated time:** 15 mins

---

### Task 3: Audit Gold Color Usage (Low Priority)
**Problem:** Gold color might be used in job-related elements when it should be ESCAPE-only

**Goal:**
- Ensure gold (Color 0.9, 0.75, 0.3) is only used for ESCAPE elements
- Job elements should use neutral grays/blues

**Files to check:**
- `scenes/task_panel_v2.gd` - Progress bar colors
- `themes/` - Any theme files
- Other UI elements that might use gold

**Estimated time:** 20 mins

---

## Deferred Considerations

### Tab Interaction Improvements
**Question:** Should we reduce clicks to perform actions?

**Current flow:**
- Click JOB tab → Click WORK button (2 clicks to work)
- Click ESCAPE tab → Click HUSTLE button (2 clicks to hustle)

**Potential improvements (discuss first):**
- Keep dedicated WORK/HUSTLE buttons outside panel?
- Auto-perform action when tab is clicked?
- Wait until we have better sense of what job panel contains

**Decision:** Deferred - test current implementation first

### Interruption Context
**Question:** Should interruptions only show on JOB tab?

**Rationale:**
- Interruptions are job-related (Slack, meetings, etc.)
- ESCAPE tab could stay clean and focused
- Future: ESCAPE might have its own interruptions (investor calls, etc.)

**Decision:** Deferred - need to see how it feels in practice

---

## Quick Start Commands (Next Session)

1. **Run the game** - Test current implementation, feel the interactions
2. **Task 1:** Fix interruption stack layout (prevent UI push)
3. **Task 2:** Clean up ESCAPE tab progress display
4. **Task 3:** Audit gold color usage
5. **Test & commit** each change incrementally

---

## Success Criteria

Session complete when:
- ✅ Interruption cards don't push other UI elements
- ✅ ESCAPE tab has cleaner progress display (no redundant text)
- ✅ Gold color only appears on ESCAPE-related elements
- ✅ No visual regressions on JOB tab
- ✅ All changes tested and committed

Estimated time: **1-1.5 hours** for all tasks.

---

## Future Features (Backlog)

1. **Active tab highlighting** - Make it clearer which tab is active
2. **Interruptions per-tab** - Show job interruptions only on JOB tab
3. **Click reduction** - Explore ways to reduce clicks for common actions
4. **Swipe gestures** - Mobile-friendly tab switching
5. **Juice improvements** - Animated progress, button feedback, tab transitions

---

Good luck! 🎨
