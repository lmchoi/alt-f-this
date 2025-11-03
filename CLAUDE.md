# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

---

## Project Overview

**Code Monkey** (working title: "Alt+F+This") - *"Office Space meets Universal Paperclips with duck-based resource allocation"*

A darkly comedic time-allocation strategy game built in Godot 4.5 where you're a tech worker trapped in corporate hell. Allocate your ducks 🦆 between job tasks and your secret startup. Ship quality work or cut corners? Risk getting caught hustling? Escape with $3K or revenue before you get fired.

**V2 Design Status:** Full redesign complete (see [ONE-PAGER.md](ONE-PAGER.md), [GDD.md](GDD.md), [CORE-LOOP-SIMPLIFIED.md](CORE-LOOP-SIMPLIFIED.md)). V1 prototype archived in `archive/v1/`. Reusing ~60% of architecture (signal-driven design, JSON data, GameManager/TaskManager).

---

## Game Design Vision

**See [GDD.md](GDD.md) for complete V2 design. V1 archived in `archive/v1/game-design.md`.**

### Core Concept (V2)
Office Space meets Universal Paperclips. Allocate 8 ducks 🦆 per day between job work and your secret startup. Rare special events create dramatic moments. Escape before you get caught 3 times or trapped in golden handcuffs.

### Core Loop (30-45 seconds per day)
1. **Allocate** 8 ducks between job task and startup (job vs startup split)
2. **Start Day** - simulation happens automatically
3. **Special Event** (if triggered, ~25% of days) - rare dramatic moments
4. **Results** - see progress on job and startup
5. **Ship Decision** (if job task ready) - ship now or wait?
6. **Consequences** - bugs added, payment, new task
7. **Next Day**

### Key Design Principles (V2)
1. **Simple core loop** - Allocate → Results → Ship → Repeat (30-45 sec per day)
2. **Rare special events** - Only 8-12 events per 30-40 day game (not daily interruptions)
3. **Caught hustling tension** - Detection chance based on allocation (10-70%), 3-strike system
4. **Dual win conditions** - App complete + money OR app complete + revenue
5. **Bugs NEVER decrease** - Still core tension (permanent technical debt)
6. **"Boring" UI as satire** - Looks like real dev tools (Jira, Slack, Git)

---

## Running the Game

Open project in Godot 4.5 and press F5. Main scene: [scenes/game_ui.tscn](scenes/game_ui.tscn)

---

## Architecture & Workflow

### Font Size Hierarchy

Consistent font sizing for readability. Base defaults in [themes/main_theme.tres](themes/main_theme.tres). Scene files override as needed.

- **48px**: End game title (dramatic impact)
- **32px**: Top bar stats (always visible, critical info)
- **28px**: Task titles, dialog titles (primary headings)
- **24px**: Progress percentage, deadline (high visibility metrics)
- **22px**: Task description, action buttons (important actions)
- **20px**: Base labels, metadata, badges (minimum readable size - theme default)

To change font sizes:
1. Update scene-specific overrides in .tscn files (e.g., [scenes/task_panel.tscn](scenes/task_panel.tscn))
2. Update theme defaults in theme files
3. Keep this hierarchy in sync with actual usage

### Incremental Implementation

**IMPORTANT:** Break features into small, testable commits (20-100 lines, 1-3 files each).

Before implementing any feature:
1. Plan 3-6 small commits
2. Each commit should be immediately testable
3. Implement → Test → Commit → Next

See [reference/workflow-incremental-implementation.md](reference/workflow-incremental-implementation.md) for details.

**Signal-Driven Design:**
- GameManager holds all state with property setters that emit signals
- UI components connect to signals in `_ready()`
- Never update UI directly - always emit signals from GameManager
- **V2 Note:** Architecture remains the same, core loop logic will be rebuilt

**Autoloaded Singletons:**
- **GameManager** ([autoloads/game_manager.gd](autoloads/game_manager.gd)) - Central game state, all properties emit signals
- **TaskManager** ([autoloads/task_manager.gd](autoloads/task_manager.gd)) - Loads tasks from JSON, handles difficulty scaling

**V1 → V2 Reuse (~60% of codebase):**
- ✅ Keep: Signal-driven architecture, JSON data loading, bug system, payday system, ship quality system, end game panel
- 🔄 Modify: Task display (single task, not panel), action UI (allocation, not WORK/HUSTLE/SHIP buttons), event system
- ✅ Build New: Allocation UI, caught hustling system, startup feature tree, rare event popups

See [reference/implementation-status.md](reference/implementation-status.md) for V1 API. See [V2-KEY-CHANGES.md](V2-KEY-CHANGES.md) for V2 changes.

---

## Critical Implementation Notes (V2)

### ⚠️ Bugs Are PERMANENT
**NEVER implement bug reduction.** No DEBUG action. Bugs never decrease. This is still core tension in V2.

### ⚠️ Ducks Are Time Units (Not Health)
- **Always 8 ducks per day** (not a depleting resource like V1)
- Player allocates split: X ducks to job, Y ducks to startup (X + Y = 8)
- Allocation determines progress rate AND caught hustling risk
- More ducks to startup = faster progress but higher detection chance (10-70%)

### ⚠️ V2 Core Formulas
**Job Progress:**
```gdscript
base_progress = ducks × 12%
bug_multiplier = 1 + (bugs × 0.01)
final_progress = base_progress / bug_multiplier
```

