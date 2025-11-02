# Game Redesign Assessment

**Date:** 2025-11-02
**Current Build:** ~1,900 lines of code, playable core loop
**Decision:** Reuse or rebuild?

---

## Executive Summary

**Recommendation: REUSE ~60% of existing code, REBUILD core gameplay loop**

**Why:** The existing architecture (signal-driven, data-driven JSON) is solid and reusable. The UI components can be repurposed. But the core gameplay loop needs to change fundamentally.

**Estimated Effort:**
- Full rebuild: 2-3 weeks
- Smart reuse: 1 week to working prototype

---

## Current Game vs New Design

### Current Game (V1)
**Core Loop:** Daily choice → WORK/HUSTLE/SHIP IT → Progress task → Deal with consequences

**Gameplay Feel:**
- Single task at a time
- Binary choices (work OR hustle)
- Death spiral through bugs
- 30-50 days to complete

**Key Mechanics:**
- Task complexity affects work speed
- Bugs slow everything down (permanent)
- Ship early = more bugs
- Payday every 5 days
- Production outages, PIP warnings, blame system

### New Design (V2)
**Core Loop:** Allocate 8 ducks → Day simulates → Events/consequences → Repeat

**Gameplay Feel:**
- Time allocation strategy
- Split attention (job AND startup)
- Multiple tasks visible/queued
- Duck resource management

**Key Mechanics:**
- 8 ducks per day (discrete allocation)
- Job tasks (assigned) vs Startup features (player choice)
- Random interruptions (some days)
- Multiple endings based on escape path
- Mini-games TBD (inspection/review?)

---

## Viability Analysis

### Current Game (V1)

**Strengths:**
- ✅ Core loop is implemented and playable
- ✅ Death spiral creates tension
- ✅ SHIP IT creates interesting risk/reward
- ✅ Task categories add variety
- ✅ Multiple endings system works

**Weaknesses:**
- ❌ **Single task = repetitive** (same loop 30-50 times)
- ❌ **WORK action is boring** (just click button, watch bar fill)
- ❌ **Not enough player agency** (tasks assigned, no choice)
- ❌ **Death spiral too punishing?** (bugs never decrease = hopeless feeling)
- ❌ **Hustle feels like side mechanic** (not integrated into core tension)

**Fun Factor (Solo Dev):** 5/10
- The satire and writing are fun
- The SHIP IT moment has tension
- But the moment-to-moment is repetitive
- "One more day" works for ~15 minutes, then fades

### New Design (V2)

**Strengths:**
- ✅ **Allocation creates interesting puzzles** (how to split 8 ducks?)
- ✅ **More player agency** (choose startup features)
- ✅ **Job AND startup** (integrated dual objectives)
- ✅ **Visible consequences** (multiple tasks = see ripple effects)
- ✅ **Replayability** (different allocation strategies)

**Weaknesses:**
- ❌ **More complex to implement** (task queue, allocation UI, startup tree)
- ❌ **Mini-game is undefined** (black box - could be boring too!)
- ❌ **Balancing is harder** (more variables = more tuning)
- ❌ **Startup side needs design work** (feature tree, users/revenue, events)

**Fun Factor (Solo Dev):** 7/10 (potential)
- Allocation puzzles are inherently interesting (see: FTL, Invisible Inc)
- Dual objectives create constant tension
- BUT depends heavily on execution (mini-game, balance, pacing)

---

## Solo Dev Feasibility

### Current Game (V1)
- ✅ **80% complete** - Could ship in 1-2 weeks
- ✅ **Scope is manageable** - All systems are implemented
- ✅ **Polish > features** - Add juice, sound, better writing
- ⚠️ **But is it fun enough to finish?** (Motivation risk)

### New Design (V2)
- ⚠️ **50% overlap with V1** - Can reuse architecture, UI components, data systems
- ❌ **2-3 new systems needed:**
  1. Duck allocation UI (slider or discrete buttons)
  2. Task queue/panel (multiple tasks visible)
  3. Startup feature tree (what to build, progression)
- ⚠️ **Mini-game is wildcard** - Could be simple (text choices) or complex (Papers Please-style)
- ✅ **Better long-term potential** - More interesting to work on, more replayable

**Estimated Timeline:**
- Week 1: Rebuild allocation system, task queue, basic simulation
- Week 2: Startup feature tree, events system
- Week 3: Balance tuning, mini-game (if simple), polish
- Week 4+: Mini-game (if complex), juice, sound

---

## Reuse vs Rebuild Analysis

### What Can Be Reused (60% of codebase)

#### ✅ Architecture (100% reuse)
- **GameManager** signal-driven state management
- **TaskManager** JSON loading, difficulty scaling
- Property setters with signal emission pattern
- Autoloaded singletons pattern

#### ✅ Data Systems (90% reuse)
- **tasks.json** - Can keep task data, add new fields (duck_cost, category_effects)
- **endings.json** - Can expand with new ending types
- **outage_messages.json** - Can reuse production outage system
- JSON loading/parsing utilities

