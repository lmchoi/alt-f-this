# Alt+F+This - Game Design Document (V2)

**Version:** 2.0
**Last Updated:** 2025-11-03
**Status:** Pre-production

**Balance Values:** All exact numbers, formulas, and tunable values are in [BALANCE.md](BALANCE.md)

---

## Table of Contents

1. [Vision & Goals](#vision--goals)
2. [Core Loop](#core-loop)
3. [Game Systems](#game-systems)
4. [Progression & Balance](#progression--balance)
5. [Content Specifications](#content-specifications)
6. [UI/UX Design](#uiux-design)
7. [Technical Architecture](#technical-architecture)
8. [Development Roadmap](#development-roadmap)

---

## Vision & Goals

### High-Level Vision
A darkly comedic allocation strategy game where you escape corporate hell by building a startup in secret, making impossible choices between meeting deadlines and shipping quality code.

### Design Pillars

1. **Relatable Suffering**
   - Theme resonates with developers
   - Authentic corporate frustrations
   - "That's literally my job" moments

2. **Meaningful Choices**
   - Every allocation decision matters
   - Ship early vs ship quality
   - Job security vs escape progress

3. **Emergent Narrative**
   - Story told through mechanics
   - Character decay shown via choices
   - Player complicity in descent

4. **Replayable Strategy**
   - Multiple paths to victory
   - Different allocation strategies
   - Varied event outcomes

5. **Satirical Authenticity**
   - "Boring" UI as feature
   - Real dev tool aesthetics
   - Dark humor, not silly

---

## Core Loop

### Day Structure (30-45 seconds)

```
┌─────────────────────────────────────┐
│ 1. MORNING - ALLOCATION (~10 sec)  │
│    Simple choice: Job vs Startup    │
│    Job (current task): X ducks      │
│    Startup: Y ducks                 │
└─────────────────────────────────────┘
                ↓
┌─────────────────────────────────────┐
│ 2. START DAY (instant)              │
│    Day simulates automatically      │
└─────────────────────────────────────┘
                ↓
┌─────────────────────────────────────┐
│ 3. SPECIAL EVENT (if triggered)    │
│    Rare occurrences (~25% of days)  │
│    - Caught hustling                │
│    - Production outage              │
│    - Boss demands demo              │
│    - Coworker crisis                │
│    (+15-30 sec when happens)        │
└─────────────────────────────────────┘
                ↓
┌─────────────────────────────────────┐
│ 4. RESULTS (~10 sec)                │
│    See progress made                │
│    Job: X% → Y%                     │
│    Startup: +N users                │
│    (No interruptions most days)     │
└─────────────────────────────────────┘
                ↓
┌─────────────────────────────────────┐
│ 5. SHIP DECISION (~10-15 sec)      │
│    If job task ready OR deadline:   │
│    - Ship at current %?             │
│    - Wait? (deadline risk)          │
└─────────────────────────────────────┘
                ↓
┌─────────────────────────────────────┐
│ 6. CONSEQUENCES (~5 sec)           │
│    Bugs added, salary (if payday)   │
│    New task assigned (if shipped)   │
└─────────────────────────────────────┘
                ↓
           NEXT DAY
```

### Engagement Points Per Day
- **1 allocation decision** (job vs startup split)
- **0-1 special event response** (rare, see BALANCE.md for frequency)
- **1 ship decision** (if task ready)
- **Total: 2-3 decisions per day** (fast, focused)

**Key Change:** Events are RARE (handful per game), not daily (dozens per game)

---

## Game Systems

### 1. Duck Allocation System

**Concept:** "Ducks" = hours/energy/focus (fixed amount per day)

#### Allocation Rules
- **Fixed ducks available each morning** (see BALANCE.md)
- **Binary choice:** Split between Job OR Startup
- **One current job task** (not multiple)
- **Locked once day starts** (interruptions reduce efficiency, not ducks)

**Example Allocations:**
- X job / Y startup (balanced)
- All job / zero startup (safe, no startup progress)
- Few job / most startup (risky, high chance caught)

#### Job Task Progress
Progress calculation factors in ducks allocated and bug accumulation. More bugs slow down work exponentially. See BALANCE.md for exact formula.

**Example:**
- Allocated: X ducks to job
- Base progress: Y%
- Bugs: N (affects multiplier)
- Final progress: Z%

**Note:** No daily interruption penalty (events are rare)

#### Startup Progress
Progress calculation based on ducks allocated and features already completed. More features create compound growth. No bug accumulation on startup (your own code, your rules).

**Example:**
- Allocated: X ducks to startup
- Base progress: Y%
- Features completed: N
- Users gained: Z users

---

### 2. Special Event System

**Concept:** Rare, dramatic moments that interrupt your routine

#### Event Frequency
Events occur at different rates throughout the game, becoming more frequent as pressure increases. Total events per playthrough is limited (see BALANCE.md for exact frequencies).

| Game Phase | Event Chance | Total Events |
|------------|--------------|--------------|
| Early weeks | Lower % | Few events |
| Mid-game | Medium % | Some events |
| Late game | Higher % | More events |

**Total per playthrough:** Limited number (not dozens!)

#### Event Types (10 Total)

**High Frequency Events (Appear multiple times):**
1. **Caught Hustling** - Detection based on startup allocation
2. **Performance Review** - Scheduled intervals
3. **Team Happy Hour** - Friday, optional

**Medium Frequency Events (Appear occasionally):**
4. **Production Outage** - Triggered by high bugs or poor ships
5. **Boss Demands Demo** - Task is partially complete
6. **Coworker Crisis** - Moral choice
7. **Startup User Feedback** - User milestone reached

**Low Frequency Events (Appear rarely):**
8. **Recruiter Contact** - Mid-late game, good work
9. **Competitor Launches** - Startup has momentum
10. **Health Warning** - Worked many days straight

#### Event Structure (JSON)
```json
{
  "id": "boss_demo_request",
  "title": "Boss Wants Demo",
  "description": "@boss: 'Can you demo PROJ-1337 in 5 minutes?'",
  "trigger_conditions": {
    "min_day": 5,
    "task_progress_min": 30,
    "task_progress_max": 80,
    "weight": 10
  },
  "choices": [
    {
      "text": "Demo now (ship at current %)",
      "consequences": {
        "ship_current_task": true,
        "boss_relationship": 1
      }
    },
    {
      "text": "Need 30 min (cost: X ducks from today)",
      "consequences": {
        "steal_ducks": 2,
        "boss_relationship": -1
      }
    },
    {
      "text": "Actually, it's broken (honest)",
      "consequences": {
        "deadline_extension": 1,
        "boss_relationship": 2,
        "chance_pip_warning": 0.3
      }
    }
  ]
}
```

#### Event Categories

**1. Boss Events (~30%)**
- Demo requests
- Meeting interruptions
- Scope changes
- Performance reviews

**2. Technical Events (~30%)**
- Production outages
- Code review findings
- Bug reports
- Security issues

**3. Coworker Events (~20%)**
- Help requests
- Pair programming
- Blame opportunities
- Gossip/drama

**4. Startup Events (~15%)**
- User feedback
- Competitor launches
- Award opportunities
- Press inquiries

**5. Meta Events (~5%)**
- Caught hustling
- Promotion offers
- Recruiter messages
- Health warnings

---

### 3. Task System

#### Task Structure
```json
{
  "id": "make_logo_bigger_again",
  "title": "Make Logo Bigger (Again)",
  "description": "CEO saw competitor's site. Our logo is 'not impactful enough.'",
  "category": "optics",
  "complexity": 3,
  "deadline_days": 5,
  "payment": 300,
  "special_mechanics": {
    "ceo_review": true,
    "possible_outcomes": ["loved", "hated", "ignored"]
  }
}
```

#### Task Categories

**Optics (Political Risk)**
- Lower technical complexity
- High political risk (CEO might love OR hate it)
- Short deadlines (boss wants it NOW)
- Random outcomes (not skill-based)

**Examples:**
- Make logo bigger
- Change button color to match CEO's shirt
- Add "AI" to product description

**Tech Debt (Long-term Consequences)**
- High complexity
- Bugs multiply if shipped early (significant penalty)
- Long deadlines (can't rush this)
- Compounds over time

**Examples:**
- Migrate to new framework
- Refactor authentication system
- Fix race condition in payments

**Critical (Immediate Stakes)**
- Medium complexity
- High urgency (production is down)
- Ship below threshold → guaranteed outage next day
- Customer-facing consequences

**Examples:**
- Fix payment processing bug
- Resolve data breach
- Restore backup after outage

---

### 4. Ship Decision System

#### Ship Trigger Conditions
Task becomes "shippable" when:
1. **Progress ≥ threshold** (minimum viable)
2. **Deadline ≤ 1 day** (forced decision)
3. **Event forces ship** (boss demands it)

See BALANCE.md for exact thresholds.

#### Ship Consequences by Quality

Quality bands determine bugs added, payment received, and duck changes. Higher quality = fewer bugs and better outcomes. Lower quality = technical debt and potential consequences.

**Quality Tiers:**
- **Excellent**: Minimal/no bugs, full payment, positive effects
- **Good**: Few bugs, full payment, neutral
- **Acceptable**: Some bugs, full payment, neutral
- **Poor**: Many bugs, reduced payment, negative effects
- **Terrible**: Major bugs, minimal payment, time bombs
- **Disaster**: Guaranteed problems, minimal payment, immediate consequences

See BALANCE.md for exact bug formulas and payment multipliers.

**Tech Debt Multiplier:** Bugs multiply for Tech Debt category

**Time Bomb:** Chance of outage within next few days for poor quality

#### Ship Messages (by quality tier)

**Excellent**
```
"Actually good work. You remember what that feels like."
"Tests pass. Code reviewed. Deployed with confidence."
"This might be the best code you've written in months."
```

**Acceptable**
```
"It works. Probably."
"Good enough for government work (and you work in private sector)."
"Shipped. You'll hear about it if there's a problem."
```

**Poor**
```
"Barely functional MVP. Emphasis on 'barely.'"
"You shipped TODO comments as features."
"This is the kind of code you'd roast in a PR review."
```

**Disaster**
```
"This is just console.log statements and duct tape."
"You didn't even remove the debug endpoints."
"Future you will hate past you for this."
```

---

### 5. Startup System

#### Feature Tree

**Phase 1: MVP (Early Days)**
- Landing page (small user base)
- Basic auth (growing users)
- Core feature (user milestone)

**Phase 2: Growth (Mid-Game)**
- Choose features from:
  - **Dark mode** (users boost, no revenue)
  - **Payments** (revenue stream, no user boost)
  - **Mobile app** (major users, adds bugs)
  - **API** (moderate users, developer appeal)

**Phase 3: Scale (Late Game)**
- Choose strategic direction:
  - **B2B pivot** (revenue multiplier, lose users)
  - **Consumer focus** (user multiplier, revenue boost)
  - **Enterprise** (major revenue, requires sales)
  - **Open source** (massive users, no revenue, reputation)

#### User Growth
Base growth scales with features shipped. Quality of startup work affects growth multiplier. Special events can multiply or reduce growth temporarily.

See BALANCE.md for exact growth formulas.

#### Revenue
Revenue scales with user count and monetization features chosen. Different features contribute different amounts to revenue generation.

See BALANCE.md for exact revenue formulas.

---

### 6. Win/Loss Conditions

#### Victory Conditions (Any)

**Path 1: Pure Grind**
- Save target money amount
- No startup requirement
- Slowest path (longest duration)

**Path 2: Balanced**
- Save partial money + Startup at moderate user count
- Most common path (medium duration)

**Path 3: Hustler**
- Save minimal money + Startup at high users + daily revenue
- Fastest path (shortest duration)
- Highest risk (more likely to get caught)

See BALANCE.md for exact money/user/revenue targets.

#### Loss Conditions (Any)

**Burnout**
- Ducks = 0
- "You quit mid-meeting and never came back."

**Fired**
- Multiple missed deadlines
- OR multiple PIP warnings
- "Your services are no longer required."

**Caught**
- Caught hustling multiple times
- "IT found your side project code on company laptop."

**Golden Handcuffs**
- Complete many tasks at high quality average
- Get promoted to management
- "You became the thing you hated."

**Startup Failed**
- Shipped bad code many times to startup
- Users drop to 0
- "Your side project died of technical debt."

---

### 7. Relationships & Hidden Mechanics

#### Coworker Relationships
Track relationship with 3-4 coworkers:
- **Alice (Senior Dev)** - Can cover for you, teach optimization
- **Bob (Junior Dev)** - Needs help, can be blamed
- **Carol (PM)** - Can extend deadlines, or add scope
- **Dave (QA)** - Can catch bugs, or let them slip

**Relationship Effects:**
```
High relationship (helped multiple times):
- Cover for you when caught hustling
- Offer to pair program (bonus progress)
- Warn you about boss mood

Low relationship (ignored multiple times):
- Report you to boss
- Refuse to help
- Spread gossip (more events)

Betrayed (blamed):
- Hostile events increase
- May sabotage your work
- Will report you if catch hustling
```

#### Hidden Mechanics (Emergent Discovery)

**Combo 1: Quality Reputation**
- Ship excellent quality multiple times → "Clean code reputation"
- Effect: Tech blog writes about you → Startup users boost

**Combo 2: The Grind**
- Work many days straight without hustling
- Effect: Boss offers promotion → Can accept (golden handcuffs) or refuse

**Combo 3: The Saboteur**
- Blame coworkers multiple times
- Effect: Company culture tanks → Everyone quits → Company collapse

**Combo 4: The Ghost**
- Allocate zero ducks to all job tasks for multiple days
- Effect: Boss forgets you exist → Can hustle freely (but no money)

---

## Progression & Balance

### Difficulty Curve

#### Week 1-2: Tutorial / Learning (Early Days)
**Goal:** Learn allocation, understand trade-offs

- **Tasks:** One at a time initially
- **Complexity:** Low
- **Deadlines:** Generous
- **Events:** Few per day, low stakes
- **Bugs:** Start at zero, grow slowly
- **Startup:** Can ignore safely

**Expected behavior:**
- Ship high quality
- Learn event types
- Start allocating to startup mid-phase

---

#### Week 3-4: Juggling / Pressure (Mid-Game)
**Goal:** Force triage, multiple priorities

- **Tasks:** Multiple active
- **Complexity:** Medium
- **Deadlines:** Tighter
- **Events:** Some per day, meaningful stakes
- **Bugs:** Slowing work noticeably
- **Startup:** Must allocate or fall behind

**Expected behavior:**
- Ship medium quality
- Miss some deadlines → Extensions or warnings
- Start making moral compromises (blame coworkers?)

---

#### Week 5-6: Desperation / Chaos (Late Game)
**Goal:** Survival mode, ship bad code or die

- **Tasks:** Many active at once
- **Complexity:** High
- **Deadlines:** Impossible
- **Events:** Many per day, high stakes
- **Bugs:** Work is significantly slowed
- **Startup:** Make or break point

**Expected behavior:**
- Ship poor quality (just to survive)
- Fire fighting (outages, emergencies)
- Near burnout (minimal ducks often)

---

#### Week 7+: Endgame / Resolution
**Goal:** Race to escape or collapse

- **Outcome A:** Startup takes off → Victory within days
- **Outcome B:** Death spiral → Fired/burnout within days
- **Outcome C:** Quit → Player gives up (counts as burnout)

**Fork in road:**
- If startup is thriving, focus shifts
- If job is collapsing, panic mode
- If balanced, nail-biting finish

---

### Balance Targets

See BALANCE.md for all specific values and formulas.

#### Resource Scarcity
**Ducks:**
- Start with buffer
- Gain from excellent ships (rare)
- Lose from poor ships, bad events
- Critical threshold leads to burnout

**Money:**
- Regular salary intervals
- Task payments based on complexity
- Total earning potential across game
- Win target is tight but achievable

**Users:**
- Early: Small gains per day
- Mid: Moderate gains with features
- Late: Large gains with viral growth
- Win targets depend on chosen path

**Bugs:**
- High quality ships: Minimal bugs (manageable)
- Medium quality: Some bugs (mounting)
- Low quality: Many bugs (death spiral)
- Critical threshold doubles work time

#### Time to Victory

See BALANCE.md for target game lengths.

**Speedrun Path:**
- Ignore quality (low % ships)
- High risk (likely to get caught)
- Rush startup features
- Need luck with events

**Balanced Path:**
- Maintain medium quality
- Split attention evenly
- Build relationships (safety net)
- Steady progress

**Grind Path:**
- Maintain high quality
- Ignore startup until late
- Focus on job security
- Slow but safe

---

## Content Specifications

### Required Content Counts

**For Minimum Viable Product:**
- **30-50 events** (distributed across categories)
- **20-30 job tasks** (across 3 categories)
- **10-15 startup features** (MVP → growth → scale)
- **8-10 endings** (victory variants, loss variants)
- **50-100 ship messages** (quality tiers × categories)
- **20-30 event consequence texts**

### Task Content Template
```
Title: [Punchy, specific, recognizable]
Description: [Dry humor, tech-specific, 1-2 sentences]
Category: [Optics/Critical/Tech Debt]
Complexity: [Scale, affects time/payment]
Deadline: [Days, affects pressure]
Payment: [Based on complexity]
Special: [Any unique mechanics]
```

**Example Tasks:**
1. "Make Logo Bigger (Again)" - Optics, moderate complexity, short deadline
2. "Add 'AI' to Every Button Label" - Optics, low complexity, very short deadline
3. "Fix Race Condition in Payments" - Critical, high complexity, short deadline
4. "Migrate to Microservices (CEO Read Article)" - Tech Debt, very high complexity, long deadline
5. "CEO's 'Simple' Excel Macro" - Critical, high complexity, medium deadline

### Event Content Template
```
Title: [Short, punchy]
Description: [Context, stakes, 1-2 sentences]
Trigger: [When this can appear]
Choices: [2-3 options, clear trade-offs]
Consequences: [Mechanical + narrative]
```

**Example Events:**

**Boss Event: Demo Demand**
```
Title: "Boss Wants Demo"
Description: "@boss: 'Can you demo PROJ-1337 in 5 minutes?'"
Trigger: Task partially complete, after early days
Choices:
1. "Demo now" → Ship at current %, boss improves
2. "Need 30 min" → Steal ducks, boss worsens
3. "It's broken" → Deadline extension, boss improves, chance of PIP
```

**Technical Event: Code Review**
```
Title: "Alice Found Security Issue"
Description: "Senior dev Alice reviewed your code: 'This endpoint has no auth.'"
Trigger: Shipped medium quality, mid-game
Choices:
1. "Fix now" → Steal ducks, quality boost, Alice improves
2. "Ship anyway" → Time bomb, Alice major worsens
3. "It's a feature" → Alice laughs, relationship improves, bugs added
```

**Coworker Event: Help Request**
```
Title: "Bob Needs Pair Programming"
Description: "Junior dev Bob: 'I'm stuck on this bug. Can you help for an hour?'"
Trigger: Random, after early days
Choices:
1. "Sure" → Steal ducks, Bob major improves
2. "Not now" → Bob worsens
3. "Here's a Stack Overflow link" → Bob neutral, random outcome
```

---

## UI/UX Design

### Screen Layout (Terminal Aesthetic)

```
╔═══════════════════════════════════════════════════════════╗
║  💰 $X / $Y  🦆⚫⚫⚪  🐛 N  📅 Day Z  💼 Level           ║
╠═══════════════════════════════════════════════════════════╣
║                                                           ║
║  JOB TASKS                         STARTUP               ║
║  ┌─────────────────────────────┐  ┌────────────────────┐ ║
║  │[CRITICAL] PROJ-1337         │  │🚀 MY INDIE APP     │ ║
║  │Make Logo Bigger (Again)     │  │                    │ ║
║  │                             │  │👥 N users          │ ║
║  │🦆🦆🦆 [ ] [ ] [ ] [ ] [ ]    │  │💵 $N revenue       │ ║
║  │▓▓▓▓░░░░░░ X%                │  │                    │ ║
║  │⏰ N days                     │  │Next: [Choose]      │ ║
║  └─────────────────────────────┘  │→ Feature A         │ ║
║                                    │→ Feature B         │ ║
║  ┌─────────────────────────────┐  └────────────────────┘ ║
║  │[TECH DEBT] PROJ-1338        │                         ║
║  │Migrate Auth to OAuth        │                         ║
║  │                             │                         ║
║  │🦆🦆 [ ] [ ] [ ] [ ] [ ] [ ]  │                         ║
║  │▓░░░░░░░░░ Y%                │                         ║
║  │⏰ N days                     │                         ║
║  └─────────────────────────────┘                         ║
║                                                           ║
║  [ALLOCATE DUCKS] [START DAY]                            ║
║                                                           ║
╚═══════════════════════════════════════════════════════════╝
```

### Event Popup (Slack Style)

```
┌─────────────────────────────────────────┐
│ 🔔 #engineering                         │
│ @boss  just now                         │
│                                         │
│ "Quick sync in 5 min about PROJ-1337.  │
│  Can you demo current state?"          │
│                                         │
│ [Show demo now]                         │
│ Ships at X%, boss improves              │
│                                         │
│ [Buy time (N ducks)]                    │
│ "Need 30 min to fix one thing"          │
│                                         │
│ [Be honest]                             │
│ "It's not ready yet"                    │
│ Deadline +1, boss improves, Y% PIP      │
└─────────────────────────────────────────┘
```

### Ship Decision (Git Style)

```
┌─────────────────────────────────────────┐
│ git push origin/production              │
│                                         │
│ PROJ-1337: Make Logo Bigger (Again)     │
│                                         │
│ Files changed: 3                        │
│ Progress: X% ⚠️                         │
│ Tests: N/M passing ❌                   │
│ Code review: Not reviewed ⚠️            │
│                                         │
│ Shipping at X% will add ~Y bugs         │
│                                         │
│ [git push --force] [Keep working]       │
└─────────────────────────────────────────┘
```

### Visual Polish Elements

**Juice (Feel Good):**
- Progress bars animate smoothly
- Duck icons "fly" to tasks on allocation
- Users counter ticks up with particle effects
- Money earned pops with animation
- Bugs "crawl" onto task cards when shipped poorly

**Feedback (Clear Communication):**
- Color coding (green = good, yellow = risky, red = danger)
- Sound effects (Slack notification for events, cha-ching for payment)
- Screen shake on critical events (outages, fired)
- Tooltip previews on hover

**Diegetic Elements (Immersion):**
- Task cards look like Jira
- Events look like Slack
- Ship UI looks like git
- Metrics look like corporate dashboards

---

## Technical Architecture

### Reusable from V1

**Keep (60% of codebase):**
- ✅ GameManager (signal-driven state)
- ✅ TaskManager (JSON loading)
- ✅ Data systems (tasks.json, endings.json format)
- ✅ UI components (TopBar, dialogs, panels)
- ✅ Bug/outage/PIP systems
- ✅ Payday system
- ✅ End game panel

**Modify:**
- 🔄 Core loop (allocation instead of WORK/HUSTLE/SHIP buttons)
- 🔄 Task display (multiple tasks visible, not single)
- 🔄 Startup system (feature tree, not simple progress bar)

**Build New:**
- ✅ Event system (JSON-driven, popup UI)
- ✅ Allocation UI (ducks, drag or click)
- ✅ Ship decision UI (per-task dialogs)
- ✅ Relationship tracking (coworker states)

### Data File Structure

```
data/
├── tasks.json          # Job tasks (title, category, complexity)
├── events.json         # Random events (triggers, choices)
├── startup_features.json  # Startup feature tree
├── endings.json        # Win/loss endings
├── ship_messages.json  # Quality-based messages
└── coworkers.json      # NPC data (names, personalities)
```

### Signal Architecture (Keep from V1)

**GameManager emits:**
- `money_changed(amount)`
- `ducks_changed(amount)`
- `bugs_changed(amount)`
- `tasks_changed(task_list)`
- `event_occurred(event_data)`
- `day_started()`
- `day_ended()`

**UI Components listen:**
- TopBar listens to money/ducks/bugs
- TaskPanel listens to tasks_changed
- EventPopup listens to event_occurred

**Pattern:** Never update UI directly, always emit signals

---

## Development Roadmap

### Phase 1: Prototype Core Loop (Week 1)

**Goal:** Playable allocation → simulation → ship cycle

**Tasks:**
1. Allocation UI (ducks, click to assign)
2. Day simulation (calculate progress, no events yet)
3. Ship decision (basic dialog)
4. Multiple tasks visible (task cards)
5. Basic startup progress bar

**Milestone:** Can play one "day" and see results

---

### Phase 2: Add Events (Week 2)

**Goal:** Events interrupt and create texture

**Tasks:**
1. Event system (JSON loading)
2. Event popup UI (Slack style)
3. Event triggering (random, condition-based)
4. Event consequences (steal ducks, change states)
5. Create starter events

**Milestone:** Events make days feel different

---

### Phase 3: Startup Features (Week 3)

**Goal:** Startup side has depth

**Tasks:**
1. Feature tree UI (choose next feature)
2. User growth system (formula-driven)
3. Revenue tracking (monetization features)
4. Startup events (user feedback, competitors)
5. Victory condition (users + money)

**Milestone:** Can win via startup path

---

### Phase 4: Juice & Polish (Week 4)

**Goal:** Game feels good to play

**Tasks:**
1. Progress bar animations
2. Duck allocation animations (icons fly to tasks)
3. Sound effects (Slack notification, cha-ching, etc.)
4. Particle effects (users spike, money earned)
5. Screen shake (critical events)

**Milestone:** Actions feel satisfying

---

### Phase 5: Content & Balance (Week 5-6)

**Goal:** Enough content for replayability

**Tasks:**
1. Expand events to target count
2. Create full task library
3. Write all endings
4. Balance tuning (playtesting)
5. Hidden mechanics (coworker relationships)

**Milestone:** Game is replayable and balanced

---

### Post-Launch (If Successful)

**Content Updates:**
- More events (seasonal, community-submitted)
- More endings (community favorites)
- Achievements (Steam)

**Act 2 (Major Update):**
- You become the boss (startup succeeded)
- Hire employees (former coworkers)
- Consequences of Act 1 choices
- New ending types

---

## Appendix: Inspiration Games

### Papers Please (Mechanics)
- **Borrow:** Inspection tension → Ship decision tension
- **Borrow:** Time pressure → Deadline pressure
- **Borrow:** Moral choices → Blame/help coworkers
- **Don't:** Repetitive inspection (we have variety via events)

### Universal Paperclips (Progression)
- **Borrow:** Layered complexity (gradual system unlocks)
- **Borrow:** Clear next goals (always know what's next)
- **Borrow:** Emergent narrative (become the villain)
- **Don't:** Passive/idle gameplay (we're active)

### FTL (Structure)
- **Borrow:** Plan → Execute → React loop
- **Borrow:** Resource scarcity (never enough for everything)
- **Borrow:** Permanent consequences (dead is dead)
- **Don't:** Real-time combat (we're turn-based)

### Reigns (Events)
- **Borrow:** Card-based choices
- **Borrow:** Branching consequences
- **Borrow:** Relationship tracking
- **Don't:** Random death (we have clear lose conditions)

---

## Success Metrics

**Core Loop Test:**
- Can player understand allocation quickly?
- Do players agonize over ship decisions?
- Do events create memorable moments?

**Engagement Test:**
- Does "one more day" pull kick in?
- Do players replay for different endings?
- Do players share their worst moments?

**Theme Test:**
- Do devs say "this is my job"?
- Does UI feel authentic (not generic)?
- Is the satire landing (funny not mean)?

---

**End of GDD v2.0**

*For exact numbers and balance values, see [BALANCE.md](BALANCE.md)*
*For implementation details, see [reference/implementation-status.md](reference/implementation-status.md)*
*For V1 archive, see [archive/v1/](archive/v1/)*
