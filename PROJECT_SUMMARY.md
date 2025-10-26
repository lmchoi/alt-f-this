# Alt+F+This - Project Summary

## Quick Overview

**Alt+F+This** is a darkly comedic inspection/management game built in Godot 4.5 where you play as a tech worker trapped in corporate hell. Think "Papers Please meets Office Space with duck-based emotional damage."

## Core Gameplay

- **Goal**: Earn $5K to escape (or build a side project) before bugs make work impossible
- **Daily Choice**: Pick one of 3 actions - WORK, HUSTLE, or SHIP IT
- **The Catch**: Bugs NEVER decrease - you're in a death spiral and must escape before it's too late

## Key Mechanics

### The Three Actions
1. **WORK** - Make progress on current task (affected by bugs)
2. **HUSTLE** - Work on side project to build alternative escape route
3. **SHIP IT** - Ship incomplete work (available at 20%+, creates bugs based on incompleteness)

### Core Systems
- **Bugs Are Permanent** - No DEBUG action, bugs only increase, making work progressively slower
- **Payment Cycles** - Get paid every 5 days (payday), creates strategic timing decisions
- **Death Spiral** - Bugs slow work → can't meet deadlines → ship early → more bugs → repeat (intentional!)
- **Ducks to Give** - Emotional resource affected by shipping quality work

## Technical Architecture

### Signal-Driven Design
- **GameManager** (autoload) - Central game state, all properties emit signals
- **TaskManager** (autoload) - Loads tasks from JSON, handles difficulty scaling
- UI components connect to signals, never update directly

### Font Size Hierarchy
- 48px: End game title
- 32px: Top bar stats
- 28px: Task/dialog titles
- 24px: Progress percentage, deadline
- 22px: Task description, action buttons
- 20px: Base labels, badges (theme default)

## Writing Style

All game text uses:
- **Dry, deadpan humor** - Not silly or over-the-top
- **Specific tech references** - "blockchain todo app", "make the logo bigger"
- **Absurdist but grounded** - Ridiculous but recognizable corporate demands
- **Dark without being mean** - Satirical, not cruel

Examples: "Make the Logo Bigger (Again)", "CEO's 'Simple' Excel Macro"

## Important Design Rules

1. **Bugs NEVER decrease** - No DEBUG action, permanent consequences
2. **3 actions only** - WORK, HUSTLE, SHIP IT (daily choice is the core loop)
3. **SHIP IT is the game** - Daily temptation to ship incomplete work
4. **Payment on payday** - Every 5 days, creates strategic cycles

## Key Files

### For Players/Designers
- Game design philosophy: [ideas/game-design.md](ideas/game-design.md)
- TODO list: [ideas/todo.md](ideas/todo.md)
- Roadmap: [ideas/roadmap.md](ideas/roadmap.md)

### For Developers/AI
- Implementation status: [reference/implementation-status.md](reference/implementation-status.md)
- Godot best practices: [reference/godot-best-practices.md](reference/godot-best-practices.md)
- Project structure: [reference/project-structure.md](reference/project-structure.md)
- Incremental workflow: [reference/workflow-incremental-implementation.md](reference/workflow-incremental-implementation.md)

## Running the Game

Open project in Godot 4.5 and press F5. Main scene: [scenes/game_ui.tscn](scenes/game_ui.tscn)

## Development Workflow

**Incremental Implementation** - Break features into small commits (20-100 lines, 1-3 files):
1. Plan 3-6 small commits
2. Each commit should be immediately testable
3. Implement → Test → Commit → Next

---

*"Papers Please meets Office Space with duck-based emotional damage"*
