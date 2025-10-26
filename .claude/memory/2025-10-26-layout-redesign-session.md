# Layout Redesign Session Summary

## Date
2025-10-26

## Playtest Issues Identified

Player tested the game and encountered several UX problems:

1. **Confusing button labels** - Player clicked "Get to work!" instead of "DO JOB", didn't understand which button does what
2. **Escape plan invisible** - Side project panel not noticed (small, isolated in top-left)
3. **Limited action awareness** - Player only used WORK and SHIP IT, didn't discover HUSTLE
4. **Spam-to-failure** - When hinted about escape plan, player spammed REAL WORK and got fired (3 days overdue)

### Root Causes
- **Spatial disconnection**: HUSTLE button far from side project panel it affects
- **Poor naming**: "REAL WORK (Side Project)" sounds like main job
- **No visual hierarchy**: Escape goal buried, not equal to job
- **No tutorial/guidance**: Game expects discovery

## Proposed Layout Solution

### New Visual Hierarchy (Top to Bottom)
```
┌──────────────────────────────────────────────┐
│  💰 $0  |  🐥 3  |  📅 Day 1                 │ ← Simplified top bar
├──────────────────────────────────────────────┤
│  ┌───────────────┐  ┌──────────────────────┐│
│  │ 🚀 ESCAPE     │  │ 🐵 JOB (Lvl 1)       ││ ← Equal weight
│  │ Progress: 0%  │  │ Bugs: 0              ││    side-by-side
│  └───────────────┘  └──────────────────────┘│
│                                               │
│  ┌─────────────────────────────────────────┐│
│  │ TICKET #42: Make Logo Bigger            ││ ← Task details
│  │ Progress: 0% | Deadline: Day 8          ││
│  │                  [🚨 SHIP IT NOW]        ││ ← Ship in task
│  └─────────────────────────────────────────┘│
│                                               │
│         [HUSTLE]            [WORK]           │ ← Clear actions
└──────────────────────────────────────────────┘
```

### Key Changes Made

