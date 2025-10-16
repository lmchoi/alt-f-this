# Alt+F+This: Game Plan
**"Papers Please meets Office Space with duck-based emotional damage"**

---

## Vision Statement

A darkly comedic inspection/management game where you're a tech worker trapped in corporate hell. Every work ticket is a moral dilemma. Every shortcut creates future pain. Every duck lost is a piece of your soul. Escape with $5K before you run out of ducks to give.

---

## Core Pillars

1. **Inspection Gameplay** (Papers Please)
   - Examine work tickets against your resources
   - Check deadline vs complexity vs your current state
   - Make deliberate decisions with incomplete information

2. **Dark Corporate Satire** (Office Space)
   - Absurd tasks ("Add blockchain to todo app")
   - TPS report energy, Lumbergh-style management
   - Comedic breaking points ("PC LOAD LETTER" moments)

3. **Emotional Resource Management** (Duck Economy)
   - Ducks = patience/sanity/fucks-to-give
   - Every compromise costs ducks
   - Running out = existential burnout

4. **Consequence Cascades**
   - Rushed work creates bugs
   - Bugs slow future work
   - Financial penalties force more rushing
   - Death spiral mechanics

---

## Act 1: Corporate Prison (MVP Scope)

### Goal
Save $5,000 to escape to Act 2 (or burn out trying)

### Core Loop
```
1. Work ticket arrives (task from JSON)
   ↓
2. Inspect ticket (Papers Please desk view)
   - Check deadline vs complexity
   - Check your stats (money, ducks, bugs)
   - Check company rulebook (updates weekly)
   ↓
3. Make decision (stamp mechanic)
   - [ACCEPT] Standard work
   - [NEGOTIATE] Extension/help (costs resources)
   - [RUSH] Ship incomplete (gains bugs)
   - [REFUSE] Skip task (reputation hit)
   ↓
4. Work phase (actions per day)
   - Work: +progress, +money
   - Hustle: +money, no progress, -duck
   - Debug: -bugs, no progress, no money
   - Rest: +ducks, lose time
   ↓
5. Consequences unfold
   - Task complete or deadline missed
   - Events trigger (random or consequence-based)
   - Stats update, day advances
   ↓
6. Return to step 1 with compounding pressure
```

---

## Key Systems

### 1. Ticket Inspection (Papers Please Mechanic)

**UI Layout:**
```
┌─────────────────────────────────────────────┐
│ DAY 13  |  $2,400/$5K  |  🦆🦆 (2)  | 🐛 40 │
├─────────────────────────────────────────────┤
│                                             │
│  ┌──────────────┐      ┌─────────────────┐ │
│  │ WORK TICKET  │      │   YOUR DESK     │ │
│  │              │      │                 │ │
│  │ #1247        │      │ 📅 CALENDAR     │ │
│  │ URGENT       │      │  Today: Day 13  │ │
│  │              │      │  Payday: Day 15 │ │
│  │ "Add         │      │  Deadline: Day  │ │
│  │ blockchain   │      │           15    │ │
│  │ to todo app" │      │                 │ │
│  │              │      │ 📖 RULEBOOK     │ │
│  │ Due: Day 15  │      │  (Check rules)  │ │
│  │ (2 days!)    │      │                 │ │
│  │              │      │ 📧 INBOX (3)    │ │
│  │ Complexity:  │      │  CEO demands... │ │
│  │ ████████░░   │      │  Coworker asks  │ │
│  │ (8/10)       │      │  HR warning...  │ │
│  │              │      │                 │ │
│  │ Est: 5 days  │      │ 💰 PAYCHECK     │ │
│  │ Pay: $500    │      │  $100/day       │ │
│  └──────────────┘      │  (salary info)  │ │
│                        └─────────────────┘ │
│  [STAMP: ACCEPT]                           │
│  [STAMP: NEGOTIATE]                        │
│  [STAMP: RUSH JOB]                         │
│  [STAMP: REFUSE]                           │
│                                             │
│ >> Math: 2 days × (8 complexity × 1.4 bug  │
│    slowdown) = IMPOSSIBLE without help     │
└─────────────────────────────────────────────┘
```

