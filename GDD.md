# Alt+F+This - Game Design Document (V2)

**Version:** 2.0
**Last Updated:** 2025-11-02
**Status:** Pre-production

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

### Day Structure (60-90 seconds)

```
┌─────────────────────────────────────┐
│ 1. MORNING - ALLOCATION (15 sec)   │
│    Look at tasks, plan duck split  │
│    Job Task A: 3 ducks              │
│    Job Task B: 2 ducks              │
│    Startup: 3 ducks                 │
└─────────────────────────────────────┘
                ↓
┌─────────────────────────────────────┐
│ 2. DAY SIMULATION (30-45 sec)      │
│    Events interrupt, force choices  │
│    - Boss wants demo (2 ducks)      │
│    - Outage! (3 ducks or users)     │
│    - Coworker needs help (1 duck)   │
└─────────────────────────────────────┘
                ↓
┌─────────────────────────────────────┐
│ 3. RESULTS (10 sec)                 │
│    See progress on all tasks        │
│    Task A: 60% → 75%                │
│    Task B: 20% → 35%                │
│    Startup: +50 users               │
└─────────────────────────────────────┘
                ↓
┌─────────────────────────────────────┐
│ 4. SHIP DECISIONS (15-30 sec)      │
│    For each ready task:             │
│    - Ship at 75%? (bugs)            │
│    - Wait? (deadline risk)          │
└─────────────────────────────────────┘
                ↓
┌─────────────────────────────────────┐
│ 5. CONSEQUENCES (5-10 sec)         │
│    Bugs added, payment earned       │
│    New tasks appear, events trigger │
└─────────────────────────────────────┘
                ↓
           NEXT DAY
```

### Engagement Points Per Day
- **3-5 active decisions** (allocation, events, ship)
- **10-20 seconds thinking** (strategic planning)
- **40-70 seconds seeing results** (feedback)

---

## Game Systems

### 1. Duck Allocation System

**Concept:** "Ducks" = hours/energy/focus (8 per day)

#### Allocation Rules
- **8 ducks available each morning**
- **Minimum 1 duck per task** (if allocating)
- **Can allocate 0** (ignore task entirely)
- **Locked once day starts** (events may steal ducks)

#### Duck Costs by Task Category
| Category | Base Cost | Complexity Multiplier | Example |
|----------|-----------|----------------------|---------|
| Optics | Low | 0.8x | 2-duck task → 60% progress |
| Tech Debt | High | 1.5x | 3-duck task → 30% progress |
| Critical | Medium | 1.0x | 3-duck task → 45% progress |

**Formula:**
```
Progress = (ducks_allocated × 15%) / (complexity_multiplier × bug_multiplier)
bug_multiplier = 1 + (bugs × 0.01)
```

**Example:**
- Task complexity: Tech Debt (1.5x)
- Bugs: 20 (1.2x multiplier)
- Ducks allocated: 3
- Progress: (3 × 15%) / (1.5 × 1.2) = 45% / 1.8 = 25%

#### Startup Duck Efficiency
- **Startup tasks are more efficient early game**
- No complexity penalties (you control the scope)
- No bug accumulation (your own code)
- But: Interrupted more often (need to hide from boss)

**Formula:**
```
Startup Progress = ducks_allocated × 12%
User Gain = progress × 10 × (1 + features_shipped)
```

---

### 2. Event System

**Concept:** Random interruptions force reactive decisions

#### Event Frequency
| Game Phase | Events/Day | Types |
|------------|------------|-------|
| Week 1-2 | 1-2 | Low stakes (help coworker, meeting) |
| Week 3-4 | 2-3 | Medium stakes (demo, code review) |
| Week 5+ | 3-5 | High stakes (outage, caught hustling) |

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
      "text": "Need 30 min (cost: 2 ducks from today)",
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

**1. Boss Events (30%)**
- Demo requests
- Meeting interruptions
- Scope changes
- Performance reviews

**2. Technical Events (30%)**
- Production outages
- Code review findings
- Bug reports
- Security issues

**3. Coworker Events (20%)**
- Help requests
- Pair programming
- Blame opportunities
- Gossip/drama

**4. Startup Events (15%)**
- User feedback
- Competitor launches
- Award opportunities
- Press inquiries

