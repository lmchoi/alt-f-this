# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

---

## Project Overview

**Code Monkey** (working title: "Alt+F+This") - *"Office Space meets Universal Paperclips with duck-based resource allocation"*

A darkly comedic time-allocation strategy game built in Godot 4.5 where you're a tech worker trapped in corporate hell. Allocate your ducks 🦆 between job tasks and your secret startup. Ship quality work or cut corners? Risk getting caught hustling? Escape with $3K or revenue before you get fired.

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

**Signal-Driven Design:**
- GameManager holds all state with property setters that emit signals
- UI components connect to signals in `_ready()`
- Never update UI directly - always emit signals from GameManager
- **V2 Note:** Architecture remains the same, core loop logic will be rebuilt

---

## Critical Implementation Notes (V2)

### ⚠️ Ducks Are Time Units (Not Health)
- **Always 8 ducks per day** (not a depleting resource like V1)
- Player allocates split: X ducks to job, Y ducks to startup (X + Y = 8)
- Allocation determines progress rate AND caught hustling risk
- More ducks to startup = faster progress but higher detection chance (10-70%)

### ⚠️ Events Are RARE Special Moments
- NOT daily interruptions (that was removed after design analysis)
- Only 8-12 events per 30-40 day game (~25% of days)
- 10 event types: Caught hustling, production outage, coworker crisis, boss demands demo, performance review, etc.

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

---

**Notes to Claude:**
- When creating reference docs for yourself (not tutorials for the user), save in `reference/`. Keep them concise.

