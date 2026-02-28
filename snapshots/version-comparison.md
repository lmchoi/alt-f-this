# Version Comparison

**Captured:** 2026-02-28

Three distinct designs have existed. V1 shipped (playable), Timed Mode was a V1 branch experiment, V2 is the locked current design (not yet built).

---

## At a Glance

| | V1 | Timed Mode | V2 |
|---|---|---|---|
| **Status** | Built, playable | Branch, partial | Design locked, not built |
| **Core mechanic** | Pick one action/day | Pick one action/day + real-time timer | Allocate 8 ducks/day |
| **Job vs startup** | Either/or (HUSTLE = startup) | Either/or | Parallel (both advance same day) |
| **Ducks** | Sanity resource (depletable, 0 = game over) | Same as V1 | Fixed time units (always 8, not a resource) |
| **Interruptions** | Daily, handle/ignore | Fire on real-time timer every ~10s | Rare (~25% of days, 8-12 per run) |
| **Win condition** | $5K saved | $5K saved | App complete + $3K OR $50/day revenue |
| **Caught hustling** | Not a system | Not a system | 3-strike system (10-70% detection %) |
| **Salary** | Per-task payment on payday | Per-task payment on payday | Fixed weekly salary |
| **Game length** | 30-50 days | ~same | 30-40 days |
| **Pace per day** | One click decision | 60s real-time scramble | 30-45s allocation + results |

---

## What Each Got Right

**V1** — The ship decision. Shipping at 67% vs waiting and risking the deadline was genuinely tense. Simple enough to understand immediately.

**Timed Mode** — Created real panic and mistake-making in a way the other versions don't. Interruptions firing while you're mid-thought felt authentic to actual office life.

**V2** — Parallel job/startup progress removes the V1 frustration of losing ground on one while working the other. Rare events stay memorable. Caught hustling gives the startup allocation stakes it was missing.

---

## What Each Got Wrong

**V1** — WORK vs HUSTLE as a binary meant you never felt like you were doing both. Startup progress was always sacrificed, not balanced. Events (if any) were daily busywork.

**Timed Mode** — Stressful in a way that might not be fun. 60 seconds of frantic clicking every "day" would exhaust a player over 30+ days. Also the hardest to implement well.

**V2** — The day simulation is a black box. You allocate, click Start Day, and watch numbers update. There's no engagement during the "work" phase. This is the known gap.

---

## The Open Question

V2's base loop (allocate → instant results → ship decision) is clean but dry. The research docs rated it ~7/10 without texture. The options considered:

- **Daily interruptions** (what Timed Mode explored) — rejected, too much content needed, feels like busywork
- **Real-time pressure** (Timed Mode's actual mechanic) — interesting but potentially exhausting
- **Rare special events** (current V2 design) — chosen for memorability and pacing

The rare events haven't been built yet, so the "is it actually engaging?" question is still open.
