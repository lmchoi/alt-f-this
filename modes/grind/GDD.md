# The Daily Grind — Game Design Document

**Mode:** grind (V1)
**Tagline:** "Papers Please meets Office Space with duck-based emotional damage"

---

## Vision

A darkly comedic management game where you're a tech worker trapped in corporate hell. Every work ticket is a moral dilemma. Every shortcut creates future pain. Escape with $5K before bugs make work impossible.

---

## Core Design Principles

### 1. No Forgiveness, Only Forward
Every choice has permanent consequences. No undo, no reset, no cleanup.

- Bugs NEVER decrease (technical debt is forever)
- Ducks rarely regenerate (burnout accumulates)
- Shipped work can't be unshipped (production outages linger)

### 2. Simplicity Through Subtraction
Max 3 actions. Every action affects multiple resources.

- Max 3 work actions: WORK / HUSTLE / SHIP IT
- Tutorial < 30 seconds (learn by playing)

### 3. The Death Spiral Is The Game
Difficulty should accelerate. No equilibrium state.

- Bugs accumulate faster than you can work
- Tasks get harder while you get slower

### 4. Emotional Bookkeeping
Resources represent feelings, not numbers.

- **Ducks** = patience/sanity/fucks-to-give (not "health points")
- **Bugs** = guilt/technical debt (not "difficulty modifier")
- **Money** = escape velocity/freedom countdown (not "score")

---

## Core Loop

**Goal:** Save enough money to escape before bugs make work impossible.

**Each day, pick one action:**
- **WORK** — Make progress on the current corporate task
- **HUSTLE** — Build your escape (side project/network)
- **SHIP IT** — Complete task now, add bugs based on quality

**Core Tension:** "Can I build my escape before they fire me for neglecting corporate work?"

---

## Resources

| Resource | Start | Game Over |
|----------|-------|-----------|
| Money | $0 | — |
| Ducks | 3 | 0 = burnout |
| Bugs | 0 | 100+ = death spiral |
| Escape Progress | 0% | — |
| Day | 1 | — |

---

## Three Actions

**WORK**
- Progress on task, scaled by complexity + bugs
- Paid on payday (every 5 days)

**HUSTLE**
- Build escape progress (+5%/day)
- Earn $200
- Risk firing if overdue

**SHIP IT**
- Complete task at current quality
- Adds bugs: `(100 - progress) / 10`
- Tech Debt category: bugs × 3
- Triggers new task assignment

---

## Task Categories

**Optics** — Political risk
- Short deadlines (1 day overdue = PIP warning)
- CEO might love or hate the result

**Tech Debt** — Long-term consequences
- Bug multiplier 3× when shipped incomplete
- Long deadlines

**Critical** — Immediate stakes
- Shipped below 80% → guaranteed production outage next day
- Customer-facing consequences

---

## Win Conditions

Three paths to escape:

1. **$5,000** — Pure corporate grind, no escape progress needed
2. **$3,000 + 75% escape** — Balanced approach
3. **$2,000 + 100% escape** — Full hustler, startup self-sustaining

---

## Loss Conditions

- **Burnout** — 0 ducks
- **Death Spiral** — 100+ bugs (work becomes impossible)
- **Fired (deadline)** — Task overdue 3+ days and already on PIP

---

## Progression

**Week 1-2:** Simple tasks, long deadlines, learning the loop
**Week 3-4:** Medium complexity, bugs mounting, temptation grows
**Week 5-6:** High complexity, tight deadlines, must ship early to survive
**Week 7+:** Desperation mode, racing to escape

---

## Caught Hustling

Every time you choose HUSTLE, there's a chance your boss notices. Detection chance increases if your task is overdue, decreases if you've been shipping quality work. See BALANCE.md for exact values.

### How You Get Caught

**Boss Walks By**
```
You quickly Alt+Tab from your startup code to Jira — not fast enough.
Boss: "Was that... a login page? For what app?"
```

**Screen Share Accident**
```
During standup you share your screen. VSCode has "my-startup-app" in the title bar.
PM: "Interesting project name. Is that for PROJ-1337?"
```

**IT Flags Your Git Activity**
```
IT: "We noticed some unusual git commits on your work laptop during work hours."
```

**Coworker Snitches**
```
Bob saw you working on something that wasn't work. He mentioned it in his 1:1.
Boss messages you: "We need to talk."
```

### 3-Strike System

**Strike 1 — Warning**
Boss pulls you aside. Detection chance increases for the next few days. No other penalty — but they're watching.

**Strike 2 — PIP**
Performance Improvement Plan. Detection chance increases for 30 days. Must ship next 3 tasks at 70%+ or instant fired. PIP counter visible on screen.

**Strike 3 — Fired**
"Security will escort you out." Game over: *Caught Red-Handed* ending.

### The Core Question
You're not asking *if* you'll get caught. You're asking *can you finish before Strike 3?*

---

## Production Outages

Triggered when poorly shipped tasks accumulate and bugs are high.

- Outage chance = `bugs × 0.5% × poorly_shipped_tasks.count`
- Critical tasks shipped <80%: guaranteed next-day outage
- On outage: choose responsibility / scapegoat / blame system
- 2 PIP warnings = fired; 3 blame strikes = company collapse

---

## Victory Endings

Based on player stats:

- **THE PERFECTIONIST** — <20 bugs, >30 days: "You escaped with your soul intact."
- **THE PRAGMATIST** — 20-50 bugs, avg 60-80% quality: "You made the deals you had to make."
- **THE BURNT-OUT HUSTLER** — 0 ducks remaining: "I escaped, but at what cost?"
- **THE SPEED RUNNER** — <25 days: "You got out before they could break you."
- **THE TECHNICAL DEBT MONSTER** — 50-90 bugs: "You left a trail of destruction."
- **THE AI PROMPT ENGINEER** — Avg <40% quality: "You shipped TODO comments as features."
- **THE SURVIVOR** — 3+ production outages: "You crawled through hell and came out broken."

---

## Writing Style

- **Dry, deadpan humor** — not silly or over-the-top
- **Specific tech references** — "blockchain todo app", not "do the thing"
- **Absurdist but grounded** — corporate demands are ridiculous but recognizable
- **Dark without being mean** — satirical, not cruel

**Ducks** = fucks to give (subtle wordplay, NEVER explicit). Always use "ducks" + 🦆 in UI.

---

*Balance values: [BALANCE.md](BALANCE.md)*
*Archive: [archive/v1/game-design.md](../../archive/v1/game-design.md)*
