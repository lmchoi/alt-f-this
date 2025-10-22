# Alt+F+This: Game Design Document

**"Papers Please meets Office Space with duck-based emotional damage"**

---

## Vision Statement

A darkly comedic management game where you're a tech worker trapped in corporate hell. Every work ticket is a moral dilemma. Every shortcut creates future pain. Every duck lost is a piece of your soul. Escape with $5K before bugs make work impossible.

---

## 5 Core Design Principles

### 1. **No Forgiveness, Only Forward**
*Every choice has permanent consequences. No undo, no reset, no cleanup.*

- Bugs NEVER decrease (technical debt is forever)
- Ducks rarely regenerate (burnout accumulates)
- Shipped work can't be unshipped (production outages linger)
- Past choices echo into future events

### 2. **Simplicity Through Subtraction**
*Every mechanic must do 2+ jobs. Remove anything that doesn't compound.*

- Max 3 work actions (WORK/HUSTLE/SHIP IT)
- Every action affects multiple resources (no single-purpose buttons)
- Tutorial < 30 seconds (learn by playing)

### 3. **The Death Spiral Is The Game**
*Losing slowly is more engaging than winning easily. Difficulty should accelerate.*

- Bugs accumulate faster than you can work
- Tasks get harder while you get slower
- No equilibrium state (always escalating)

### 4. **Emotional Bookkeeping Over Spreadsheets**
*Resources represent feelings, not numbers. Make math visceral.*

- **Ducks** = patience/sanity/fucks-to-give (not "health points")
- **Bugs** = guilt/technical debt/sins (not "difficulty modifier")
- **Money** = escape velocity/freedom countdown (not "score")
- **Day** = time running out/aging/exhaustion (not "level number")
- **Escape Progress** = your side project/future/hope (not "XP bar")

### 5. **Shared Suffering Creates Community**
*The game should generate stories players need to tell others.*

- Specific, memorable disasters (not generic failures)
- Moral dilemmas with no right answer
- Outcomes vary enough that players compare notes
- Built-in "can you believe this happened" moments

---

## Core Concept

**Goal:** Save enough money to escape before bugs make work impossible

**Core Loop:** Daily choice between:
- **WORK** - Make progress on corporate tasks
- **HUSTLE** - Build your escape (side project/network)
- **SHIP IT** - Complete task now, add bugs based on quality

**Core Tension:** "Can I build my escape before they fire me for neglecting corporate work?"

---

## Key Systems Overview

### Resources
- **Money** - Escape fund ($5K goal, or less with escape progress)
- **Ducks** - Sanity/patience (start with 3, 0 = burnout)
- **Bugs** - Technical debt (slows all work, 100+ = death spiral)
- **Escape Progress** - Side project viability (0-100%)
- **Day** - Time pressure (payday every 5 days)

### Three Actions
1. **WORK** - Progress on task, scaled by complexity + bugs, paid on payday
2. **HUSTLE** - Build escape progress, +duck (or -duck if overdue), risk firing
3. **SHIP IT** - Complete task at current quality, add bugs, choose what's next

### Task Categories (Risk Profiles)
- **Optics** - Political risk, CEO might love mediocrity
- **Tech Debt** - Long-term consequences, compounds badly if rushed
- **Critical** - Immediate outage risk, reputation stakes

### Victory Conditions
Three paths to freedom:
1. **$5,000** - Pure corporate grind, no escape progress
2. **$3,000 + 75% escape** - Balanced approach, side project viable
3. **$2,000 + 100% escape** - Full hustler, startup self-sustaining

### Game Over Conditions
- **0 ducks** - Burnout
- **100+ bugs** - Death spiral (work becomes impossible)
- **3 days overdue** - Fired for neglecting work

---

## Balance Targets

### Work Speed
- **0 bugs:** Complexity 5 task = ~5 days of work
- **40 bugs:** Same task = ~7 days (40% slower)
- **80 bugs:** Same task = ~9 days (80% slower)

