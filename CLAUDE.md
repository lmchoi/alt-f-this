# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

---

## Project Overview

**Code Monkey** (working title: "Alt+F+This") - *"Office Space meets Universal Paperclips with duck-based resource allocation"*

A darkly comedic time-allocation strategy game built in Godot 4.5 where you're a tech worker trapped in corporate hell. Allocate your ducks 🦆 between job tasks and your secret startup. Ship quality work or cut corners? Risk getting caught hustling? Escape with $3K or revenue before you get fired.

---

## Game Design Vision

**Active build target: [modes/grind/GDD.md](modes/grind/GDD.md). All modes in [modes/](modes/).**

### Core Concept (Grind)
A darkly comedic game. Each day pick a daily action (WORK / HUSTLE) and decide whether to ship the current task (SHIP IT — on the task card). Escape with your startup before bugs make work impossible, you get caught hustling, or golden handcuffs trap you forever. 10-15 min per run, replayable via distinct endings.

### Core Loop
1. **Pick action** — WORK (safe), HUSTLE (risky), or SHIP IT (permanent)
2. **Consequences** — bugs added, ducks lost, money earned
3. **End of day** — payday, overdue check, detection roll if hustled
4. **Next day** — same situation, slightly worse

### Key Design Principles
1. **3 actions, all interconnected** — every action trades across bugs / ducks / money
2. **No forgiveness, only forward** — bugs never decrease, ducks never recover, every choice compounds
3. **Bugs only affect WORK** — hustling feels free, but the job rots while you do it
4. **Ducks lost through moral compromise only** — ship badly, blame coworkers
5. **Golden handcuffs = the time limit** — play too safe and you're promoted out of the game
6. **End-of-run recap** — Frostpunk-style, every choice surfaced, drives replay

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
- Core loop logic lives in GameManager — rebuild for grind from scratch, don't reuse V2 logic

---

## Critical Implementation Rules

### ⚠️ Balance Values Live in JSON, Not Code
If a number affects feel or balance, it belongs in a data file — not hardcoded in GDScript.

**In `data/balance.json` (single source of truth):**
- Task completion rates, complexity scaling
- Duck loss thresholds (e.g. ship quality threshold)
- Promotion trigger (tasks to golden handcuffs)
- Detection chance, strike consequences
- Payday interval, salary amounts
- Hustle income per day

**In code:** logic only — never magic numbers.

This means balance can be tuned without opening Godot or touching any `.gd` files.

**Design reference:** `modes/grind/BALANCE.md` — when you change a value there, mirror it in `data/balance.json`.

### ⚠️ Bugs Only Affect WORK
Bugs slow down job task progress. They do not affect HUSTLE or SHIP IT speed. This is intentional — hustling feels free, shipping is always instant.

### ⚠️ Ducks Are Lost Through Moral Compromise Only
- Ship below quality threshold → lose a duck
- Blame a coworker → lose a duck
- Never earned back
- 0 ducks = burnout ending

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
- Docs are categorised into Modes / Reference / Ideas / Snapshots — see [DOC-INDEX.md](DOC-INDEX.md)
- Each game mode has its own folder under `modes/` with GDD.md and BALANCE.md

### Before Implementing a Feature — Check These First

1. **Data files** (`data/*.json`) — may already have fields/structure ready but unused
2. **GameManager** (`autoloads/game_manager.gd`) — check existing variables, signals, constants before assuming something needs building
3. **TaskManager** (`autoloads/task_manager.gd`) — check what's already parsed from JSON

### What to Ask vs What to Look Up

**Don't ask — just check the code:**
- "Does X exist?" → grep/read the files
- "How does Y work?" → read the implementation

**Do ask:**
- Design direction ("should outages be instant or delayed?")
- Balance tuning ("is 10x too harsh?")
- Architecture decisions ("centralised or distributed?")

### Decide Now vs Playtest Later

> **Decide now** if changing it requires touching code or architecture.
> **Playtest** if changing it only requires changing a number in a config file.

Use this to push back on design decisions that don't need to be made yet. If the answer is "just put it in balance.json and tune later", say so.

### Constraints vs Consequences

Two distinct event types — never mix them up:

- **Constraints** — things that happen *to* the player at the **start of day**. Limit options for that day. (e.g. workmate needs help → productivity hit)
- **Consequences** — things that happen *because of* the player's action, **post-action**. Punish choices. (e.g. chose HUSTLE → detection roll)

Both phases exist in the day loop architecture. Only consequences fire in V1. Constraints are parked for later — do not retrofit them into post-action logic.

### Idea Tags

Tag ideas in discussion and docs to clarify what kind of decision they are:

- `[ARCHITECTURE]` — requires code/system design decision now
- `[DESIGN]` — core mechanic or player experience decision, decide before building
- `[BALANCE]` — just a number, goes in balance.json, decide via playtesting
- `[JUICE]` — feel, animation, sound — build plain first, add later