**Player Must Check:**
- Current day vs deadline (time pressure)
- Task complexity vs bugs multiplier (can I finish in time?)
- Payment vs current money (am I close to escape?)
- Rulebook (are CEO tasks mandatory this week?)
- Inbox (context clues about consequences)

**This creates Papers Please "did I miss something?" tension**

---

### 2. Stamp Decisions (Meaningful Choices)

#### **[ACCEPT]** - Standard path
- Work task normally
- Subject to all rules and deadlines
- Safest but slowest

#### **[NEGOTIATE]** - Ask for help
Opens submenu:
- **Extension:** +3 days, costs $100, -1 duck (begging is humiliating)
- **Get Help:** Reduce complexity 50%, owe coworker favor
- **Reduce Scope:** Easier task, pays 50% less
- **Overtime:** +40% instant progress, -2 ducks, skip next payday

#### **[RUSH JOB]** - Ship incomplete
- Complete task immediately (50-80% progress counts)
- Add bugs: `(100 - progress) / 10` bug points
- Immediate payment but...
- Time bomb: Production outage in 2-5 days
- -2 ducks (guilt about quality)

#### **[REFUSE]** - Skip task
- Get new easier task
- Penalties: -$200, -1 duck, +1 strike
- 3 strikes = fired (game over)
- Only viable when desperate

---

### 3. Work Phase Actions

After accepting ticket, each day you choose:

**WORK** (primary action)
- Progress += `20 / (complexity * bug_multiplier)`
- Money += salary
- Small event chance (30%)
- Standard advancement

