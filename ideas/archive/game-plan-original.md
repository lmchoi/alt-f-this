# Alt+F+This: Game Plan
**"Papers Please meets Office Space with duck-based emotional damage"**

---

## Vision Statement

A darkly comedic inspection/management game where you're a tech worker trapped in corporate hell. Every work ticket is a moral dilemma. Every shortcut creates future pain. Every duck lost is a piece of your soul. Escape with $5K before bugs make work impossible.

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

- Max 2 decision stamps (ACCEPT/NEGOTIATE)
- Max 3 work actions (WORK/HUSTLE/SHIP IT)
- Every action affects multiple resources (no single-purpose buttons)
- Tutorial < 30 seconds (learn by playing)

### 3. **The Death Spiral Is The Game**
*Losing slowly is more engaging than winning easily. Difficulty should accelerate.*

- Bugs accumulate faster than you can work
- Tasks get harder while you get slower
- Money pressure increases (salary trap)
- No equilibrium state (always escalating)

### 4. **Emotional Bookkeeping Over Spreadsheets**
*Resources represent feelings, not numbers. Make math visceral.*

- **Ducks** = patience/sanity/fucks-to-give (not "health points")
- **Bugs** = guilt/technical debt/sins (not "difficulty modifier")
- **Money** = escape velocity/freedom countdown (not "score")
- **Day** = time running out/aging/exhaustion (not "level number")

### 5. **Shared Suffering Creates Community**
*The game should generate stories players need to tell others.*

- Specific, memorable disasters (not generic failures)
- Moral dilemmas with no right answer
- Outcomes vary enough that players compare notes
- Built-in "can you believe this happened" moments

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
   - Rushed work creates bugs (PERMANENTLY)
   - Bugs slow future work (no way to fix)
   - Must escape before bugs make progress impossible
   - Death spiral mechanics

---

## Act 1: Corporate Prison (MVP Scope)

### Goal
Save $5,000 to escape before bugs accumulate to unworkable levels (or burn out trying)

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
   - [ACCEPT] Take the task
   - [NEGOTIATE] Extension/help/scope (costs resources upfront)
   ↓
4. Work phase (daily choice - THIS IS THE CORE LOOP)
   - WORK: +progress (scaled by complexity + bugs), paid on payday
   - HUSTLE: +escape progress, +ducks (or -ducks if overdue), no corporate progress
   - SHIP IT: Complete task NOW, payment pending until payday, choose what's next
   ↓
5. Daily decision: "Is this good enough to ship?"
   - Ship at 95%? +0.5 bugs, payment on payday
   - Ship at 60%? +4 bugs, payment on payday
   - Ship at 25%? +7.5 bugs, payment on payday
   - Keep working? Risk going overdue (3 days = fired)
   ↓
6. Deadline consequences
   - Before deadline: No penalty, work freely
   - 1 day overdue: Warning from manager
   - 2 days overdue: Urgent warning
   - 3 days overdue: FIRED
   - Choose: ship early (bugs) vs go overdue (risk firing)
   ↓
7. Consequences unfold
   - Task complete when shipped
   - Bugs accumulate (NEVER reduce)
   - Events trigger (random or consequence-based)
   - Stats update, day advances
   ↓
