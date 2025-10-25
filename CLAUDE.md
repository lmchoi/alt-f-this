# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

---

## Project Overview

**Alt+F+This** - *"Papers Please meets Office Space with duck-based emotional damage"*

A darkly comedic inspection/management game built in Godot 4.5 where you're a tech worker trapped in corporate hell. Inspect work tickets, make impossible decisions, and escape with $5K before you run out of ducks to give.

---

## Game Design Vision

**See [ideas/game-design.md](ideas/game-design.md) for complete design philosophy and principles.**

### Core Concept
Papers Please meets Office Space with duck-based emotional damage. Build $5K (or escape via side project) before bugs make work impossible.

### Key Design Rules
1. **Bugs NEVER decrease** - No DEBUG action, permanent consequences (death spiral is the game)
2. **3 actions only** - WORK, HUSTLE, SHIP IT (daily choice is the core loop)
3. **SHIP IT is the game** - Daily temptation to ship incomplete work, creates bugs
4. **Payment on payday** - Every 5 days, creates strategic cycles (finish early = time to hustle)

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

**Autoloaded Singletons:**
- **GameManager** ([autoloads/game_manager.gd](autoloads/game_manager.gd)) - Central game state, all properties emit signals
- **TaskManager** ([autoloads/task_manager.gd](autoloads/task_manager.gd)) - Loads tasks from JSON, handles difficulty scaling

See [reference/implementation-status.md](reference/implementation-status.md) for detailed API documentation.

---

## Critical Implementation Notes

### ⚠️ Bugs Are PERMANENT
**NEVER implement bug reduction.** No DEBUG action. Bugs never decrease. This is the core tension.

### ✅ Task Complexity (IMPLEMENTED)
Task complexity properly affects work speed:
```gdscript
var bug_multiplier = get_bug_multiplier()  # 1.0 + (bugs * 0.01)
var work = 100.0 / (current_task.complexity * bug_multiplier)
current_task.do_work(work)
```
Result: 1 complexity = 1 day to complete (at 0 bugs)

### ⚠️ SHIP IT Is The Core Mechanic
Daily decision: "Is this good enough to ship?"
- Available at 20%+ progress
- Bugs added: `(100 - progress) / 10`
- Duck change based on quality (see game plan for details)
- Payment on payday (every 5 days) - creates strategic timing decisions

### ⚠️ Death Spiral Is Intentional
Bugs → slower work → can't meet deadlines → ship early → more bugs → repeat. This is **intentional game design**, not a bug to fix. The game is a race: earn $5K before bugs make it impossible.

---

## Writing Style

All game text should be:
- **Dry, deadpan humor** - Not silly or over-the-top
- **Specific tech references** - "blockchain todo app", not generic "do the thing"
- **Absurdist but grounded** - Corporate demands are ridiculous but recognizable
- **Dark without being mean** - Satirical, not cruel

Examples from [data/tasks.json](data/tasks.json):
- "Make the Logo Bigger (Again)"
- "Fix the 'Sent with Wrong Font' Email"
- "CEO's 'Simple' Excel Macro"

---

## Key Files

### Design Docs (for user)
- **Game design philosophy**: [ideas/game-design.md](ideas/game-design.md)
- **TODO list**: [ideas/todo.md](ideas/todo.md)
- **Roadmap & future ideas**: [ideas/roadmap.md](ideas/roadmap.md)

### AI Reference (for Claude)
- **Implementation status**: [reference/implementation-status.md](reference/implementation-status.md) - What's built, what's next, formulas
- **Godot best practices**: [reference/godot-best-practices.md](reference/godot-best-practices.md)
- **Project structure**: [reference/project-structure.md](reference/project-structure.md)
- **Incremental workflow**: [reference/workflow-incremental-implementation.md](reference/workflow-incremental-implementation.md)

**Notes to Claude:**
- When creating reference docs for yourself (not tutorials for the user), save in `reference/`. Keep them concise.
- **When implementing features:** After completing implementation, update [ideas/TODO.md](ideas/TODO.md) and [reference/implementation-status.md](reference/implementation-status.md) to reflect what's been built. Update [CLAUDE.md](CLAUDE.md) only if there are new critical warnings or architectural changes.
