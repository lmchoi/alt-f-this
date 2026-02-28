# Core Loop - Simplified (Final)

**Date:** 2025-11-02
**Status:** Design locked

---

## The Loop (30-45 seconds per day)

```
┌─────────────────────────────────────┐
│ 1. MORNING - ALLOCATION (10 sec)   │
│    Job vs Startup split (8 ducks)  │
└─────────────────────────────────────┘
                ↓
┌─────────────────────────────────────┐
│ 2. START DAY (instant)              │
│    Day simulates automatically      │
└─────────────────────────────────────┘
                ↓
┌─────────────────────────────────────┐
│ 3. SPECIAL EVENT (if triggered)    │
│    ~20-30% of days                  │
│    - Caught hustling                │
│    - Production outage              │
│    - Coworker crisis                │
│    - Boss demands demo              │
└─────────────────────────────────────┘
                ↓
┌─────────────────────────────────────┐
│ 4. RESULTS (10 sec)                 │
│    See progress made                │
│    Job: 40% → 60%                   │
│    Startup: +25 users               │
└─────────────────────────────────────┘
                ↓
┌─────────────────────────────────────┐
│ 5. SHIP DECISION (10-15 sec)       │
│    If job task ready:               │
│    Ship now? Wait?                  │
└─────────────────────────────────────┘
                ↓
┌─────────────────────────────────────┐
│ 6. CONSEQUENCES (5 sec)            │
│    Bugs added, payment, new task    │
└─────────────────────────────────────┘
                ↓
           NEXT DAY
```

---

## Key Changes from Previous Design

### Before (Interruptions as Core)
- 2-4 interruptions EVERY day
- 60-160 total interruptions per game
- Repetition problem
- Feels like busywork

### After (Special Events)
- 1 event on 20-30% of days
- 8-12 total events per game
- Each feels significant
- Memorable moments

---

## Special Event Types (8-10 Total)

### 1. Caught Hustling (Most Common)
**Trigger:** Allocate ducks to startup, roll detection
**Frequency:** 1-3 times per playthrough
**Impact:** Strike system (warning → PIP → fired)

```
🚨 Your boss noticed you working on something
   that's not PROJ-1337.

Boss: "What's that code you're working on?"

[Lie: "Just learning"] (30% works, 70% strike)
[Honest: "Side project"] (Strike, but boss respects it)
[Play dumb: "Stack Overflow"] (60% works, 40% strike +2)
```

---

### 2. Production Outage (Crisis)
**Trigger:** High bugs (>40) OR shipped poor quality
**Frequency:** 0-2 times per playthrough
**Impact:** Must handle immediately OR major consequences

```
🔥 PRODUCTION DOWN
   Users can't log in. Slack is on fire.

[Drop everything, fix now]
  → Lose all progress today (job + startup)
  → But prevent 50 bugs from accumulating

[Let it burn]
  → Keep progress
  → +50 bugs, boss fury, possible PIP
```

---

### 3. Coworker Crisis (Moral Choice)
**Trigger:** Random, mid-game
**Frequency:** 1-2 times per playthrough
**Impact:** Relationships, possible favors later

```
💬 Bob (junior dev) is drowning in his task.
   He's about to miss deadline and get PIP'd.

[Help him]
  → Lose today's progress
  → Bob +5 relationship (he owes you)

[Let him fail]
  → Keep progress
  → Bob gets PIP'd, resents you

[Blame him]
  → Keep progress, boss +1
  → Bob becomes hostile (may sabotage later)
```

---

### 4. Boss Demands Demo (Pressure)
**Trigger:** Task is 40-80% complete
**Frequency:** 1-2 times per playthrough
**Impact:** Forced ship decision

```
👔 Your boss walks up to your desk.

Boss: "Show me what you've got on PROJ-1337."

[Demo at current %]
  → Ships immediately at whatever quality
  → Boss judges based on quality

[Stall: "Give me 30 minutes"]
  → Continue working today
  → Boss -1 (annoyed by delay)

[Honest: "It's not ready"]
  → Don't ship today
  → Deadline +1, boss +1 (respects honesty)
  → 30% chance PIP for "lack of progress"
```

---

### 5. Recruiter Contact (Opportunity)
**Trigger:** Mid-late game, good work history
**Frequency:** 0-1 times per playthrough
**Impact:** Info about escape options

```
📧 LinkedIn message from recruiter.

"$120K role at BigTech, interested?"

[Take call]
  → Learn about job offer (backup escape plan)
  → Lose today's progress
  → Unlock "Accept offer" ending later

[Ignore]
  → Keep progress
  → Miss opportunity
```

---

### 6. Startup User Feedback (Momentum)
**Trigger:** Startup has 200+ users
**Frequency:** 1-2 times per playthrough
**Impact:** Feature direction choice

```
💬 Your startup users are asking for features:

Pick one to prioritize:

[Dark Mode] → Users +50%, no revenue
[Payments] → Revenue +$50/day, no users
[Mobile App] → Users +100%, maintenance cost

[Ignore all] → Users churn -20%
```

---

### 7. Performance Review (Stakes)
**Trigger:** Every 15 days
**Frequency:** 2-3 times per playthrough
**Impact:** Promotion, PIP, or warning

```
📋 Performance review with your boss.

Results based on:
- Tasks completed
- Quality average
- Deadline performance

Outcomes:
→ Excellent: Promotion offer (golden handcuffs risk)
→ Good: Nothing changes
→ Poor: PIP warning
→ Terrible: Fired
```

---