8. Return to step 1 with MORE bugs, SLOWER work, HARDER tasks
```

**The Race:** Earn $5K before bug accumulation makes progress impossible.

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
│  │ (8/10)       │      │                 │ │
│  │              │      │                 │ │
│  │ Est: 5 days  │      │ 💰 PAYCHECK     │ │
│  │ Pay: $500    │      │  $100/day       │ │
│  └──────────────┘      │  (on complete)  │ │
│                        └─────────────────┘ │
│  [STAMP: ACCEPT]                           │
│  [STAMP: NEGOTIATE]                        │
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

### 2. Stamp Decisions (Simplified)

#### **[ACCEPT]** - Standard path
- Take the task
- Work it during work phase
- Subject to all rules and deadlines

#### **[NEGOTIATE]** - Ask for help
Opens submenu:
- **Extension:** +3 days to deadline, costs $100, -1 duck (begging is humiliating)
- **Get Help:** Reduce complexity 50%, owe coworker favor (callback event later)
- **Reduce Scope:** Easier requirements, pays 50% less
- **Overtime:** +40% instant progress, -2 ducks, skip next payday

**Note:** REFUSE removed - no escape hatch. Must face every task.

---

### 3. Work Phase Actions (THE CORE LOOP)

After accepting ticket, **each day** you choose one action. This is where the game lives.

#### **WORK** (primary action)
- Progress += `20 / (complexity × bug_multiplier)`
- Money += 0 (paid on completion or payday)
- Small event chance (30%)
- Standard advancement

**Example:**
- Complexity 5, 40 bugs (1.4x multiplier)
- Progress gain: 20 / (5 × 1.4) = 2.86% per day
- Takes ~35 days to complete without shipping early

#### **HUSTLE** (build your escape)
- Progress += 0 (no work done on corporate task)
- Escape Progress += 8-12% (building side project/network/skills)
- **Ducks += 1** (autonomy feels good), or **-1 if overdue** (guilt/stress)
- No immediate money (investing in YOUR future, not company's)
- **Risk:** Corporate work sits undone, deadline approaches

**The tension:**
- "Do I build my escape now, or focus on corporate work?"
- Hustle while overdue = risky (could get fired)
- Multiple escape paths: $5K pure grind, $3K + 75% escape, $2K + 100% escape
- Unlocks at thresholds: 25% = freelance gigs, 50% = passive income, 75% = job offers, 100% = viable startup

#### **SHIP IT** (available at 20%+ progress)
**The daily temptation. This is the game.**

- Complete task immediately at current progress
- Add bugs: `(100 - progress) / 10`
- Task marked complete, **payment pending until payday**
- Get new task OR hustle until payday (player choice)
- Advance to next day

**Quality flavor text** (from [data/ship_messages.json](../data/ship_messages.json)):
- 90%+: "Actually good work. You feel competent."
- 70-89%: "It works. Probably."
- 50-69%: "Barely functional MVP."
- 30-49%: "AI-generated slop with your name on it."
- 20-29%: "You shipped TODO comments as features."

**Every day you ask:** "Is this good enough? Do I need the money NOW? Can I afford more bugs? Should I risk going overdue?"

**After SHIP IT - Post-Completion Choice:**
```
✅ TASK COMPLETED

"Add Blockchain to Todo App" shipped at 62%

+5.8 bugs added to codebase
Payment pending until payday (Day 15, in 2 days)

────────────────────────────────
What now?

[📋 ACCEPT NEW TASK]
Jump into next work ticket

[🔨 HUSTLE]
Work on your escape plan (2 days until payday)

────────────────────────────────

Tip: You finished early! You could hustle and
     still get paid this cycle.