1. **Top bar simplified** - Removed bugs/level, show only: Money, Ducks, Day
2. **Bugs moved to job panel** - Contextual (it's a job problem, not escape problem)
3. **Side-by-side panels** - Escape Plan and Job Info equal visual weight
4. **SHIP IT in task panel** - Spatially connected to what it affects
5. **Clearer button names** - HUSTLE (escape) and WORK (job)

## Styling Improvements

### Visual Consistency - Theme Matching

**Escape Panel (Gold theme):**
- Border: 3px gold `Color(0.9, 0.7, 0.3, 1)`
- Background: Dark brown `Color(0.15, 0.12, 0.08, 1)`
- Header: Gold (22px)
- Info: Soft green (20px)
- Corner radius: 6px, shadow: gold glow

**Job Panel (Silver/Grey theme):**
- Border: 3px grey `Color(0.6, 0.6, 0.65, 1)`
- Background: Dark blue-grey `Color(0.12, 0.12, 0.15, 1)`
- Header: Silver `Color(0.75, 0.75, 0.8, 1)` (22px)
- Info: Corporate blue `Color(0.6, 0.75, 0.85, 1)` (20px)
- Corner radius: 6px, shadow: grey

**Button Styling:**
- HUSTLE button: Gold border/text (matches escape panel)
- WORK button: Silver border/text (matches job panel)
- Hover states: Brighter versions of base colors

### Theme Refactor (Attempted)

Created `scripts/ui/theme_colors.gd` as autoload singleton to centralize colors:
```gdscript
const ESCAPE_GOLD = Color(0.9, 0.7, 0.3, 1)
const JOB_SILVER = Color(0.75, 0.75, 0.8, 1)
const JOB_INFO = Color(0.6, 0.75, 0.85, 1)
// etc...
```

**Issue encountered:** Parser error with autoload + class_name
**Resolution:** Deferred - user will refactor later themselves

**Current state:** Colors duplicated across files, but documented in ThemeColors for future refactor

## Future Considerations Discussed

### Real-time Mode (Future)
- 60s timer per day instead of turn-based
- Interruptions/notifications that pause work
- Schrodinger's notification: see 🔔 but don't know what it is until clicked
- More Papers Please urgency

**Decision:** Keep turn-based for MVP, add real-time later

### Task Queue/Pile System (Future)
- Multiple tasks stacking up
- Work on one at a time, reorder pile
- Task switching costs
- "Inbox zero" anxiety

**Decision:** Defer to later, too complex for MVP

### Tutorial/Onboarding (Needed)
- First-day popup explaining goal and mechanics
- Deadline warnings when overdue
- Button tooltips
- Show consequences: "(Escape +10%)"

**Decision:** Not implemented this session, but high priority

## Implementation Notes

### Incremental Approach
- Small commits: 20-100 lines, 1-3 files each
- Test after each change before proceeding
- Do one thing, when changing visuals, don't change content/logic

### Files Modified
- `scenes/top_bar.tscn` - Removed bugs display
- `scenes/top_bar.gd` - Removed bugs signal/update logic
- `scenes/job_info.tscn` - Added styling, bugs display
- `scenes/job_info.gd` - Added color theme, bugs/level updates
- `scenes/task_panel.tscn` - Added SHIP IT button inside panel
- `scenes/task_panel.gd` - Added ship_it_pressed signal
- `scenes/game_ui.tscn` - Added grey/silver button styles, connected task panel signal
- `scenes/game_ui.gd` - Connected task panel SHIP IT to handler
- `scripts/ui/theme_colors.gd` - Shared color constants (partial refactor)
- `project.godot` - Added ThemeColors autoload

## Commits Made

1. Move bugs from top bar to job panel
2. Move ship it button to task panel
3. Restyle job panel and WORK button with grey/silver theme

## Color Theme Refinement (Later Same Day)

### Three Distinct Themes Established

**Core UI (Gold/Blue)** - Universal HUD elements:
- Screen background: Blue tint `Color(0.05, 0.08, 0.12, 1)` (was green)
- Top bar: Dark `Color(0.08, 0.08, 0.1, 1)` with gold border `Color(0.9, 0.75, 0.3, 1)`
- Money/Ducks: Gold text `Color(0.9, 0.75, 0.3, 1)` (escape resources)
- Day: Silver text `Color(0.75, 0.75, 0.8, 1)` (job context)

**Job/Work Theme (Silver/Blue-Grey)** - Corporate grind:
- Task panel: `Color(0.12, 0.12, 0.15, 1)` with medium grey border `Color(0.6, 0.6, 0.65, 1)`
- Job info panel: Same background with brighter silver border `Color(0.75, 0.75, 0.8, 1)`
- WORK button: Pure grey backgrounds `Color(0.06, 0.06, 0.06)` with silver border/text
- Theme: Cool, oppressive, corporate blue-grey

**Escape/Side Project Theme (Gold/Warm)** - Freedom/banana theme:
- Side project panel: Warm brown `Color(0.15, 0.12, 0.08, 1)`
- HUSTLE button: Pure grey backgrounds `Color(0.06, 0.06, 0.06)` with gold border/text
- Theme: Warm, hopeful, matches banana/monkey theme

### Green Tint Removal
Removed all green tints throughout UI:
- Screen background: Green → Blue tint
- Top bar: Green → Dark with subtle blue
- HUSTLE button: Green backgrounds → Pure grey
- Main theme still has green (unused legacy)

### Button Unification
Both WORK and HUSTLE now share:
- Same neutral grey backgrounds (0.06 normal, 0.11 hover)
- Only borders/text differ (silver vs gold)
- Better contrast for both color schemes

### Outstanding Items

**End Game Panel** (`scenes/end_game_panel.tscn`):
- Current: Green tint `Color(0.05, 0.08, 0.05, 0.95)` ⚠️
- Suggested: Context-aware styling
  - Victory: Gold theme with gold border
  - Defeat: Dark theme with red border

**Dialog Theme** (`themes/dialog_theme.tres`):
- Current: Green theme ⚠️
- Suggested: Core UI gold/blue as default
  - Background: `Color(0.08, 0.08, 0.12, 1)`
  - Border/Title: Gold `Color(0.9, 0.75, 0.3, 1)`
  - Text: Silver `Color(0.75, 0.75, 0.8, 1)`
  - Future: Specialized themes for job/escape dialogs

### Commits Made (Color Theme)
1. Apply gold/blue core UI theme and remove green tints
2. Match WORK and HUSTLE button backgrounds
3. Show green indicator when task is ready to ship

## Next Steps (Deferred)

1. Update dialog theme to core UI gold/blue
2. Style end game panel (context-aware victory/defeat)
3. Complete theme refactor (centralize all colors)
4. Add first-day tutorial popup
5. Add deadline warning system