**HUSTLE** (money focus)
- Progress += 0 (no work done)
- Money += salary × 2
- -1 duck (stress of side hustle)
- Higher event chance (50% - you're distracted)

**DEBUG** (maintenance)
- Progress += 0
- Money += 0
- Bugs -= 15
- Necessary to unfuck past mistakes

**REST** (recovery)
- Progress += 0
- Money += 0
- +1 duck (recover sanity)
- Rare - only when desperate

---

### 4. The Bugs System (Cascading Consequences)

**How Bugs Accumulate:**
```gdscript
# When shipping incomplete task
var bugs_added = (100 - progress) / 10
# Ship at 50%? +5 bugs
# Ship at 80%? +2 bugs
```

**How Bugs Hurt You:**
```gdscript
# Bugs slow ALL future work
var bug_multiplier = 1 + (bugs / 100)
# 40 bugs = 1.4x slower (40% penalty)
# 80 bugs = 1.8x slower (80% penalty)

var progress_gain = 20 / (complexity * bug_multiplier)
```

**The Death Spiral:**
1. Rush task to meet deadline → +20 bugs
2. Bugs slow next task by 20%
3. Can't meet next deadline naturally
4. Must rush again → +25 bugs
5. Now 45 bugs = 45% slower
6. Eventually impossible to complete anything

**The Only Way Out:**
- Spend days debugging (no money, no progress)
- But you need money to escape...
- Tension!

---

### 5. Production Outage Events (The Bomb Explodes)

**Trigger:** 2-5 days after shipping buggy code

```gdscript
var time_bombs := []

func rush_ship_task(progress: int):
    var severity = (100 - progress) / 10
    time_bombs.append({
        "trigger_day": day + randi_range(2, 5),
        "severity": severity,
        "task_name": current_task.title
    })
```

**When It Explodes:**
```
🚨 PRODUCTION OUTAGE 🚨

"Your '{task_name}' feature crashed the payment system."

Consequences:
- Salary penalty: -$200 to -$500
- Emergency fix task (blocks other work, no pay)
- +20 bugs (emergency patches break things)
- +1 strike toward firing
- PIP if 2+ outages

[EMAIL FROM CEO]
"We need to talk about your recent work..."
```

**This is the Papers Please "terrorist exploded" moment**

---

### 6. Stack Ranking Meeting System (Voting Disguised as Work)

**NEW SYSTEM - Key engagement and educational mechanic**

#### **When It Triggers**
- Random chance (10-15%) when advancing to next day
- OR forced event every 7-10 days
- Interrupts normal flow (like real meetings!)

#### **The Meeting Experience**

```
🎭 EMERGENCY ROADMAP MEETING 🎭
"This will only take 15 minutes" (Narrator: It won't)

⏱️ 20 SECOND TIMER

[5 ABSURD TASKS APPEAR]

Drag to rank by priority (or swipe: 👉 high / 👈 low):

☰ 1. "Fix critical security bug"
☰ 2. "Make logo 'pop' more (CEO's 47th revision)"
☰ 3. "Add blockchain to login button"
☰ 4. "Refactor code you rushed last week"
☰ 5. "Emergency: CEO saw competitor's feature"

[Submit Ranking]
```

**Each task card shows:**
- Title (absurdist)
- Complexity (1-10)
- Brief description
- Category tag
- "📖 Based on real story" (for authenticity)

#### **The Punchline**

```
Your ranking:
1. Fix security bug
2. Refactor rushed code
3. Add blockchain
4. CEO competitor panic
5. Make logo pop

[BOSS'S RANKING SLAMS ONTO SCREEN]

ACTUAL PRIORITY:
1. Make logo pop (CEO wants it NOW)
2. Add blockchain (board meeting tomorrow)
3. CEO competitor panic (strategic!)
4. ??? (Boss forgot)
5. ??? (Boss forgot)

"Great collaboration! We're doing ALL 6 by Friday."
"Wait, there's only 5—"
"Oh right, and migrate the database. Forgot to mention."

[Your duck physically deflates on screen]
🦆 → 🐥

-2 ducks (pointless meeting)
-1 hour (lost time)
+6 tasks (somehow gained work)
```

#### **Post-Ranking Options (Power Fantasy)**

```
[💼 Accept Defeat] Continue with BOSS's priority
[🖕 Pushback] "This is impossible" (-1 duck, boss annoyed, might work)
[🤐 Malicious Compliance] Do EXACTLY what boss said (breaks everything, not your fault)
[📧 Document It] Email recap "confirming priorities" (CYA, might help later)
```

#### **Educational Component**

After meeting, optional tooltip:
```
💡 INDUSTRY DATA

47,283 engineers have ranked similar tasks.

Average ranking for "Make logo pop": 4.7/5 (lowest priority)
Average ranking for "Fix security bug": 1.2/5 (highest priority)

Management overrode sensible rankings in 89% of meetings.

You're not crazy. The system is broken.

[Share this] [Learn more about workplace dynamics]
```

#### **Variations (Keep It Fresh)**

Different meeting types with same mechanics:
- **"Bug Triage"** - Rank by severity
- **"Tech Debt Review"** - Rank by "should we fix this?"
- **"Feature Voting"** - Rank by "customers will actually use this"
- **"Incident Postmortem"** - Rank causes by importance (boss blames wrong things)

#### **Strategic Depth (Optional)**

Make meetings affect your run:

**"Emergency Roadmap Meeting":**
- Your #1 ranked task might become your NEXT task (careful what you rank high!)

**"Bug Triage":**
- If community/good rankings win, global bugs -5
- If bad rankings win, bugs +3

**"Tech Debt Review"** (rare, only if bugs > 50):
- Good outcome: Company allocates debug time, bugs -20
- Bad outcome: Leadership ignores it, bugs +10

---

### 7. Escalating Pressure

#### **Week 1-2 (Days 1-10): Onboarding**
- Simple tasks (complexity 1-3)
- Long deadlines (5-7 days)
- Low bugs
- Learning the systems

#### **Week 3-4 (Days 11-20): Reality Sets In**
- NEW RULE: "All CEO requests are mandatory"
- Medium tasks (complexity 4-6)
- Shorter deadlines (3-5 days)
- Salary increases +$20/week (golden handcuffs forming)
- Past bugs starting to bite

#### **Week 5-6 (Days 21-30): Crisis Mode**
- NEW RULE: "Overtime banned" (but deadlines still tight)
- Hard tasks (complexity 7-9)
- Tight deadlines (2-3 days)
- High bugs if you've been rushing
- Coworker relationships matter
- Moral dilemmas ("fire junior dev or take blame?")

#### **Week 7+ (Days 31+): Breaking Point**
- NEW RULE: "Code reviews mandatory" (+1 day per task)
- Very hard tasks (complexity 8-10)
- Brutal deadlines (1-2 days)
- If you're at 60+ bugs, nearly impossible
- If you're at $4K+, SO CLOSE to freedom
- Desperate choices

---

### 7. Event System

#### **Random Events (30% chance on Work, 50% on Hustle)**

**Flavor Events:**
```javascript
"Boss says 'We're a family'" → -1 duck
"Free pizza! (It's vegan)" → +1 duck
"Coffee machine broken" → -10% progress today
"Mandatory fun team building" → -1 duck, lose half day
```

**Choice Events:**
```javascript
"CEO demands weekend work"
  [Comply] → +$200, -2 ducks, +40% progress
  [Refuse] → -$100, +1 duck (self-respect), CEO anger

"Coworker asks you to cover their mistake"
  [Take Blame] → -1 duck, coworker_loyalty++, reputation--
  [Rat Them Out] → +$50, -2 ducks (guilt), coworker_loyalty--

"Junior dev crying in bathroom - they made a mistake"
  [Help Them] → -$50 (your time), +1 duck (good deed), ally++
  [Ignore] → +0, -1 duck (guilt), no relationship

"Customer data leaked from your rushed code"
  [Take Responsibility] → -3 ducks, -$500, respect++
  [Blame Junior Dev] → -5 ducks (guilt), junior dev FIRED
  [Blame IT] → -2 ducks, +$200, IT sabotages you later
```

#### **Industry Survey Events (Educational Trauma Bonding)**

Occasional event disguised as corporate busywork:

```
📊 ANONYMOUS WORKPLACE SURVEY
(HR promises this is anonymous) (it's not)

Rate your agreement (1-5):

"Our deadlines are realistic"           [1][2][3][4][5]
"I feel heard in planning meetings"     [1][2][3][4][5]
"Management values quality over speed"  [1][2][3][4][5]
"I would recommend this workplace"      [1][2][3][4][5]

[Submit] (It won't change anything)

[RESULTS FROM 47,000 REAL PLAYERS]

"Deadlines are realistic" - Avg: 1.3/5
"Feel heard in meetings" - Avg: 1.8/5
"Quality over speed" - Avg: 1.1/5
"Would recommend workplace" - Avg: 1.4/5

You're not crazy. Everyone feels this.

-1 duck (pointless survey)
+0 to all stats
+100% solidarity
```

#### **Consequence Events (Triggered by past choices)**

```javascript
// If you helped coworker on Day 10
"Day 20: Sarah covers for you in meeting, +40% progress"

// If you blamed junior dev
"Day 25: Junior dev's spouse emails: 'You ruined our lives'"
  → -3 ducks, haunts you forever

// If you helped junior dev
"Day 30: Junior dev returns the favor, debugs 20 bugs for free"

// If you ranked sensibly in stack ranking 3+ times
"Day 35: Boss notices you 'don't get the big picture'"
  → -$100, +1 duck (you stood your ground)
```

---

### 8. Company Rulebook (Papers Please Rules)

**Updates every 5 days via company-wide email**

#### **Day 1 Rules:**
```
1. Complete tasks by deadline or face penalties
2. Maintain code quality standards
3. Report to work daily
```

#### **Day 5 Update:**
```
NEW RULE: All CEO-assigned tasks are mandatory
(Cannot refuse without termination)
```

#### **Day 10 Update:**
```
NEW RULE: Code reviews required for all deployments
(Adds 1 day to every task)
```

#### **Day 15 Update:**
```
NEW RULE: Overtime hours banned per labor law
(Cannot work weekends for progress boost)

CONFLICTING WITH: CEO mandatory tasks with impossible deadlines
```

#### **Day 20 Update:**
```
NEW RULE: Performance Improvement Plan (PIP) for anyone with 2+ outages
- All work requires approval
- Weekly 1-on-1 meetings (-1 duck each)
- 3 strikes = termination
```

**The Papers Please Magic:** Rules contradict each other, forcing impossible choices

---

## Win/Lose Conditions

### **Victory: Escape to Act 2**
- Reach $5,000 in savings
- Quit with dramatic email
- Your stats carry forward (bugs, relationships, reputation)
- Unlock Act 2: Startup Chaos

### **Game Over: Ran Out of Ducks**
```
"You gave your last duck."

You sit at your desk, staring at the screen.
The cursor blinks.
You feel nothing.

You open Slack and type to the CEO: "lol"

[Ending: Nihilist Burnout]
```

### **Game Over: Fired (3 strikes)**
```
"HR would like to see you."

After the meeting, security escorts you out.
You never finished your last commit.

Money earned: $2,847
Ducks remaining: 0
Bugs shipped: 127

[Ending: Terminated]
```

### **Game Over: Golden Handcuffs**
```
"Congratulations! Your salary is now $2,500 every 5 days."

You can't afford to quit anymore.
The stock options vest in 3 years.
You'll never leave.

[Ending: Corporate Drone]
```

---

## MVP Implementation Roadmap

### **Phase 1: Core Loop (Week 1-2)**
- [ ] Ticket inspection UI (simple version)
- [ ] 4 stamp decisions (Accept/Negotiate/Rush/Refuse)
- [ ] Work phase with 4 actions
- [ ] Bugs system (accumulation + slowdown)
- [ ] Task complexity affects progress speed
- [ ] Basic consequences (outages, penalties)

**Deliverable:** Playable loop with meaningful decisions

### **Phase 2: Escalation (Week 3)**
- [ ] Escalating salary (+$20/week)
- [ ] Task difficulty increases over time
- [ ] Deadline lengths decrease
- [ ] Company rulebook system
- [ ] Strike system (3 strikes = fired)

**Deliverable:** Difficulty curve that creates pressure

### **Phase 3: Events & Personality (Week 4)**
- [ ] Enable random events (30% chance)
- [ ] Add 10+ choice events
- [ ] Implement consequence tracking
- [ ] Event callbacks (past choices referenced)
- [ ] Expand event pool to 20+ events

**Deliverable:** Dark humor and moral weight

### **Phase 4: Polish & Juice (Week 5)**
- [ ] Screen shake on duck loss
- [ ] Money/progress animations
- [ ] Sound effects (keyboard, duck quack, cash register)
- [ ] Progress bar color changes
- [ ] Task completion celebration
- [ ] Production outage dramatic popup

**Deliverable:** Feels good to play

### **Phase 5: Balance & Content (Week 6)**
- [ ] Playtest full game (Day 1 → escape)
- [ ] Balance difficulty curve
- [ ] Add more tasks (20+ total)
- [ ] Tune event probabilities
- [ ] Multiple game over endings
- [ ] Victory screen with stats recap

**Deliverable:** Complete Act 1

---

## Success Metrics

**You'll know it's working when:**
- Players agonize over stamp decisions for 10+ seconds
- "One more day" addiction kicks in
- Players scream at production outage popups
- They laugh at events then feel guilty
- They replay to try different moral choices
- Streamers can create content (drama + comedy)

**Target feeling:**
- Papers Please's inspection tension
- Office Space's "did he just say that?" moments
- This War of Mine's moral weight
- Cookie Clicker's "one more click" but with actual decisions

---

## Post-MVP: Act 2 Preview

**Startup Chaos (if escape successful):**
- You're now the founder
- Hire employees (former coworkers appear)
- Now YOU assign impossible deadlines
- Face consequences of Act 1 (people you fired, bugs you shipped)
- Choices: Exploit workers or build ethically?
- New resource: Reputation/User Growth
- Ends in: Unicorn exit, acquihire, bankruptcy, or revolt

**The Hook:** People you wronged in Act 1 show up in Act 2

---

## Art Style & Tone Reference

**Visual:**
- CRT monitor aesthetic (Papers Please border vibes)
- Muted corporate colors (gray, beige, fluorescent white)
- Duck emojis in high contrast
- Retro UI (Windows 95/2000 energy)
- Monospace font for code/tickets

**Audio:**
- Keyboard clacking (satisfying)
- Duck quack (sad trombone when lost)
- Email notification ping
- Cash register "cha-ching"
- Stressed breathing (when ducks low)
- Office ambient noise

**Writing Tone:**
- Dry, deadpan humor
- Specific tech worker references (not generic office)
- Absurdist but grounded (blockchain todo app)
- Dark but not mean-spirited
- Satirical without being preachy

---

## Why This Will Work

### **Papers Please Proved:**
- Inspection gameplay is engaging
- Moral choices with resource trade-offs = compelling
- Escalating rule complexity = tension
- Delayed consequences = dread

### **Office Space Proved:**
- Tech workers want cathartic satire
- Corporate absurdism is universally relatable
- "Fuck this place" fantasy has mass appeal

### **Ducks Add:**
- Memeable hook (social media spreading)
- Emotional attachment (protecting ducks)
- Visual indicator of suffering
- Comedic release valve

### **Target Audience:**
- Tech workers (primary) - lived this pain
- Burned out office workers (secondary)
- Papers Please fans
- Dark comedy fans
- "One more turn" game addicts

### **Why Now:**
- Remote work burnout is peak
- Tech layoffs creating industry resentment
- Indie games with strong themes succeeding
- Mobile game design trending toward meaningful choices

---

## Development Priorities

### **DO FIRST:**
1. Ticket inspection UI
2. Bugs system
3. Stamp decisions
4. One production outage event

**Why:** This is the core "Papers Please" hook. If this isn't fun, nothing else matters.

### **DO SECOND:**
1. Event system with choices
2. Consequence tracking
3. Escalation curve

**Why:** This adds the "one more day" addiction and moral weight.

### **DO LAST:**
1. Polish (animations, sounds)
2. More content (tasks, events)
3. Meta-progression
4. Act 2

**Why:** Only polish something that's already fun.

---

## The One-Pager Pitch

**Alt+F+This**
*Papers Please meets Office Space with duck-based emotional damage*

You're a tech worker trapped in corporate hell. Every work ticket is a moral dilemma. Ship buggy code to meet impossible deadlines, or work overtime and lose your sanity? Help your coworker or throw them under the bus? Each choice costs ducks (your patience). Run out of ducks, you break. Save $5K before that happens, and escape to start your own company in Act 2—where everyone you wronged shows up.

**Genre:** Inspection/management sim with dark comedy
**Platform:** Mobile-first (portrait), PC later
**Playtime:** 2-3 hours per run, high replayability
**Hook:** "Papers Please but you're debugging corporate capitalism"

---

## Final Thoughts

This game is **3/10 right now** but could be **9/10** because:

✅ Strong unique hook (duck economy)
✅ Proven mechanics (Papers Please)
✅ Relatable theme (corporate burnout)
✅ Great writing already (task descriptions)
✅ Clean technical foundation
✅ Clear escalation path

The gap is execution: implement the inspection gameplay, add consequence systems, and juice it up.

**This could be your "Vampire Survivors" moment—a simple, focused game with a unique twist that resonates.**

Get Act 1 to 8/10, then worry about Act 2.