```

**Makes it clear:**
- "You finished early, you have free time"
- "You can hustle now without losing money"
- "Or be a corporate tryhard and do more tasks"

---

### 4. Task Categories (Risk Profiles)

Different task types create different strategic pressures:

**Optics** (`optics`) - Political/perception risk
- Logo changes, blockchain features, CEO requests, fake AI
- Ship poorly = CEO anger (PIP risk)
- Ship at 50% = 30% chance CEO loves it anyway
- Political risk over technical risk

**Tech Debt** (`tech_debt`) - Long-term compounding consequences
- Database migrations, refactors, optimization, deep bug fixes
- Ship poorly = bugs × 1.5x (compounds badly)
- Ship >85% = reduce bug impact 10% (rare reward)
- Must be careful or suffer long-term

**Critical** (`critical`) - Immediate high-stakes
- Customer-facing features, payment bugs, email disasters, UI changes
- Ship poorly = immediate outage risk (within 2 days)
- Ship well = reputation boost
- High immediate stakes

**Why it works:** Same 3 actions, but SHIP IT decision varies by category. Mastery = learning which tasks can be rushed.

**Implementation:**
- Tasks have `categories` array: ["optics"], ["tech_debt", "critical"], etc.
- Tasks have `flavor` field for display text: "Design Hell", "Buzzword Compliance", etc.
- Multiple categories = stacked risk/reward (e.g., "optics" + "critical" = CEO might love it OR immediate outage)

---

### 5. Company Rulebook (Weekly Shifts)

Rules change like Papers Please bulletin updates, invalidating previous strategies:

- **Week 1-2:** Basic rules, learn the loop
- **Week 3:** [CEO] tasks mandatory, can't negotiate
- **Week 4:** Code review adds +1 day OR skip it (outage risk ×2)
- **Week 5:** Overtime banned (but CEO deadlines still impossible)
- **Week 6:** PIP after 2 outages (lose autonomy, manager approval needed)
- **Week 7:** Stack ranking (coworkers become competitors)
- **Week 8+:** Random weekly chaos (mandatory weekends, hiring freezes, etc.)

**Display:** `📋 ACTIVE POLICIES` button shows current rules

**Why it works:** Forces adaptation, mirrors corporate absurdity, creates memorable runs ("I was fine until PIP hit Week 6")

---

### 6. The Bugs System (Permanent Consequences)

**How Bugs Accumulate:**
- Shipping incomplete tasks adds bugs
- Ship at 95%? +0.5 bugs (rounds to 1)
- Ship at 70%? +3 bugs
- Ship at 40%? +6 bugs
- Ship at 22%? +7.8 bugs

**How Bugs Hurt You:**
- Bugs slow ALL future work
- 20 bugs = 1.2x slower (20% penalty)
- 50 bugs = 1.5x slower (50% penalty)
- 100 bugs = 2.0x slower (work takes TWICE as long)
- Work progress affected by: complexity × bug multiplier

**Bugs NEVER Reduce:**
- No DEBUG action
- No "refactor" tasks
- Every bug you ship is permanent
- Your only hope: escape before they crush you

**The Death Spiral:**
1. Ship task at 60% to meet deadline → +4 bugs
2. Now at 24 bugs total = 24% slower
3. Next task takes longer, can't meet deadline naturally
4. Ship at 50% → +5 bugs
5. Now at 29 bugs = 29% slower
6. Pattern accelerates
7. Eventually work is so slow you MUST ship everything early
8. Bugs accumulate exponentially
9. At 100+ bugs, game becomes nearly unwinnable

**This is intentional.** The game is a race: earn $5K before bugs make it impossible.

---

### 7. Production Outage Events (The Bomb Explodes)

**Trigger:** 2-5 days after shipping at <50% quality

- Creates "time bomb" that explodes later
- Severity based on how badly you shipped
- Random delay creates uncertainty

**When It Explodes:**
```
🚨 PRODUCTION OUTAGE 🚨

"Your 'Blockchain Todo App' feature crashed the payment system."

Consequences:
- Salary penalty: -$200 to -$500 (based on severity)
- Emergency fix task (blocks other work, complexity 3, no pay, 1 day deadline)
- +10 bugs (emergency patches always break things)
- -2 ducks (stress + humiliation)