### Escape Timeline
- Target: 30-50 days depending on strategy
- Early game: Ship 80-90% quality
- Late game: Ship 40-60% quality (desperation)

### Resource Scarcity
- Ducks: Start with 3, rarely gain back
- Salary: Fixed per task (~$300-500), complexity = pure suffering
- Payday: Every 5 days (creates strategic cycles)

### Death Spiral Curve
- Week 1-2: Simple tasks, long deadlines, learning
- Week 3-4: Medium complexity, bugs mounting, temptation grows
- Week 5-6: High complexity, tight deadlines, must ship early to survive
- Week 7+: Desperation mode, racing to escape

---

## Writing Style Guide

All game text should be:

### Tone
- **Dry, deadpan humor** - Not silly or over-the-top
- **Specific tech references** - "blockchain todo app", not generic "do the thing"
- **Absurdist but grounded** - Corporate demands are ridiculous but recognizable
- **Dark without being mean** - Satirical, not cruel

### Examples (Good)
- "Make the Logo Bigger (Again)"
- "CEO's 'Simple' Excel Macro"
- "Add Blockchain to Login Button"
- "Your code from last week is 'causing issues'"

### Examples (Avoid)
- ❌ "Your boss is a big meanie!" (too silly)
- ❌ "You're worthless trash" (too mean)
- ❌ "Do the work project" (too generic)

### Quality Messages (SHIP IT)
- **90%+:** "Actually good work. You feel competent."
- **70-89%:** "It works. Probably."
- **50-69%:** "Barely functional MVP."
- **30-49%:** "AI-generated slop with your name on it."
- **20-29%:** "You shipped TODO comments as features."

---

## Victory Endings (Dynamic Titles)

Based on player stats, show different ending titles:

- **THE PERFECTIONIST** - <20 bugs, >30 days: "You escaped with your soul intact."
- **THE PRAGMATIST** - 20-50 bugs, avg 60-80% quality: "You made the deals you had to make."
- **THE BURNT-OUT HUSTLER** - 0 ducks remaining: "I escaped, but at what cost?"
- **THE SPEED RUNNER** - <25 days: "You got out before they could break you."
- **THE TECHNICAL DEBT MONSTER** - 50-90 bugs: "You left a trail of destruction."
- **THE AI PROMPT ENGINEER** - Avg <40% quality: "You shipped TODO comments as features."
- **THE SURVIVOR** - 3+ production outages: "You crawled through hell and came out broken."

---

## What Makes This Different

### vs. Papers Please
- Work actions (not just inspection)
- Escape progress (dual objectives)
- Death spiral acceleration (not just difficulty)

### vs. Office Space
- Mechanical depth (resource management)
- Permanent consequences (no reset)
- Multiple escape paths (player agency)

### vs. Typical Management Sims
- Anti-growth (you get slower, not faster)
- Emotional resources (ducks, not HP)
- Satire with purpose (commentary on tech work culture)

---

## Future: Act 2 (Post-Escape)

If escape successful, unlock startup mode:
- You're now the founder
- Hire employees (former coworkers appear)
- Face consequences of Act 1 bugs/decisions
- Choice: Exploit workers or build ethically?
- Ends in: Unicorn exit, acquihire, bankruptcy, or revolt

**The Hook:** People you wronged in Act 1 show up in Act 2

---

## Success Metrics

**You'll know it's working when:**
- Players agonize over SHIP IT decisions daily
- "Just one more day" addiction kicks in
- Players scream at production outage popups
- They laugh at events then feel guilty
- They replay to optimize "cleanest escape"
- Streamers can create content (drama + comedy)
- Players share their bug counts / lowest quality ships

**Target feeling:**
- Papers Please's inspection tension
- Office Space's "did he just say that?" moments
- This War of Mine's moral weight
- FTL's "one more jump" desperation

---

*For implementation details, see [ideas/game-plan.md](ideas/game-plan.md) and [ideas/plans/IMPLEMENTATION_STATUS.md](ideas/plans/IMPLEMENTATION_STATUS.md)*
