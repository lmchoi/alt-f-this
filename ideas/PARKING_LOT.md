# Parking Lot - Future Tasks & Deferred Decisions

Ideas, improvements, and decisions that are deferred for later consideration.

---

## Deferred UI Improvements

### Gold Color Audit (Low Priority)
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

---

### Interruption Context
**Question:** Should interruptions only show on JOB tab?

**Rationale:**
- Interruptions are job-related (Slack, meetings, etc.)
- ESCAPE tab could stay clean and focused
- Future: ESCAPE might have its own interruptions (investor calls, etc.)

**Decision:** Deferred - need to see how it feels in practice

---

## Future Features (Backlog)

### Active Tab Highlighting
Make it clearer which tab is active:
- Different background color for active tab
- Underline or border emphasis
- Disable active tab button (prevent re-clicking)

### Interruptions Per-Tab
Show job interruptions only on JOB tab:
- Hide interruption stack when viewing ESCAPE tab
- Keep ESCAPE view clean and focused
- Later: Add ESCAPE-specific interruptions (investor calls, competitor launches, etc.)

### Click Reduction
Explore ways to reduce clicks for common actions:
- Global action buttons outside the panel
- Keyboard shortcuts (W for work, H for hustle, S for ship)
- Quick action menu
- Context-sensitive default action

### Swipe Gestures (Mobile)
Mobile-friendly tab switching:
- Swipe left/right to switch between JOB and ESCAPE
- Touch-friendly tab targets
- Gesture feedback/animation

### Juice Improvements
Polish and feel:
- Animated progress bar fills
- Button press feedback (scale, color shift)
- Tab transition animations
- Smooth theme color transitions
- Particle effects for milestones

### Progress Bar Text Position
Move text inside progress bar:
- Percentage inside the bar (centered)
- Better visual hierarchy
- Cleaner layout
- Consider contrast/readability

---

## Questions to Resolve

1. Should ESCAPE tab show money instead of percentage? (e.g., "$2,500" instead of "50%")
2. Should we use different progress bar colors for ESCAPE? (gold gradient instead of quality colors)
3. Do we need a visual indicator for which tab is active beyond the border color?
4. Should tab buttons be disabled/styled differently when active?

---

*Last updated: Current session*