[EMAIL FROM CEO]
"We need to talk about your recent work quality..."
```

**This is the Papers Please "terrorist exploded" moment**

Low-quality shipping has DOUBLE penalty:
1. Immediate bugs from shipping
2. Future production outage (more bugs + money loss + time loss)

---

### 8. Deadlines & Firing (Overdue System)

**How it works:**
- Tasks have deadlines (e.g., 5 days)
- **Before deadline:** Work freely, no penalties
- **After deadline (overdue):** Warning escalation → firing

**Overdue consequences:**
- **Day 1 overdue:** Warning - "Your task is overdue. Manager is asking questions."
- **Day 2 overdue:** Urgent warning - "Task 2 days overdue. Manager is very unhappy. One more day..."
- **Day 3 overdue:** FIRED - "Failure to complete assigned work"

**HUSTLE while overdue:**
- Normally: HUSTLE gives +1 duck
- While overdue: HUSTLE gives -1 duck (guilt/stress)
- Creates tension: "Do I hustle and risk burnout, or work and risk getting fired?"

**Why this works:**
- Simple rule: 3 days overdue = fired
- Makes HUSTLE risky (work sits undone while you build escape)
- Core tension: "Can I build my escape before they fire me?"
- Prevents "never ship, just hustle" exploit

### 9. Payment System (Payday Cycles)

**Payday every 5 days** - get paid for all completed tasks that cycle

**How it works:**
- Complete tasks during 5-day cycle (Days 1-5, 6-10, 11-15, etc.)
- On payday (Day 5, 10, 15...), receive payment for all completed tasks
- Salary is fixed per task (~$300-500), regardless of complexity
- Complexity = pure suffering (same pay whether easy or hard)

**Strategic depth:**
- Finish task early? **Choice:** Start new task OR hustle until payday
- Efficient workers "hustle on company time" (finish in 2 days, hustle 3 days)
- Can ship multiple tasks per cycle for more money
- Or ship one task + hustle for escape progress

**Creates pressure:**
- "Should I ship fast at 60% to maximize hustle time this cycle?"
- "Or ship carefully at 90% but have no time to hustle?"
- "Can I squeeze in 2 tasks before payday, or focus on quality?"

---

### 10. Stack Ranking Meeting System (Voting + Education)

**NEW SYSTEM - Key engagement and trauma bonding mechanic**

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

---

### 11. Escalating Pressure

#### **Week 1-2 (Days 1-10): Onboarding**
- Simple tasks (complexity 1-3)
- Long deadlines (5-7 days)
- Low bugs (you're still clean)
- Learning the systems
- Can afford to ship at 80-90% quality

#### **Week 3-4 (Days 11-20): Reality Sets In**
- NEW RULE: "All CEO requests are mandatory"
- Medium tasks (complexity 4-6)
- Shorter deadlines (3-5 days)
- Salary increases +$20/week (golden handcuffs forming)
- Past bugs starting to bite (20-30 bugs accumulated)
- Tempted to ship at 60-70%

#### **Week 5-6 (Days 21-30): Crisis Mode**
- NEW RULE: "Overtime banned" (but deadlines still tight)
- Hard tasks (complexity 7-9)
- Tight deadlines (2-3 days)
- High bugs if you've been shipping early (40-60 bugs)
- Work is 40-60% slower
- Must ship at 40-50% just to survive
- Coworker relationships matter
- Moral dilemmas ("fire junior dev or take blame?")

#### **Week 7+ (Days 31+): Breaking Point**
- NEW RULE: "Code reviews mandatory" (+1 day per task)
- Very hard tasks (complexity 8-10)
- Brutal deadlines (1-2 days)
- If you're at 60+ bugs, nearly impossible to complete normally
- If you're at $4K+, SO CLOSE to freedom
- Desperate choices: ship at 20-30%?
- Production outages from past sins
- Every day is a scramble

**The curve creates natural three-act structure:**
- Act I: "This is manageable"
- Act II: "Oh no, this is catching up to me"
- Act III: "SHIP EVERYTHING, ESCAPE NOW"

---

### 12. Event System

#### **Random Events (30% chance on Work)**

**Flavor Events:**
```javascript
"Boss says 'We're a family'" → -1 duck
"Free pizza! (It's vegan)" → +1 duck (maybe)
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
  → WAIT, this breaks the "bugs never reduce" rule!
  → REVISED: Junior dev speeds up your work +20% for 3 days

