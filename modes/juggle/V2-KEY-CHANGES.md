# V2 Key Changes Summary

**Date:** 2025-11-02
**Status:** Design finalized, ready for prototype

---

## Major Simplifications from Initial V2 Draft

### 1. Allocation: Job OR Startup (Not Multiple Tasks)
**Before:** Allocate 8 ducks across multiple job tasks + startup
**After:** Allocate 8 ducks between ONE current job task + startup

**Why:** Simpler, clearer choice. "How much do I work on my job vs my escape plan?"

---

### 2. Interruptions Slow Progress (Don't Steal Ducks)
**Before:** Events steal ducks from allocation
**After:** Interruptions reduce efficiency (15-50% progress penalty)

**Formula:**
```
Planned: 5 ducks × 12% = 60% progress
Handle 2 interruptions: -30% efficiency
Actual: 60% × 0.7 = 42% progress
```

**Why:** Clearer cause-and-effect. "I planned to finish this, but meetings happened."

---

### 3. Ducks Are NOT a Resource
**Before:** Ducks = health/sanity, 0 ducks = game over
**After:** Ducks are just time units (always 8 per day)

**Why:** One less resource to track. Focus on money, bugs, deadlines, and caught hustling.

---

### 4. Salary Fixed by Job Level (Not Per-Task)
**Before:** Get paid for each task completed
**After:** Fixed weekly salary (junior/mid/senior), payday every 5 days

**Why:** Matches real job structure. Promotion = raise, not task bonuses.

---

### 5. Caught Hustling = 3-Strike System
**New mechanic:** Detection chance based on startup allocation

| Startup Ducks | Detection % |
|---------------|-------------|
| 0 ducks | 0% |
| 1-2 ducks | 10% (sneaky) |
| 3-5 ducks | 30% (risky) |
| 6-7 ducks | 50% (bold) |
| 8 ducks | 70% (reckless) |

**Consequences:**
1. First caught: Warning
2. Second caught: PIP (Performance Improvement Plan)
3. Third caught: Fired

**Why:** Core tension. You WILL get caught if you hustle hard. Can you finish before Strike 3?

---

### 6. Win Conditions: App Complete + Money/Revenue
**Before:** Multiple paths (money only, users only, mixed)
**After:** Two clear paths:

1. **App Complete + $X saved** (enough runway to quit)
2. **App Complete + $Y/day revenue** (self-sustaining)

**Why:** Both require finishing the app. Forces you to actually build something, not just save money.

---

### 7. Lose Conditions: Refocused
**Removed:**
- Burnout (0 ducks)
- 100+ bugs

**Kept/Refined:**
1. **Fired (deadlines):** Miss too many → PIP → Fired
2. **Fired (caught hustling):** Caught 3 times → Fired
3. **Golden Handcuffs:** Promoted to management (shipped too many tasks)
4. **Stuck:** Many tasks done, still mid-level, app not complete (grind without progress)

**Why:** Clearer failure states, all feel different narratively.

---

## Core Loop (Finalized)

```
Morning
├─ Allocate 8 ducks
│  └─ Job: X ducks, Startup: Y ducks
│
Day Simulation
├─ Interruptions popup (2-4 per day)
│  ├─ Boss wants meeting
│  ├─ Coworker needs help
│  └─ Production alert
│
├─ For each interruption:
│  ├─ Handle: Reduces progress 15-25%
│  └─ Ignore: Keep progress, but consequences
│
End of Day
├─ See actual progress
│  ├─ Job: Planned 60%, got 42% (interruptions!)
│  └─ Startup: Planned +50 users, got +35
│
├─ Caught hustling check (if startup > 0)
│  └─ Roll dice based on allocation
│
Ship Decision (if task ready)
├─ Ship now? (bugs added, new task)
└─ Wait? (deadline pressure)
│
Next Day
└─ New task if shipped
   └─ Closer to promotion (golden handcuffs risk)
```

---

## Key Formulas

### Job Progress
```
base = ducks × 12%
efficiency = 1 - (interruptions_handled × 0.15)
bugs_slow = 1 + (bugs × 0.01)

final_progress = (base × efficiency) / bugs_slow
```

### Startup Progress
```
base = ducks × 10%
efficiency = 1 - (interruptions_handled × 0.15)

users_gained = base × efficiency × 100 × (1 + features_done)
```

### Caught Hustling
```
base_chance = {
  0 ducks: 0%,
  1-2: 10%,
  3-5: 30%,
  6-7: 50%,
  8: 70%
}

modifiers:
+ Boss watching: +15%
+ Low coworker relationship: +10%
+ Shipped poorly: +15%
- High coworker relationship: -10%
- Shipped well: -10%

final_chance = base_chance + modifiers
```

### Ship Bugs
```
bugs_added = (100 - quality) / 10

quality = task_progress when shipped
- 90%+: 0-1 bugs
- 70-89%: 1-3 bugs
- 50-69%: 3-5 bugs
- <50%: 5-10 bugs
```

---

## Win/Loss Targets

