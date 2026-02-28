# Doc Index

Last updated: 2026-02-28

Docs fall into three types:
- **Reference** — stable, doesn't change much (Godot patterns, workflow rules)
- **Ideas** — brainfarts and exploration, not reviewed or binding
- **Snapshots** — point-in-time captures of decisions, status, or comparisons

The canonical design lives in the root-level files (GDD.md, BALANCE.md, etc).

---

## Canonical Design (root)

| File | Updated | Description |
|------|---------|-------------|
| [GDD.md](GDD.md) | 2025-11-03 | Full V2 game design — systems, events, tasks, UI, roadmap |
| [BALANCE.md](BALANCE.md) | 2025-11-03 | All exact numbers and formulas |
| [CORE-LOOP-SIMPLIFIED.md](CORE-LOOP-SIMPLIFIED.md) | 2025-11-03 | **Locked** core loop with all 10 special event types detailed |
| [V2-KEY-CHANGES.md](V2-KEY-CHANGES.md) | 2025-11-02 | What changed from V1 → V2 and why |
| [ONE-PAGER.md](ONE-PAGER.md) | 2025-11-02 | Pitch summary |
| [CLAUDE.md](CLAUDE.md) | 2025-11-04 | Instructions for Claude Code |

---

## Reference

Stable. Update only if the underlying approach changes.

| File | Updated | Description |
|------|---------|-------------|
| [reference/godot-best-practices.md](reference/godot-best-practices.md) | 2025-11-01 | Signal patterns, typing, scene structure |
| [reference/workflow-incremental-implementation.md](reference/workflow-incremental-implementation.md) | 2025-11-01 | How to break features into small testable commits |

---

## Ideas

Not reviewed or binding — brainfarts and design exploration.

| File | Updated | Description |
|------|---------|-------------|
| [ideas/boring-ui-as-feature.md](ideas/boring-ui-as-feature.md) | 2025-11-02 | Why Jira/Slack/git aesthetics are a design strength |
| [ideas/caught-hustling-mechanic.md](ideas/caught-hustling-mechanic.md) | 2025-11-02 | Deep dive on the 3-strike detection system |
| [ideas/depth-without-complexity.md](ideas/depth-without-complexity.md) | 2025-11-02 | Adding strategic depth via hidden systems without complexity |
| [ideas/playtesting-resources.md](ideas/playtesting-resources.md) | 2025-10-31 | Where to find playtesters |
| [ideas/research/7-to-10-analysis.md](ideas/research/7-to-10-analysis.md) | 2025-11-02 | Why V2 is ~7/10 and what's needed to reach 10/10 |
| [ideas/research/revised-loop-analysis.md](ideas/research/revised-loop-analysis.md) | 2025-11-02 | Loop structure is solid, "black box" simulation is the gap |
| [ideas/research/universal-paperclips-analysis.md](ideas/research/universal-paperclips-analysis.md) | 2025-11-02 | Teardown of Universal Paperclips' addictive loop |

---

## Snapshots

Point-in-time captures. Don't update — create a new one if things change.

| File | Captured | Description |
|------|---------|-------------|
| [snapshots/version-comparison.md](snapshots/version-comparison.md) | 2026-02-28 | V1 vs Timed Mode vs V2 — what each got right/wrong |
| [reference/game-redesign-assessment.md](reference/game-redesign-assessment.md) | 2025-11-02 | The V1→V2 rebuild decision: what to keep, modify, build new |

---

## Archive

V1 docs kept for reference. Don't touch.

| Location | Description |
|----------|-------------|
| `archive/v1/` | V1 design docs and implementation plans |
| `ideas/archive/v1/` | V1 roadmap, concepts, parking lot |
| `ideas/archive/fun-assessment-framework.md` | Scoring framework for evaluating game fun |
| `ideas/archive/fun-framework-validation.md` | V2 design scored against the framework |