// If you ranked sensibly in stack ranking 3+ times
"Day 35: Boss notices you 'don't get the big picture'"
  → -$100, +1 duck (you stood your ground)
```

---

### 13. Company Rulebook (Legacy Section - See System 5 Above)

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
(Cannot negotiate extension without approval)
```

#### **Day 10 Update:**
```
NEW RULE: Code reviews required for all deployments
(Adds 1 day to every task deadline)
```

#### **Day 15 Update:**
```
NEW RULE: Overtime hours banned per labor law
(Cannot work weekends for progress boost)

CONFLICTING WITH: CEO mandatory tasks with impossible deadlines
```

#### **Day 20 Update:**
```
NEW RULE: Performance Improvement Plan (PIP) for 2+ production outages
- All work requires approval
- Weekly 1-on-1 meetings (-1 duck each)
- Next outage = termination
```

**The Papers Please Magic:** Rules contradict each other, forcing impossible choices

---

## Win/Lose Conditions

### **Victory: Escape to Act 2**
- Reach $5,000 in savings
- Quit with dramatic email
- Victory screen shows:
  - Days survived
  - Bugs shipped
  - Lowest quality ship (%)
  - Most catastrophic task
  - Moral choices made
- Stats carry forward (bugs, relationships, reputation)
- Unlock Act 2: Startup Chaos

**Post-game shareable (with dynamic title):**
```
[ENDING: THE BURNT-OUT HUSTLER]
"I escaped, but at what cost?"

Day 43 | 71 bugs shipped | $5,000 earned | 0 ducks remaining

Lowest ship: "CEO Logo Revision" at 18% (AI slop)
Most bugs from: "Blockchain Todo App" (+8 bugs)
Closest call: 1 duck remaining on Day 38

My Compromises:
✅ Shipped tabs (CEO mandate)
✅ Skipped TDD (no time)
✅ Blamed 2 junior devs
✅ Shipped TODO comments as features

I'll never be clean again.

[Share] [Try to escape faster]
```

**Victory Ending Titles (based on stats):**

| Title | Conditions | Flavor Text |
|-------|-----------|-------------|
| **THE PERFECTIONIST** | <20 bugs, >30 days | "You escaped with your soul intact." |
| **THE PRAGMATIST** | 20-50 bugs, avg ship quality 60-80% | "You made the deals you had to make." |
| **THE BURNT-OUT HUSTLER** | 0 ducks remaining | "I escaped, but at what cost?" |
| **THE SPEED RUNNER** | <25 days | "You got out before they could break you." |
| **THE TECHNICAL DEBT MONSTER** | 50-90 bugs | "You left a trail of destruction behind you." |
| **THE AI PROMPT ENGINEER** | Avg ship quality <40% | "You shipped TODO comments as features." |
| **THE SURVIVOR** | 3+ production outages survived | "You crawled through hell and came out broken." |
| **THE SELLOUT** | Complied with 90%+ CEO demands | "You became what you hated." |
| **THE REBEL** | Refused/pushed back 50%+ of time | "You fought the system and won." |
| **THE MARTYR** | Helped coworkers 5+ times, 1 duck left | "You saved others but couldn't save yourself." |
| **THE SOCIOPATH** | Blamed others 3+ times, high escape | "Your coworkers paid for your freedom." |
| **THE GOLDEN PARACHUTE** | Escaped with $7K+ (over-earned) | "You didn't just escape. You robbed them." |

**Multi-condition priority:**
1. Check for extreme stats first (AI Prompt Engineer, Sociopath, Perfectionist)
2. Check for playstyle patterns (Speed Runner, Rebel, Martyr)
3. Default to bug count + duck count (Pragmatist, Burnt-Out, Survivor)