**Startup Progress:**
```gdscript
base_progress = ducks × 10%
users_gained = base_progress × 100 × (1 + features_completed)
```

**Caught Hustling Detection:**
```gdscript
base_chance = {0: 0%, 1-2: 10%, 3-5: 30%, 6-7: 50%, 8: 70%}
modifiers = boss_mood + coworker_relationships + recent_ship_quality
final_chance = base_chance + modifiers
# Roll each day you allocate >0 ducks to startup
# Strike 1: Warning, Strike 2: PIP, Strike 3: Fired
```

**Ship Bugs (Same as V1):**
```gdscript
bugs_added = (100 - progress) / 10
# 90%+: 0-1 bugs, 70-89%: 1-3 bugs, 50-69%: 3-5 bugs, <50%: 5-10 bugs
```

### ⚠️ Events Are RARE Special Moments
- NOT daily interruptions (that was removed after design analysis)
- Only 8-12 events per 30-40 day game (~25% of days)
- 10 event types: Caught hustling, production outage, coworker crisis, boss demands demo, performance review, etc.
- See [CORE-LOOP-SIMPLIFIED.md](CORE-LOOP-SIMPLIFIED.md) for full event list

### ⚠️ Single Current Task (Not Multiple)
- V1 had task panel with multiple tasks (archived)
- V2 has ONE current job task at a time
- When you ship, get assigned new task (closer to promotion/golden handcuffs)

---

## Writing Style

All game text should be:
- **Dry, deadpan humor** - Not silly or over-the-top
- **Specific tech references** - "blockchain todo app", not generic "do the thing"
- **Absurdist but grounded** - Corporate demands are ridiculous but recognizable
- **Dark without being mean** - Satirical, not cruel

### The "Ducks" Double Meaning

**IMPORTANT:** "Ducks" 🦆 = fucks to give (subtle wordplay, NEVER explicit)

- Always use "ducks" in text (never profanity)
- Always use 🦆 emoji in UI
- Let players discover the pun themselves
- Examples:
  - "Zero ducks given to PROJ-1337" ✅
  - "You didn't give many ducks about this" ✅
  - Achievement: "Zero Ducks Given" ✅
  - "Zero fucks given" ❌ (too explicit)

This makes the game:
- Shareable (no profanity in screenshots)
- Funnier (subtle > explicit)
- Corporate-safe emoji hiding subversive meaning

Examples from [data/tasks.json](data/tasks.json):
- "Make the Logo Bigger (Again)"
- "Fix the 'Sent with Wrong Font' Email"
- "CEO's 'Simple' Excel Macro"

---

## Key Files

### V2 Design Docs (PRIMARY - for user)
- **One-pager**: [ONE-PAGER.md](ONE-PAGER.md) - High-level V2 pitch
- **Game Design Document**: [GDD.md](GDD.md) - Full V2 design (system descriptions, flow)
- **Balance & Tuning**: [BALANCE.md](BALANCE.md) - All exact numbers, formulas, tunable values (implementation reference)
- **Core loop**: [CORE-LOOP-SIMPLIFIED.md](CORE-LOOP-SIMPLIFIED.md) - Final loop with rare events
- **V2 changes summary**: [V2-KEY-CHANGES.md](V2-KEY-CHANGES.md) - What changed from V1
- **TODO list**: [ideas/todo.md](ideas/todo.md)
- **Roadmap**: [ideas/roadmap.md](ideas/roadmap.md)

### V2 Design Analysis (for Claude)
- **Depth without complexity**: [reference/depth-without-complexity.md](reference/depth-without-complexity.md) - 10 techniques
- **Caught hustling mechanic**: [reference/caught-hustling-mechanic.md](reference/caught-hustling-mechanic.md) - Full detection system
- **Game redesign assessment**: [reference/game-redesign-assessment.md](reference/game-redesign-assessment.md) - V1 vs V2 viability
- **7-to-10 analysis**: [reference/7-to-10-analysis.md](reference/7-to-10-analysis.md) - Rating improvement path
- **Universal Paperclips analysis**: [reference/universal-paperclips-analysis.md](reference/universal-paperclips-analysis.md) - Lessons from 9/10 game
- **Boring UI as feature**: [reference/boring-ui-as-feature.md](reference/boring-ui-as-feature.md) - UI as satire

### V1 Implementation Docs (ARCHIVED)
- **V1 game design**: [archive/v1/game-design.md](archive/v1/game-design.md)
- **V1 implementation status**: [reference/implementation-status.md](reference/implementation-status.md) - V1 API (still useful for reuse)
- **Godot best practices**: [reference/godot-best-practices.md](reference/godot-best-practices.md)
- **Project structure**: [reference/project-structure.md](reference/project-structure.md)
- **Incremental workflow**: [reference/workflow-incremental-implementation.md](reference/workflow-incremental-implementation.md)

**Notes to Claude:**
- When creating reference docs for yourself (not tutorials for the user), save in `reference/`. Keep them concise.
- **When implementing features:** After completing implementation, update [ideas/TODO.md](ideas/TODO.md) and [reference/implementation-status.md](reference/implementation-status.md) to reflect what's been built. Update [CLAUDE.md](CLAUDE.md) only if there are new critical warnings or architectural changes.
