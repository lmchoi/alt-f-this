# Interruption Mechanics Design

How interruptions should affect timed mode gameplay.

---

## Current State (What Exists)

### Implementation
- **InterruptionManager** triggers random interruptions every ~10 seconds (±5s variance)
- Shows as **cards** in an interruption stack (UI already exists)
- Click card → opens popup → dismiss → card disappears
- **Blocks progress** while popup is open (`InterruptionManager.current_interruption` is set)
- Currently just placeholder: "Something needs your attention"

### What's Missing
- **No consequences** - dismissing does nothing (no resource cost, no choices)
- **No variety** - all interruptions are identical placeholders
- **No strategic depth** - just click to dismiss, pure interruption
- **No connection to game state** - doesn't scale with bugs/ducks/day

---

## Design Question: What Should Interruptions DO?

### Option 1: **Pure Time Wasters** (Simplest)
**What:** Interruptions just block progress, no other effects
**Pro:** Simple, already implemented, creates time pressure
**Con:** No strategic depth, feels annoying not engaging

**Example:**
- "CEO wants status update" → Click to dismiss → Resume work
- Just wastes 5-10 seconds of your 60s timer

---

### Option 2: **Resource Tax** (Papers Please style)
**What:** Interruptions cost resources (ducks, time, progress)
**Pro:** Creates tension, forces tradeoffs
**Con:** Needs balancing, can feel punishing

**Example:**
- "Slack message from coworker" → Auto-costs 5s + 10% current task progress
- No choice, just consequence

---

### Option 3: **Decision Points** (Recommended)
**What:** Interruptions offer choices with tradeoffs
**Pro:** Strategic depth, player agency, memorable moments
**Con:** More complex to implement and balance

**Example:**
```
"Production is down! CEO is panicking."

[Ship Hotfix] - Lose 20% task progress, +5 bugs
[Ignore] - CEO anger, -1 duck, 30% chance of firing
```

---

## Recommended Design: Decision Points

Interruptions should create **moral dilemmas** that fit the game's "Papers Please meets Office Space" vibe.

### Categories of Interruptions

#### 1. **Boss Demands** (Political pressure)
- CEO wants status update NOW
- Manager needs you in a meeting
- Urgent "priority shift" request

**Tradeoff:** Respond (lose time/progress) vs. Ignore (lose ducks/reputation)

**Example:**
```
"CEO: 'Where are we on this?'"

[Write Update] - Lose 15s, keep CEO happy
[Ignore Email] - Keep working, -1 duck (stress)
```

---

#### 2. **Production Fires** (Technical crisis)
- Site is down
- Critical bug in production
- Customer escalation

**Tradeoff:** Fix immediately (add bugs to current task) vs. Let it burn (reputation damage)

**Example:**
```
"PROD DOWN: Users can't log in"

[Ship Hotfix] - +10 bugs, lose 20% task progress
[Forward to Ops] - 50% chance firing, -1 duck
```

---

#### 3. **Coworker Requests** (Social obligation)
- Help with code review
- Answer technical question
- Cover for someone's mistake

**Tradeoff:** Help (lose time) vs. Ignore (feel guilty)

**Example:**
```
"Junior dev: 'Can you review my PR?'"

[Help Them] - Lose 10s, rare +duck (feels good)
[Say Busy] - Keep working, small duck cost
```

---

#### 4. **System Chaos** (Random disasters)
- Build pipeline broken
- Staging environment down
- AWS bill spike

**Tradeoff:** Fix (waste time) vs. Work around (add complexity)

**Example:**
```
"CI/CD is broken. Tests won't run."

[Debug Pipeline] - Lose 15s
[Skip Tests] - Ship without testing, +bugs when you SHIP IT
```

---

## Gameplay Impact

### When Interruptions Trigger
- **Frequency:** Every 8-15 seconds in timed mode (randomized)
- **Timing:** Can interrupt mid-work (realistic, stressful)
- **Stacking:** Multiple can pile up (like real work!)

### How They Block Progress
**Current behavior (keep this):**
- Click interruption card → popup opens
- While popup is open, timer still runs BUT progress is blocked
- Player must make choice before resuming work
- This creates urgency: "Every second I spend reading this, I'm losing time!"

### Consequences Should Compound
- Ignore boss → lose ducks → burnout → game over
- Ship hotfixes → add bugs → slower work → death spiral
- Help coworkers → lose time → miss deadlines → fired

---

## Implementation Priority

### MVP (Ship This First)
1. **Keep current system:** Random placeholder interruptions that just block time
2. **Test if it's fun:** Does pure interruption create enough tension?
3. **Ship and gather feedback:** Do players want more depth?

### Phase 2 (If Needed)
4. **Add 3-5 real interruptions** with choices (boss, prod fire, coworker)
5. **Hook up consequences** (duck loss, bug addition, progress reduction)
6. **Balance frequency** based on playtesting

### Phase 3 (Polish)
7. **Scale with game state:** More interruptions as bugs increase
8. **Add variety:** 10-15 different interruptions with flavor text
9. **Add events:** Rare positive interruptions (promotion offer, bonus)

---

## My Recommendation

**For MVP:** Keep interruptions as-is (placeholder time wasters), focus on layout redesign.

**Reasoning:**
- Current system already creates time pressure (blocks progress)
- Layout redesign is more critical (affects all modes)
- Interruption depth can be added after playtesting base loop

**After layout redesign + juice:**
- Test timed mode with placeholder interruptions
- If players say "interruptions are annoying" → Add choices to make them engaging
- If players say "game is boring" → Add more interruption variety
- If players say "timed mode is perfect" → Maybe current interruptions are enough!

---

## Next Steps

1. ✅ **Finish layout redesign** - Foundation for everything
2. ✅ **Add juice** - Make progress feel satisfying
3. ✅ **Test timed mode** with placeholder interruptions
4. ✅ **Ship MVP** - Get feedback from real players
5. ⏸️ **Design real interruptions** based on what's missing (this doc is the starting point)

---

## Questions to Answer After Playtesting

- Are interruptions creating fun tension or just frustration?
- Do players want more control (choices) or is random chaos good?
- Is interruption frequency right (too many? too few?)
- Do we need different interruption types or is variety unnecessary?
- Should interruptions scale with bugs/day or stay constant?