### **Game Over: Ran Out of Ducks**
```
"You gave your last duck."

You sit at your desk, staring at the screen.
The cursor blinks.
You feel nothing.

You open Slack and type to the CEO: "lol"

Days survived: 34
Money earned: $4,200 (so close!)
Bugs shipped: 92
Ducks remaining: 0

[Ending: Nihilist Burnout]
```

### **Game Over: Impossible Workload (100+ bugs)**
```
"The bugs have won."

You open a task: Complexity 8, deadline 2 days.
Your bug multiplier: 2.1x (110 bugs)
Time to complete: 8.4 days

The math doesn't work anymore.
You can't ship fast enough.
You can't earn money fast enough.

You're trapped.

Days survived: 38
Money earned: $3,600
Bugs shipped: 110
Progress on final task: 15%

[Ending: Death Spiral]
```

### **Game Over: Golden Handcuffs**
```
"Congratulations! Your salary is now $2,500 every 5 days."

You can't afford to quit anymore.
The stock options vest in 3 years.
You'll never leave.

Days survived: 50
Money earned: $8,200 (but you need $5K to escape, and you passed that threshold when salary hit trap threshold)
Bugs shipped: 45
Salary trap: $2,500/5 days

[Ending: Corporate Drone]
```

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
- Cookie Clicker's "one more click" but with actual decisions
- FTL's "one more jump" desperation

**Target metrics:**
- With 0 bugs: Complexity 5 task takes ~5 days of work
- With 40 bugs: Same task takes ~7 days (40% slower)
- With 80 bugs: Same task takes ~9 days (80% slower)
- Salary should increase from $100 → $500 over ~40 days
- Escape goal ($5K) should take 30-50 days depending on choices
- Ducks should be scarce (start with 3, rarely gain them back)
- Most players ship first tasks at 80-90%, later tasks at 40-60%

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
1. SHIP IT as daily decision
2. Bug accumulation (permanent)
3. Payment on completion
4. HUSTLE gains ducks

**Why:** This is the core innovation. If "should I ship now?" isn't compelling, nothing else matters.

### **DO SECOND:**
1. Event system with choices
2. Consequence tracking
3. Escalation curve
4. Production outages

**Why:** This adds the "one more day" addiction and moral weight.

### **DO LAST:**
1. Polish (animations, sounds)
2. More content (tasks, events)
3. Stack ranking system
4. Meta-progression
5. Act 2

**Why:** Only polish something that's already fun.

---

## The One-Pager Pitch

**Alt+F+This**
*Papers Please meets Office Space with duck-based emotional damage*

You're a tech worker trapped in corporate hell. Every day you choose: work on your task, side hustle for sanity, or ship it early and accumulate bugs. Bugs slow ALL future work and NEVER go away. Ship fast to meet deadlines, or ship clean to survive long-term? You can't do both. Save $5K before bug accumulation makes work impossible, then escape to start your own company in Act 2—where everyone you wronged shows up.

**Genre:** Inspection/management sim with dark comedy
**Platform:** Mobile-first (portrait), PC later
**Playtime:** 2-3 hours per run, high replayability
**Hook:** "Papers Please but you're debugging corporate capitalism, and your sins never wash away"

---

## Final Thoughts

**Fun Assessment Score: 21/21** (see [fun-assessment-framework.md](fun-assessment-framework.md))

This game is **3/10 right now** but could be **9/10** because:

✅ Strong unique hook (permanent bugs + daily SHIP IT temptation)
✅ Proven mechanics (Papers Please inspection)
✅ Relatable theme (corporate burnout)
✅ Great writing already (task descriptions)
✅ Clean technical foundation
✅ Clear escalation path
✅ Simple mechanics (5 total, not 8)

The gap is execution: implement SHIP IT as daily choice, make bugs permanent, and juice it up.

**This could be your "Vampire Survivors" moment—a simple, focused game with a unique twist that resonates.**

Get Act 1 to 8/10, then worry about Act 2.