#### ✅ UI Components (70% reuse)
- **TopBar** - Money, ducks, bugs display (add: day cycle timer?)
- **JobInfo** - Job title, salary display
- **EndGamePanel** - Victory/game over screens
- **Dialogs** - Production outage, PIP warning, event popups
- CRT terminal theming (fonts, colors, styling)

#### ✅ Game Logic (50% reuse)
- Bug accumulation system
- Production outage system (time bombs, consequences)
- PIP warning/firing system
- Payday system (every 5 days)
- Job progression (junior → senior)
- Victory/game over conditions

### What Needs Rebuilding (40% of codebase)

#### ❌ Core Gameplay Loop
- **Current:** WORK/HUSTLE/SHIP IT buttons → single task progression
- **New:** Duck allocation UI → simulate day → multiple task updates

#### ❌ Task Display
- **Current:** Single task panel (one task at a time)
- **New:** Task queue panel (multiple visible tasks)

#### ❌ Startup System
- **Current:** Simple progress bar (0-100%)
- **New:** Feature tree, user/revenue tracking, player choices

#### ❌ Action System
- **Current:** 3 action buttons, direct consequences
- **New:** Allocation slider/buttons, deferred consequences

---

## Recommendation: SMART REUSE

### Phase 1: Prototype New Loop (3-4 days)
**Goal:** Test if allocation is fun

1. **Keep:** GameManager, signal system, JSON loading
2. **Modify:** Replace WORK/HUSTLE/SHIP IT with allocation UI
3. **Simplify:**
   - Start with 2 tasks max (not full queue)
   - No mini-game yet (just allocation → simulate)
   - Startup = simple progress bar (like V1)
4. **Test:** Is splitting 8 ducks between 2 tasks more fun than V1?

**Reuse:** TopBar, GameManager, TaskManager, task.json, dialogs
**Build:** Allocation UI, day simulation logic

### Phase 2: Add Startup Depth (2-3 days)
**Goal:** Make startup side interesting

1. **Add:** Feature tree (3-5 features to choose from)
2. **Add:** Users/revenue tracking (simple numbers)
3. **Add:** Startup events (user spike, competitor launch, award opportunity)

**Reuse:** Event dialog system, JSON loading
**Build:** Startup feature data, event system

### Phase 3: Task Queue & Interruptions (2-3 days)
**Goal:** Add strategic depth

1. **Add:** Task queue panel (see 3-4 tasks at once)
2. **Add:** Random interruptions (some days only)
3. **Add:** Duck cost per task category (Optics = 2 ducks, Tech Debt = 5 ducks, etc.)

**Reuse:** Task panel components, task category system
**Build:** Task queue UI, interruption system

### Phase 4: Mini-Game (TBD)
**Goal:** Make "coding" phase interesting

**Option A - Simple** (1-2 days): Text-based choices (help coworker? fix bug? cut corner?)
**Option B - Complex** (5-7 days): Papers Please-style inspection (review PRs, catch bugs, approve/reject)

**Recommendation:** Start with Option A, upgrade to B only if core loop is fun

---

## Decision Matrix

| Criterion | Current Game (V1) | New Design (V2) |
|-----------|-------------------|-----------------|
| **Fun Potential** | 5/10 (repetitive) | 7/10 (puzzle-y) |
| **Time to Playable** | 1 week (polish) | 2-3 weeks (rebuild) |
| **Scope Risk** | Low (80% done) | Medium (40% new) |
| **Replayability** | Low (same strategy) | High (multiple paths) |
| **Dev Motivation** | Medium (burnout risk) | High (more interesting) |
| **Technical Risk** | Low (proven) | Medium (balancing) |

---

## Final Recommendation

### If You Want to SHIP FAST (1-2 weeks):
**Finish V1.** Polish the existing game, add juice, improve writing, ship it.

**Why:** 80% done, proven loop, low risk. Get something out there.

**Risk:** You might lose motivation if the core loop doesn't excite you.

### If You Want to BUILD SOMETHING BETTER (3-4 weeks):
**Hybrid approach.** Reuse V1 architecture, rebuild core loop for V2.

**Why:** V2 has higher fun potential, more replayable, more interesting to work on.

**Risk:** Scope creep (mini-game could balloon), balancing complexity.

---

## My Honest Take (as your AI pair programmer)

**V1 is 80% done but 50% fun.**
**V2 is 40% done but 70% fun potential.**

If you're feeling burnout on V1 (based on "i dont think there is currently a fun game loop"), then finishing it will be painful. You'll ship something you're lukewarm about.

**I recommend V2 with smart reuse:**
- Build Phase 1 prototype (3-4 days)
- Playtest the allocation mechanic
- If it's fun → continue to Phase 2-4
- If it's not → at least you only spent 4 days, not 4 weeks

The good news: **Your V1 codebase is well-architected.** Signal-driven, data-driven, modular. It's designed to be refactored. You're not throwing away 1,900 lines—you're evolving them.

---

## Next Steps

1. **Decide:** Fast ship (V1) or better game (V2)?
2. **If V2:** I'll write a GDD for the new design
3. **Prototype:** Build Phase 1 (allocation UI) in 3-4 days
4. **Playtest:** Does splitting ducks feel better than clicking WORK?
5. **Iterate:** Based on feel, continue or pivot

**What do you think?**
