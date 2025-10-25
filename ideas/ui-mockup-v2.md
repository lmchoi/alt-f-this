# UI Mockup v2 - JIRA Hell Edition

## Design Goals
- Task card is primary focus (80% of visual weight)
- Boring corporate for job/task (JIRA-adjacent)
- Escape plan gets visual personality
- Clean hierarchy, room for future task queue
- Modern but soulless

## Layout Structure

```
┌─────────────────────────────────────────────────────────────┐
│ 💰 $500    🦆 3    🐛 98           📅 Day 8    Payday: 3 days│  ← Stats bar (condensed, corporate grey)
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  JUNIOR DEVELOPER                          Salary: $500/task │  ← Job context (small, boring)
│                                                               │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ ALT-1847                                   🔴 CRITICAL│   │  ← Task ID (JIRA-style)
│  │ Fix the 'Sent with Wrong Font' Email                 │   │
│  ├──────────────────────────────────────────────────────┤   │
│  │                                                        │   │  ← BIG task card
│  │ Marketing sent 50K emails in Comic Sans. 'Undo'      │   │     (main focus)
│  │ the send before customers notice.                     │   │
│  │                                                        │   │
│  │ Complexity: ⚙️⚙️⚙️                                     │   │
│  │                                                        │   │
│  │ ⚡ 1 day overdue                                       │   │
│  │                                                        │   │
│  │ Progress: 32%                                         │   │
│  │ ▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░                        │   │
│  │                                                        │   │
│  │ 🐛 Work slowed by bugs: 2.0x                          │   │
│  │                                                        │   │
│  │ ⚠️  VERY RISKY (many bugs!)                           │   │
│  └──────────────────────────────────────────────────────┘   │
│                                                               │
│                                                               │
│  ┌────────────────────────────────┐                         │
│  │ 🚀 ESCAPE PLAN: Project Banana │                         │  ← Escape (different style)
│  │ Progress: 0%                    │                         │     Gets personality
│  └────────────────────────────────┘                         │
│                                                               │
│ ┌─────────┐  ┌──────────┐              ┌─────────────────┐ │
│ │  Work   │  │  HUSTLE  │              │  🚨 SHIP IT     │ │  ← Actions: spread out,
│ │  £100   │  │  (Side)  │              │  (Complete Now) │ │     SHIP IT emphasized
│ └─────────┘  └──────────┘              └─────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

## Color Palette Proposal

### Corporate Task/Job Area
- Background: `#1e1e1e` (dark grey, VS Code dark)
- Task card: `#252526` (slightly lighter panel)
- Text: `#d4d4d4` (muted white)
- Borders: `#3e3e42` (subtle)
- CRITICAL badge: `#f48771` (muted red)
- Progress bar: `#4e94ce` (corporate blue)

### Escape Plan (Personality)
- Background: `#2d2a1e` (warm dark, different from corporate grey)
- Border: `#e2c08d` (gold accent)
- Text: Warmer whites

### Action Buttons
- Work: Grey/default `#3e3e42`
- HUSTLE: Blue accent `#4e94ce`
- SHIP IT: Red warning `#d16969` (bigger, dangerous)

### Semantic Colors
- Overdue: `#f48771` (orange-red)
- Bugs: `#ce9178` (orange)
- Ducks: `#dcdcaa` (yellow)
- Money: `#4ec9b0` (teal/green)

## Key Changes from Current

1. **Task gets JIRA ID** (ALT-1847) - instantly recognizable corporate hell
2. **Job info becomes context bar** - small, boring, grey
3. **Escape plan visually distinct** - different bg color, gold border
4. **Stats condensed to single bar** - money/ducks/bugs/day all top-right
5. **Action buttons spread out** - SHIP IT isolated on right (dramatic)
6. **Lots of breathing room** - bottom space for future task queue/notifications

## Future Additions (from your plans)

### Escape Plan Expanded
```
┌────────────────────────────────┐
│ 🚀 ESCAPE PLAN: Project Banana │
│ Progress: 45%                   │
│ Users: 127  Revenue: $340/mo   │  ← Future metrics
└────────────────────────────────┘
```

### Task Queue (bottom right)
```
                    ┌─ Waiting Tasks ──┐
                    │ ALT-1849 (3 days) │
                    │ ALT-1850 (5 days) │
                    └───────────────────┘
```

## Inspiration
- JIRA's boring task cards (instant recognition)
- VS Code's dark theme colors (familiar to devs)
- Linear's clean hierarchy (modern)
- Slack's muted palette (not garish)