### Victory (Escape)
**Path 1: Money**
- App: 100% complete (all features shipped)
- Money: $3,000 saved
- Days: 30-40

**Path 2: Revenue**
- App: 100% complete
- Revenue: $50/day from app
- Days: 35-45

### Loss (Failure)
**Fired (Deadlines)**
- Miss 2 deadlines → PIP
- Miss 1 more → Fired
- Days: Varies (15-40)

**Fired (Caught)**
- Caught 2 times → PIP
- Caught 1 more → Fired
- Days: Varies (20-35 if aggressive)

**Golden Handcuffs**
- Ship 15+ tasks at high quality
- Get promoted to management
- Days: 40-50

**Stuck**
- Ship 20+ tasks, still mid-level
- App <50% complete
- Days: 50+
- "You became a code monkey and forgot to escape."

---

## Content Requirements

### Minimum Viable Product
- **30-40 interruptions** (variety, not repetition)
- **20-25 job tasks** (mix of categories)
- **8-10 startup features** (player choice tree)
- **6-8 endings** (victory variants + loss variants)
- **40-60 interruption/ship messages** (flavor text)

### Interruption Types
1. **Boss (30%)** - Meetings, demos, scope changes
2. **Coworker (25%)** - Help requests, pair programming
3. **Technical (25%)** - Outages, bugs, code review
4. **Distraction (15%)** - Slack, email, random
5. **Caught Hustling (5%)** - Special detection events

---

## UI Changes from V1

### Keep from V1
- Top bar (money, bugs, day)
- Terminal aesthetic
- Signal-driven architecture
- JSON data loading

### Change from V1
- **Single task display** (not multiple)
- **Allocation slider/buttons** (job vs startup, 8 ducks)
- **Interruption popups** (handle/ignore, not complex choices)
- **Strike counter** (caught hustling warnings)
- **Simpler ship UI** (one task, not task queue)

### Add to V2
- **Detection risk indicator** (when allocating to startup)
- **PIP warning banner** (when on performance plan)
- **Interruption impact preview** ("This will cost 15% progress")
- **Startup feature tree** (choose next feature to build)

---

## Technical Architecture

### Reuse from V1 (~60%)
- ✅ GameManager (signals, state)
- ✅ TaskManager (JSON loading)
- ✅ Bug system
- ✅ Payday system
- ✅ Ship quality system
- ✅ End game panel

### Modify from V1
- 🔄 Task display (single task, not panel)
- 🔄 Action buttons (allocate, not WORK/HUSTLE/SHIP)
- 🔄 Event system (interruptions, not complex events)

### Build New
- ✅ Allocation UI (slider or buttons)
- ✅ Caught hustling system (detection, strikes, PIP)
- ✅ Interruption popup UI (handle/ignore)
- ✅ Startup feature tree

---

## Development Phases

### Phase 1: Core Loop (Week 1)
- Allocation UI (8 ducks, job vs startup)
- Day simulation (progress calculation)
- Interruptions (2-4 per day, handle/ignore)
- Ship decision (basic)
- Caught hustling (basic % check)

**Milestone:** Can play 5 days, see if loop is fun

### Phase 2: Content (Week 2)
- 20-30 interruptions
- 15-20 job tasks
- 5-8 startup features
- Ship messages
- Caught events (detailed)

**Milestone:** Has variety, not repetitive

### Phase 3: Juice (Week 3)
- Progress bar animations
- Interruption popups (Slack style)
- Detection risk indicator
- Sound effects
- Particle effects

**Milestone:** Feels good to play

### Phase 4: Balance (Week 4)
- Tune formulas
- Playtesting
- Difficulty curve
- Endings

**Milestone:** Winnable but challenging

---

## Key Design Principles

1. **Simple > Complex**
   - One job task (not queue)
   - Binary allocation (not multi-task)
   - Handle/Ignore (not complex choices)

2. **Clear Consequences**
   - Interruptions → less progress (visible)
   - Hustling → caught chance (shown)
   - Shipping → bugs (calculated)

3. **Tension Without Stress**
   - You WILL get caught (but 3 strikes)
   - You WILL ship bugs (but manageable)
   - You WILL miss some deadlines (but PIP first)

4. **Relatable Suffering**
   - Interruptions feel real (meetings, Slack)
   - Caught hustling is dramatic (3-strike dread)
   - Golden handcuffs is ironic (success = failure)

---

## Success Metrics

**Core Loop:**
- Can explain game in 30 seconds? ✓
- Allocation decision feels meaningful? ✓
- Interruptions create texture? ✓
- Caught mechanic creates tension? ✓

**Engagement:**
- "One more day" pull? (Playtest)
- Replay for different paths? (Playtest)
- Share caught/fired stories? (Playtest)

**Theme:**
- Devs recognize their life? (Feedback)
- "Boring" UI works? (Feedback)
- Dark humor lands? (Feedback)

---

**Next:** Build Phase 1 prototype (core loop + basic interruptions)

See: [GDD.md](GDD.md) for full details, [ONE-PAGER.md](../../ONE-PAGER.md) for pitch.