**5. Meta Events (5%)**
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
- Low technical complexity (0.8x multiplier)
- High political risk (CEO might love OR hate it)
- Short deadlines (boss wants it NOW)
- Random outcomes (not skill-based)

**Examples:**
- Make logo bigger
- Change button color to match CEO's shirt
- Add "AI" to product description

**Tech Debt (Long-term Consequences)**
- High complexity (1.5x multiplier)
- Bugs multiply if shipped early (3x bug penalty)
- Long deadlines (can't rush this)
- Compounds over time

**Examples:**
- Migrate to new framework
- Refactor authentication system
- Fix race condition in payments

**Critical (Immediate Stakes)**
- Medium complexity (1.0x multiplier)
- High urgency (production is down)
- Ship below 80% → guaranteed outage next day
- Customer-facing consequences

**Examples:**
- Fix payment processing bug
- Resolve data breach
- Restore backup after outage

---

### 4. Ship Decision System

#### Ship Trigger Conditions
Task becomes "shippable" when:
1. **Progress ≥ 60%** (minimum viable)
2. **Deadline ≤ 1 day** (forced decision)
3. **Event forces ship** (boss demands it)

#### Ship Consequences by Quality

| Quality | Bugs Added | Payment | Duck Change | Special |
|---------|------------|---------|-------------|---------|
| 90-100% | 0 | 100% | +1 duck | "Clean code token" |
| 80-89% | 1-2 | 100% | 0 | - |
| 70-79% | 2-4 | 100% | 0 | - |
| 60-69% | 4-6 | 100% | -1 duck | - |
| 50-59% | 6-10 | 80% | -1 duck | Time bomb |
| 40-49% | 10-15 | 60% | -2 ducks | Time bomb |
| <40% | 15-25 | 40% | -2 ducks | Guaranteed outage |

**Tech Debt Multiplier:** Bugs × 3 for Tech Debt category

**Time Bomb:** 50% chance of outage within next 3 days

#### Ship Messages (by quality tier)

**90-100% (Excellent)**
```
"Actually good work. You remember what that feels like."
"Tests pass. Code reviewed. Deployed with confidence."
"This might be the best code you've written in months."
```

**70-79% (Acceptable)**
```
"It works. Probably."
"Good enough for government work (and you work in private sector)."
"Shipped. You'll hear about it if there's a problem."
```

**50-59% (Poor)**
```
"Barely functional MVP. Emphasis on 'barely.'"
"You shipped TODO comments as features."
"This is the kind of code you'd roast in a PR review."
```

**<40% (Disaster)**
```
"This is just console.log statements and duct tape."
"You didn't even remove the debug endpoints."
"Future you will hate past you for this."
```

---

### 5. Startup System

#### Feature Tree

**Phase 1: MVP (Days 1-10)**
- Landing page (100 users)
- Basic auth (200 users)
- Core feature (500 users)

**Phase 2: Growth (Days 11-20)**
- Choose 2 of:
  - **Dark mode** (users +50%, no revenue)
  - **Payments** (revenue +$50/day, users +0%)
  - **Mobile app** (users +100%, bugs +5)
  - **API** (users +30%, developer appeal)

**Phase 3: Scale (Days 21+)**
- Choose 1 of:
  - **B2B pivot** (revenue ×3, lose 50% users)
  - **Consumer focus** (users ×2, revenue +20%)
  - **Enterprise** (revenue ×5, requires sales)
  - **Open source** (users ×10, revenue →$0, reputation)

#### User Growth Formula
```
base_growth = 10 × (1 + features_shipped)
daily_users = base_growth × quality_multiplier × event_multiplier

quality_multiplier:
- Ship 90%+: 1.5x
- Ship 70-89%: 1.0x
- Ship <70%: 0.5x (users churn)

event_multiplier:
- Normal: 1.0x
- Press/Award: 2-5x
- Competitor launch: 0.5x
```

#### Revenue Formula
```
revenue_per_day = users × 0.01 × monetization_features

monetization_features:
- Payments: 1 point
- B2B: 3 points
- Enterprise: 5 points
- Ads: 0.5 points
```

---

### 6. Win/Loss Conditions

#### Victory Conditions (Any)

**Path 1: Pure Grind**
- Save $5,000
- No startup requirement
- Slowest path (40-50 days)

**Path 2: Balanced**
- Save $3,000 + Startup at 1000 users
- Most common path (30-40 days)

**Path 3: Hustler**
- Save $2,000 + Startup at 5000 users + $100/day revenue
- Fastest path (25-35 days)
- Highest risk (more likely to get caught)

#### Loss Conditions (Any)

**Burnout**
- Ducks = 0
- "You quit mid-meeting and never came back."

**Fired**
- 3 missed deadlines
- OR 3 PIP warnings
- "Your services are no longer required."

**Caught**
- Caught hustling 3 times
- "IT found your side project code on company laptop."

**Golden Handcuffs**
- Complete 15 tasks + High quality average
- Get promoted to management
- "You became the thing you hated."

**Startup Failed**
- Shipped bad code 5 times to startup
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
High relationship (helped 3+ times):
- Cover for you when caught hustling
- Offer to pair program (bonus progress)
- Warn you about boss mood

Low relationship (ignored 3+ times):
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
- Ship 90%+ quality 5 times → "Clean code reputation"
- Effect: Tech blog writes about you → Startup users +500

**Combo 2: The Grind**
- Work 10 days straight without hustling
- Effect: Boss offers promotion → Can accept (golden handcuffs) or refuse

**Combo 3: The Saboteur**
- Blame coworkers 3+ times
- Effect: Company culture tanks → Everyone quits → Company collapse

**Combo 4: The Ghost**
- Allocate 0 ducks to all job tasks for 3 days
- Effect: Boss forgets you exist → Can hustle freely (but no money)

---

## Progression & Balance

### Difficulty Curve

#### Week 1-2: Tutorial / Learning (Days 1-10)
**Goal:** Learn allocation, understand trade-offs

- **Tasks:** 1-2 active at once
- **Complexity:** Low (2-4)
- **Deadlines:** Generous (5-7 days)
- **Events:** 1-2 per day, low stakes
- **Bugs:** Start at 0, grow slowly
- **Startup:** Can ignore safely

**Expected behavior:**
- Ship 80-90% quality
- Learn event types
- Start allocating to startup (days 5-7)

---

#### Week 3-4: Juggling / Pressure (Days 11-20)
**Goal:** Force triage, multiple priorities

- **Tasks:** 2-3 active at once
- **Complexity:** Medium (4-6)
- **Deadlines:** Tighter (3-5 days)
- **Events:** 2-3 per day, meaningful stakes
- **Bugs:** 10-30 (slowing work)
- **Startup:** Must allocate or fall behind

**Expected behavior:**
- Ship 60-70% quality
- Miss some deadlines → Extensions or warnings
- Start making moral compromises (blame coworkers?)

---

#### Week 5-6: Desperation / Chaos (Days 21-30)
**Goal:** Survival mode, ship bad code or die

- **Tasks:** 3-4 active at once
- **Complexity:** High (6-8)
- **Deadlines:** Impossible (2-3 days)
- **Events:** 3-5 per day, high stakes
- **Bugs:** 30-60 (work is slow)
- **Startup:** Make or break point

**Expected behavior:**
- Ship 40-50% quality (just to survive)
- Fire fighting (outages, emergencies)
- Near burnout (1-2 ducks often)

---

#### Week 7+: Endgame / Resolution (Days 31+)
**Goal:** Race to escape or collapse

- **Outcome A:** Startup takes off → Victory within 5 days
- **Outcome B:** Death spiral → Fired/burnout within 5 days
- **Outcome C:** Quit → Player gives up (counts as burnout)

**Fork in road:**
- If startup is thriving (1000+ users), focus shifts
- If job is collapsing (2 warnings, 50+ bugs), panic mode
- If balanced, nail-biting finish

---

### Balance Targets

#### Resource Scarcity
```
Ducks:
- Start: 3 (buffer for bad ships)
- Gain: +1 for 90%+ ships (rare)
- Lose: -1 for poor ships, bad events
- Critical threshold: 1 (one mistake from burnout)

Money:
- Salary: $500 every 5 days
- Task payments: $200-500 (complexity based)
- Total earning potential: ~$6-8K over 40 days
- Target: $5K (tight but achievable)

Users:
- Early: +10-50 per day (if allocating)
- Mid: +50-200 per day (with features)
- Late: +200-1000 per day (viral growth)
- Target: 1000-5000 users (depends on path)

Bugs:
- Ship quality 80%+: +1-2 bugs (manageable)
- Ship quality 50-70%: +4-10 bugs (mounting)
- Ship quality <50%: +15+ bugs (death spiral)
- Critical threshold: 50 bugs (work takes 2x time)
```

#### Time to Victory (Target: 30-40 days average)

**Speedrun Path (25-30 days):**
- Ignore quality (40-50% ships)
- High risk (likely to get caught)
- Rush startup features
- Need luck with events

**Balanced Path (30-40 days):**
- Maintain 60-70% quality
- Split attention evenly
- Build relationships (safety net)
- Steady progress

**Grind Path (40-50 days):**
- Maintain 80%+ quality
- Ignore startup until late
- Focus on job security
- Slow but safe

---

### Formulas Reference

#### Work Speed
```
daily_progress = (ducks × 15%) / (category_mult × bug_mult)

category_mult:
- Optics: 0.8
- Critical: 1.0
- Tech Debt: 1.5

bug_mult = 1 + (bugs × 0.01)
- 0 bugs: 1.0x (normal)
- 20 bugs: 1.2x (20% slower)
- 50 bugs: 1.5x (50% slower)
- 100 bugs: 2.0x (impossible, game over)
```

#### Bug Accumulation
```
bugs_added = (100 - quality) / 10 × category_mult

Examples:
- 90% quality, Optics: (100-90)/10 × 0.8 = 0.8 bugs
- 70% quality, Critical: (100-70)/10 × 1.0 = 3 bugs
- 50% quality, Tech Debt: (100-50)/10 × 1.5 = 7.5 bugs
```

#### Payment
```
base_payment = complexity × 50
payment_received = base_payment × quality_mult

quality_mult:
- 80%+: 1.0 (full payment)
- 60-79%: 1.0 (full payment, dock pay comes later as bugs)
- 40-59%: 0.8 (partial payment)
- <40%: 0.6 (minimal payment)
```

---

## Content Specifications

### Required Content Counts

**For Minimum Viable Product:**
- **30-50 events** (10 boss, 10 technical, 10 coworker, 5 startup, 5 meta)
- **20-30 job tasks** (across 3 categories)
- **10-15 startup features** (MVP → growth → scale)
- **8-10 endings** (4 victory variants, 6 loss variants)
- **50-100 ship messages** (quality tiers × categories)
- **20-30 event consequence texts**

### Task Content Template
```
Title: [Punchy, specific, recognizable]
Description: [Dry humor, tech-specific, 1-2 sentences]
Category: [Optics/Critical/Tech Debt]
Complexity: [1-10, affects time/payment]
Deadline: [3-7 days, affects pressure]
Payment: [complexity × $50]
Special: [Any unique mechanics]
```

**Example Tasks:**
1. "Make Logo Bigger (Again)" - Optics, 3, 4 days, $150
2. "Add 'AI' to Every Button Label" - Optics, 2, 3 days, $100
3. "Fix Race Condition in Payments" - Critical, 7, 3 days, $350
4. "Migrate to Microservices (CEO Read Article)" - Tech Debt, 9, 7 days, $450
5. "CEO's 'Simple' Excel Macro" - Critical, 8, 4 days, $400

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
Trigger: Task 30-80% complete, day 5+
Choices:
1. "Demo now" → Ship at current %, boss +1
2. "Need 30 min" → Steal 2 ducks, boss -1
3. "It's broken" → Deadline +1 day, boss +2, 30% chance PIP
```

**Technical Event: Code Review**
```
Title: "Alice Found Security Issue"
Description: "Senior dev Alice reviewed your code: 'This endpoint has no auth.'"
Trigger: Shipped 50-70% quality, day 10+
Choices:
1. "Fix now" → Steal 2 ducks, quality +10%, Alice +1
2. "Ship anyway" → Time bomb, Alice -2
3. "It's a feature" → Alice laughs, relationship +1, bugs +5
```

**Coworker Event: Help Request**
```
Title: "Bob Needs Pair Programming"
Description: "Junior dev Bob: 'I'm stuck on this bug. Can you help for an hour?'"
Trigger: Random, day 3+
Choices:
1. "Sure" → Steal 1 duck, Bob +2
2. "Not now" → Bob -1
3. "Here's a Stack Overflow link" → Bob neutral, 50% he figures it out
```

---

## UI/UX Design

### Screen Layout (Terminal Aesthetic)

```
╔═══════════════════════════════════════════════════════════╗
║  💰 $2,450 / $5K  🦆⚫⚫⚪  🐛 23  📅 Day 18  💼 Mid-Level  ║
╠═══════════════════════════════════════════════════════════╣
║                                                           ║
║  JOB TASKS                         STARTUP               ║
║  ┌─────────────────────────────┐  ┌────────────────────┐ ║
║  │[CRITICAL] PROJ-1337         │  │🚀 MY INDIE APP     │ ║
║  │Make Logo Bigger (Again)     │  │                    │ ║
║  │                             │  │👥 342 users        │ ║
║  │🦆🦆🦆 [ ] [ ] [ ] [ ] [ ]    │  │💵 $12 revenue      │ ║
║  │▓▓▓▓░░░░░░ 60%              │  │                    │ ║
║  │⏰ 2 days                    │  │Next: [Choose]      │ ║
║  └─────────────────────────────┘  │→ Dark Mode         │ ║
║                                    │→ Payments          │ ║
║  ┌─────────────────────────────┐  └────────────────────┘ ║
║  │[TECH DEBT] PROJ-1338        │                         ║
║  │Migrate Auth to OAuth        │                         ║
║  │                             │                         ║
║  │🦆🦆 [ ] [ ] [ ] [ ] [ ] [ ]  │                         ║
║  │▓░░░░░░░░░ 20%               │                         ║
║  │⏰ 5 days                     │                         ║
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
│ Ships at 60%, boss +1                   │
│                                         │
│ [Buy time (2 ducks)]                    │
│ "Need 30 min to fix one thing"          │
│                                         │
│ [Be honest]                             │
│ "It's not ready yet"                    │
│ Deadline +1, boss +2, 30% chance PIP    │
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
│ Progress: 75% ⚠️                        │
│ Tests: 15/20 passing ❌                 │
│ Code review: Not reviewed ⚠️            │
│                                         │
│ Shipping at 75% will add ~2-4 bugs      │
│                                         │
│ [git push --force] [Keep working]       │
└─────────────────────────────────────────┘
```

### Visual Polish Elements

**Juice (Feel Good):**
- Progress bars animate smoothly
- Duck icons "fly" to tasks on allocation
- Users counter ticks up with particle effects
- Money earned pops with $$ animation
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
- ✅ Allocation UI (8 ducks, drag or click)
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

### Phase 1: Prototype Core Loop (Week 1, ~5 days)

**Goal:** Playable allocation → simulation → ship cycle

**Tasks:**
1. Allocation UI (8 ducks, click to assign)
2. Day simulation (calculate progress, no events yet)
3. Ship decision (basic dialog)
4. Multiple tasks visible (2-3 cards)
5. Basic startup progress bar

**Milestone:** Can play one "day" and see results

---

### Phase 2: Add Events (Week 2, ~5 days)

**Goal:** Events interrupt and create texture

**Tasks:**
1. Event system (JSON loading)
2. Event popup UI (Slack style)
3. Event triggering (random, condition-based)
4. Event consequences (steal ducks, change states)
5. Create 15 starter events

**Milestone:** Events make days feel different

---

### Phase 3: Startup Features (Week 3, ~5 days)

**Goal:** Startup side has depth

**Tasks:**
1. Feature tree UI (choose next feature)
2. User growth system (formula-driven)
3. Revenue tracking (monetization features)
4. Startup events (user feedback, competitors)
5. Victory condition (users + money)

**Milestone:** Can win via startup path

---

### Phase 4: Juice & Polish (Week 4, ~5 days)

**Goal:** Game feels good to play

**Tasks:**
1. Progress bar animations
2. Duck allocation animations (icons fly to tasks)
3. Sound effects (Slack notification, cha-ching, etc.)
4. Particle effects (users spike, money earned)
5. Screen shake (critical events)

**Milestone:** Actions feel satisfying

---

### Phase 5: Content & Balance (Week 5-6, ~10 days)

**Goal:** Enough content for replayability

**Tasks:**
1. Expand to 30-50 events
2. Create 20-30 job tasks
3. Write 8-10 endings
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
- Can player understand allocation in <30 seconds?
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

*For implementation details, see [reference/implementation-status.md](reference/implementation-status.md)*
*For V1 archive, see [archive/v1/](archive/v1/)*