### 8. Competitor Launches (Threat)
**Trigger:** Startup has momentum
**Frequency:** 0-1 times per playthrough
**Impact:** User growth slowed

```
📰 Tech news: "New app [CompetitorName]
   raises $2M seed round."

They copied your idea.

Effect: User growth -50% for next 5 days

[Panic pivot]
  → Change direction, lose momentum

[Stay the course]
  → Trust your execution beats their funding
```

---

### 9. Team Happy Hour (Optional)
**Trigger:** Friday, random
**Frequency:** 2-4 times per playthrough
**Impact:** Relationship building

```
🍺 Team is going to happy hour after work.

[Go]
  → Lose today's progress
  → All coworkers +1 relationship
  → Boss sees you as "team player"

[Skip]
  → Keep progress
  → No relationship changes
```

---

### 10. Health Warning (Rare)
**Trigger:** Worked 10 days straight, high stress
**Frequency:** 0-1 times per playthrough
**Impact:** Forced rest OR consequences

```
⚠️  You feel exhausted. Burnt out.

[Take sick day]
  → No progress today
  → Reset stress (reduces caught chance 5 days)

[Push through]
  → Keep progress
  → +30% caught chance next 3 days
  → Possible "burnout" ending if happens 3x
```

---

## Event Frequency Design

### Week 1-2 (Days 1-14)
- **Events:** 2-3 total (1 every 5-7 days)
- **Types:** Low stakes (happy hour, coworker help)
- **Purpose:** Learn that events exist, but rare

### Week 3-4 (Days 15-28)
- **Events:** 3-4 total (1 every 3-4 days)
- **Types:** Medium stakes (caught hustling, outages)
- **Purpose:** Escalating tension

### Week 5+ (Days 29+)
- **Events:** 3-5 total (1 every 2-3 days)
- **Types:** High stakes (performance review, crisis)
- **Purpose:** Endgame pressure

**Total per playthrough:** 8-12 events (not 60-160!)

---

## Benefits of This Design

### ✅ No Repetition
- Only 8-12 events total per game
- Each type appears 0-3 times
- Always feels special, never routine

### ✅ Faster Base Loop
- Most days: Allocate → Results → Ship → Next (30 seconds)
- Event days: +15-30 seconds (still fast)
- Overall pace is snappy

### ✅ Memorable Moments
- "Remember when production went down on Day 23?"
- "I got caught 3 times and barely escaped"
- Events become stories

### ✅ Less Content Needed
- 10 event types (not 40)
- More time for polish/juice
- Each event can be crafted well

### ✅ Strategic Depth Still There
- Hidden modifiers (boss mood, relationships)
- Feedback loops (reputation systems)
- Cascading consequences (help Bob → he covers you later)

---

## What Happens on Non-Event Days?

**Behind the scenes (hidden from player):**

1. **Boss Mood** updates
   - Ship well → Boss happy → -10% caught
   - Ship poorly → Boss watching → +15% caught

2. **Relationships** decay slowly
   - Ignore coworkers → Relationships -0.1/day
   - Help when asked → +1 immediate

3. **Bug Impact** compounds
   - High bugs (>50) → Next event more likely to be outage
   - Low bugs (<10) → More likely to get performance praise

4. **Startup Momentum** tracked
   - Ship features regularly → Growth multiplier up
   - Stall 7+ days → Growth multiplier down

5. **Deadline Pressure** builds
   - Task due in 1 day → Next event might be boss pressure
   - Overdue → Event will be PIP-related

**But player doesn't SEE these systems** - they just experience outcomes.

---

## The Experience

### Typical Week:

**Monday:** Allocate, work, ship task (30 sec)
**Tuesday:** Allocate, work, no ship (20 sec)
**Wednesday:** Allocate, work → **CAUGHT HUSTLING EVENT** (45 sec)
**Thursday:** Allocate, work (20 sec, paranoid from yesterday)
**Friday:** Allocate, work → **Team Happy Hour event** (30 sec)

**Total:** ~2 minutes for 5 days = Fast-paced

---

## Rating Impact

**Before (daily interruptions):** 7/10
- Variety but repetitive
- Content-heavy to build
- Risk of busywork feel

**After (rare special events):** 8/10
- Fast base loop (like Universal Paperclips)
- Memorable event moments (like FTL)
- Hidden depth (emergent systems)
- Cleaner scope (less content needed)

---

## Implementation Priority

### Phase 1 (MVP)
- Core loop (allocate → results → ship)
- Caught hustling event (THE signature event)
- Ship decision
- Basic endings

### Phase 2 (Events)
- Add 5-6 special events:
  1. Caught hustling ✅ (already in Phase 1)
  2. Production outage
  3. Coworker crisis
  4. Boss demands demo
  5. Performance review
  6. Startup user feedback

### Phase 3 (Polish)
- Add remaining 3-4 events (recruiter, competitor, etc.)
- Hidden modifier systems (boss mood, relationships)
- Juice (animations, sounds, particles)

---

## Summary

**Interruptions → Special Events**

- Not core mechanic, but rare dramatic moments
- 8-12 per playthrough (not 60-160)
- Each is memorable, none feel routine
- Allows faster base loop
- Less content to create = more time for polish

**Core tension comes from:**
1. Allocation decision (job vs startup risk)
2. Caught hustling (inevitable if you hustle hard)
3. Ship decision (quality vs deadline)
4. Progression systems (promotion, bugs, relationships)

**Events are spice, not the meal.**

---

**This is the design. Lock it in.**

Next: Build Phase 1 prototype with this loop.
