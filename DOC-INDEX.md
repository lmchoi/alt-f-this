# Doc Index

Last updated: 2026-02-28

---

## Active / Canonical

These are current, authoritative docs. Trust these.

| File | Updated | Description |
|------|---------|-------------|
| [GDD.md](GDD.md) | 2025-11-03 | Full V2 game design document — systems, events, tasks, UI, roadmap |
| [BALANCE.md](BALANCE.md) | 2025-11-03 | All exact numbers and formulas (split out from GDD for token efficiency) |
| [CORE-LOOP-SIMPLIFIED.md](CORE-LOOP-SIMPLIFIED.md) | 2025-11-03 | **Locked** core loop: allocate → rare event → results → ship → next day |
| [V2-KEY-CHANGES.md](V2-KEY-CHANGES.md) | 2025-11-02 | What changed from V1 to V2 and why (good for context) |
| [ONE-PAGER.md](ONE-PAGER.md) | 2025-11-02 | Pitch summary — useful for explaining the game quickly |
| [CLAUDE.md](CLAUDE.md) | 2025-11-04 | Instructions for Claude Code — architecture rules, design principles |

---

## Ideas / Design Thinking

Exploratory docs — useful but not binding.

| File | Updated | Description |
|------|---------|-------------|
| [ideas/boring-ui-as-feature.md](ideas/boring-ui-as-feature.md) | 2025-11-02 | Why Jira/Slack/git aesthetics are a design strength, not a compromise |
| [ideas/caught-hustling-mechanic.md](ideas/caught-hustling-mechanic.md) | 2025-11-02 | Deep dive on the 3-strike detection system and its tension design |
| [ideas/depth-without-complexity.md](ideas/depth-without-complexity.md) | 2025-11-02 | How to add strategic depth via hidden systems without overwhelming the player |
| [ideas/playtesting-resources.md](ideas/playtesting-resources.md) | 2025-10-31 | Where to find playtesters (communities, forums, Discord servers) |

---

## Research

Analysis of other games and design patterns.

| File | Updated | Description |
|------|---------|-------------|
| [ideas/research/7-to-10-analysis.md](ideas/research/7-to-10-analysis.md) | 2025-11-02 | Why V2 is ~7/10 and what's needed to reach 10/10 (juice, texture, surprise) |
| [ideas/research/revised-loop-analysis.md](ideas/research/revised-loop-analysis.md) | 2025-11-02 | Reassessment of V2 loop — structure is solid, "black box" simulation is the gap |
| [ideas/research/universal-paperclips-analysis.md](ideas/research/universal-paperclips-analysis.md) | 2025-11-02 | Teardown of Universal Paperclips — what makes its loop addictive |

---

## Developer Reference

Godot implementation notes and workflow guides.

| File | Updated | Description |
|------|---------|-------------|
| [reference/godot-best-practices.md](reference/godot-best-practices.md) | 2025-11-01 | Signal patterns, typing, scene structure — coding conventions for this project |
| [reference/workflow-incremental-implementation.md](reference/workflow-incremental-implementation.md) | 2025-11-01 | How to break features into small testable commits |
| [reference/game-redesign-assessment.md](reference/game-redesign-assessment.md) | 2025-11-02 | The V1→V2 rebuild decision: what to keep, modify, and build new |

---

## Stale / Outdated

These predate V2. Don't update them — check the archive if you need V1 context.

| File | Updated | Why stale |
|------|---------|-----------|
| [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md) | 2025-10-26 | V1 framing — wrong win condition ($5K), wrong actions (WORK/HUSTLE/SHIP) |
| [reference/game-formulas.md](reference/game-formulas.md) | 2025-10-22 | Replaced by BALANCE.md |
| [reference/implementation-status.md](reference/implementation-status.md) | 2025-10-26 | V1 implementation status, no longer accurate |
| [reference/project-structure.md](reference/project-structure.md) | 2025-10-22 | V1 code structure, partially outdated |
| [reference/task-category-mechanics.md](reference/task-category-mechanics.md) | 2025-10-28 | V1-specific mechanic detail |
| [reference/junior-level-design.md](reference/junior-level-design.md) | 2025-10-28 | V1 promotion system design decision |
| [reference/gdd.md](reference/gdd.md) | 2025-11-02 | Duplicate/old GDD — superseded by root GDD.md |

---

## Archive

V1 docs kept for reference. Don't touch.

- `archive/v1/` — V1 design and implementation plans
- `ideas/archive/v1/` — V1 roadmap, concepts, parking lot
- `ideas/archive/fun-assessment-framework.md` — Scoring framework for evaluating game fun
- `ideas/archive/fun-framework-validation.md` — V2 design scored against the framework
