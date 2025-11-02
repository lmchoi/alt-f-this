# Caught Hustling Mechanic Design

**Core Tension:** The more you work on your startup, the more likely you get caught.

---

## Detection Chances

Every day you allocate ducks to startup, roll for detection:

| Ducks to Startup | Detection Chance | Risk Level |
|------------------|------------------|------------|
| 0 ducks | 0% | Safe |
| 1-2 ducks | 10% | Low (sneaky) |
| 3-5 ducks | 30% | Medium (risky) |
| 6-7 ducks | 50% | High (bold) |
| 8 ducks | 70% | Very High (reckless) |

### Modifiers

**Increase detection chance:**
- Boss walked by recently (+10%)
- Shipped job task poorly last day (+15%)
- Low relationship with coworkers (+10%, they snitch)
- Friday/Monday (boss is watching) (+5%)

**Decrease detection chance:**
- High relationship with coworkers (-10%, they cover)
- Shipped excellent work recently (-10%)
- Late in day (boss gone home) (-5%)

---

## How You Get Caught

### Visual/Narrative Scenarios

**1. Boss Walks By (40%)**
```
"Your boss walks past your desk. You quickly Alt+Tab
from your startup code to Jira, but not fast enough."

Boss: "Was that... a login page? For what app?"
You: [Scramble excuse]
```

**2. Screen Share Accident (25%)**
```
"During standup, you share your screen. There's a VSCode
window open with 'my-startup-app' in the title bar."

PM: "Interesting project name... is that for PROJ-1337?"
You: [Panic]
```

**3. Git Commit on Company Laptop (20%)**
```
"IT sends you a Slack: 'We noticed some unusual git
activity on your work laptop. Can we chat?'"

You: [Sweating]
```

**4. Coworker Snitches (10%)**
```
"Bob saw you working on something that wasn't work.
He mentioned it to the boss during their 1:1."

Boss messages you: "We need to talk."
```

**5. Too Obvious (5%)**
```
"You've been allocating 8 ducks to startup for 5 days
straight. You're not even pretending to work anymore."

Boss: "Your last commit was 5 days ago. What's going on?"
```

---

## Consequences (3-Strike System)

### Strike 1: Warning
**Message:**
```
╔═══════════════════════════════════════════╗
║ ⚠️  CAUGHT HUSTLING                       ║
╠═══════════════════════════════════════════╣
║                                           ║
║ Your boss pulls you aside:                ║
║                                           ║
║ "I noticed you've been a bit distracted   ║
║  lately. Everything okay? Remember,       ║
║  we need you focused on PROJ-1337."       ║
║                                           ║
║ Translation: They know. Be more careful.  ║
║                                           ║
║ [Okay, I'll focus] (lie)                  ║
╚═══════════════════════════════════════════╝
```

**Mechanical Effect:**
- Detection chance +15% for next 5 days (they're watching)
- No other penalty

**Narrative Effect:**
- Paranoia increases
- Need to be sneakier (1-2 ducks max for a while)

---

### Strike 2: PIP Warning
**Message:**
```
╔═══════════════════════════════════════════╗
║ 🚨 PERFORMANCE IMPROVEMENT PLAN           ║
╠═══════════════════════════════════════════╣
║                                           ║
║ Meeting invite: "Performance Discussion"  ║
║                                           ║
║ HR: "We've noticed a pattern of reduced   ║
║      output. You're being placed on a     ║
║      30-day Performance Improvement Plan."║
║                                           ║
║ Boss: "One more incident and we'll have   ║
║        to let you go. Understood?"        ║
║                                           ║
║ You: [Nod silently]                       ║
║                                           ║
║ Days until PIP expires: 30                ║
║                                           ║
║ [This is fine] (it's not fine)            ║
╚═══════════════════════════════════════════╝
```

**Mechanical Effect:**
- Detection chance +25% for next 30 days
- Must ship next 3 tasks at 70%+ or instant fire
- PIP counter appears on screen (pressure)

**Narrative Effect:**
- High stakes: one more strike = fired
- Forces hard choice: stop hustling (safe) or risk it (bold)

**Strategic consideration:**
- Do you stop hustling for 30 days? (safe, but startup stalls)
- Or allocate 1-2 ducks and pray? (risky, keep momentum)

---

### Strike 3: Fired
**Message:**
```
╔═══════════════════════════════════════════╗
║ 💼 TERMINATED                             ║
╠═══════════════════════════════════════════╣
║                                           ║
║ Meeting: "Exit Discussion"                ║
║                                           ║
║ HR: "Unfortunately, we have to let you    ║
║      go. Security will escort you out."   ║
║                                           ║
║ Boss: "I really tried to make this work." ║
║                                           ║
║ You clean out your desk in silence.       ║
║                                           ║
║ IT confiscates your laptop.               ║
║                                           ║
║ Your badge doesn't work anymore.          ║
║                                           ║
╠═══════════════════════════════════════════╣
║ GAME OVER                                 ║
║                                           ║
║ Ending: "Caught Red-Handed"               ║
║                                           ║
║ Money saved: $2,300 (not enough)          ║
║ Startup users: 450 (not enough)           ║
║ Days survived: 23                         ║
║                                           ║
║ "You bet everything on the startup and    ║
║  lost. At least you tried."               ║
╚═══════════════════════════════════════════╝
```

**Game Over:** Fired ending

---

## Player Strategy Layer

### Low-Risk Play
- Allocate 1-2 ducks to startup (10% detection)
- Slow but steady progress
- Less likely to get caught
- **Trade-off:** Startup takes longer (40-50 days to complete)

### Medium-Risk Play
- Allocate 3-5 ducks to startup (30% detection)
- Balanced progress
- Moderate risk
- **Trade-off:** Will probably get Strike 1, maybe Strike 2

### High-Risk Play
- Allocate 6-8 ducks to startup (50-70% detection)
- Fast startup progress
- High chance of getting caught
- **Trade-off:** Might get fired, but if you survive, fastest path

---

## Interaction with Other Systems

### Coworker Relationships Help
If you have high relationship with coworkers:
- They cover for you (-10% detection)
- They warn you when boss is coming (can reallocate mid-day)
- They lie to boss ("He was helping me debug")

**Example Event:**
```
Alice (coworker): "Hey, boss is headed your way.
                   You might want to close that startup tab."

[Thanks!] (detection chance -50% this interruption)
```

### PIP from Deadlines vs PIP from Hustling
**Two separate PIP tracks:**

1. **Performance PIP** (missed deadlines)
   - Miss 2 deadlines → PIP
   - Miss 1 more → Fired

2. **Conduct PIP** (caught hustling)
   - Caught 2 times → PIP
   - Caught 1 more → Fired

**If you get BOTH PIPs:** Instant fired (compounding warnings)

---

## Detection Events (Specific Scenarios)

### Event 1: Boss Walk-By
```json
{
  "id": "boss_walkby_caught",
  "title": "Boss Spotted Your Startup Code",
  "description": "Your boss walks past. You Alt+Tab, but they saw the startup code.",
  "trigger": {
    "startup_ducks": ">=3",
    "base_chance": 0.3
  },
  "choices": [
    {
      "text": "It's a... side project for learning",
      "consequences": {
        "strike": 1,
        "boss_relationship": -2,
        "detection_modifier": 0.15
      }
    },
    {
      "text": "Just browsing Stack Overflow",
      "consequences": {
        "lie_check": 0.5,
        "if_success": { "strike": 0 },
        "if_fail": { "strike": 1, "boss_relationship": -3 }
      }
    },
    {
      "text": "Okay, you got me. I'm building something.",
      "consequences": {
        "strike": 1,
        "boss_relationship": 0,
        "honest_reputation": 1,
        "note": "Boss respects honesty, but still warns you"
      }
    }
  ]
}
```

### Event 2: IT Notice
```json
{
  "id": "it_git_activity",
  "title": "IT Flagged Your Git Activity",
  "description": "IT: 'We noticed unusual git commits on your work laptop during work hours.'",
  "trigger": {
    "startup_ducks": ">=5",
    "days_consecutive": ">=3",
    "base_chance": 0.2
  },
  "choices": [
    {
      "text": "It's for a work project",
      "consequences": {
        "lie_check": 0.3,
        "if_fail": { "strike": 1, "it_monitoring": true }
      }
    },
    {
      "text": "I can explain... [Delete evidence]",
      "consequences": {
        "strike": 0,
        "startup_progress": -20,
        "note": "You deleted 3 days of work to cover tracks"
      }
    }
  ]
}
```

### Event 3: Coworker Snitch
```json
{
  "id": "coworker_snitch",
  "title": "Bob Told Your Boss",
  "description": "Bob mentioned to your boss that you've been 'distracted' lately.",
  "trigger": {
    "coworker_relationship": "<=-2",
    "startup_ducks": ">=3",
    "base_chance": 0.1
  },
  "choices": [
    {
      "text": "Confront Bob",
      "consequences": {
        "strike": 1,
        "bob_relationship": -5,
        "note": "Boss already knows, confronting Bob makes it worse"
      }
    },
    {
      "text": "Deny everything",
      "consequences": {
        "strike": 1,
        "boss_relationship": -1,
        "note": "Boss trusts Bob more than you"
      }
    },
    {
      "text": "Thank Bob for keeping you accountable",
      "consequences": {
        "strike": 1,
        "bob_relationship": 2,
        "boss_relationship": 1,
        "note": "Turning it around actually works (but still a strike)"
      }
    }
  ]
}
```

---

## UI Indicators

### Paranoia Meter (Visual Indicator)
When you allocate ducks to startup, show risk level:

```
┌─────────────────────────────────────┐
│ STARTUP: 🦆🦆🦆🦆🦆 (5 ducks)        │
│                                     │
│ Detection Risk: ⚠️  MEDIUM (30%)    │
│                                     │
│ Modifiers:                          │
│ • Boss watching: +15%               │
│ • Alice covering: -10%              │
│                                     │
│ Final chance: 35%                   │
└─────────────────────────────────────┘
```

### Strike Counter (After First Caught)
```
╔═════════════════════════════════════╗
║ ⚠️  STRIKES: ⚫⚫⚪ (2/3)            ║
║ One more and you're FIRED           ║
╚═════════════════════════════════════╝
```

### PIP Warning (Active)
```
╔═════════════════════════════════════╗
║ 🚨 ON PIP: 23 days remaining        ║
║ Detection chance: +25%              ║
║ Must ship next 3 tasks at 70%+      ║
╚═════════════════════════════════════╝
```

---

## Balance Tuning

### Detection Rates Target
- **Typical run (3-5 ducks/day):** Get caught 1-2 times per playthrough
- **Aggressive run (6-8 ducks/day):** Get caught 3-4 times (likely fired)
- **Safe run (1-2 ducks/day):** Get caught 0-1 times

### Probability Math
```
Chance to NEVER get caught in 30 days:
- 1-2 ducks (10% daily): (0.9)^30 = 4% (very likely caught at least once)
- 3-5 ducks (30% daily): (0.7)^30 = 0.02% (almost certainly caught)
- 6-8 ducks (50% daily): (0.5)^30 = 0.0001% (definitely caught multiple times)

This creates natural pressure: you WILL get caught if you hustle.
Question is: Can you finish before Strike 3?
```

---

## Dramatic Moments

### The Close Call
```
You allocated 6 ducks to startup today (risky).
Boss walks by...
[Rolling for detection: 50% chance]
...they don't notice.

You breathe a sigh of relief.
[But detection chance increased +5% tomorrow]
```

### The Inevitable
```
Strike 2. On PIP. 25 days left.
Startup is at 60% complete.
Do you:
- Stop hustling for 25 days (safe, but startup dies)
- Allocate 1 duck/day (slow, risky)
- Go all-in with 8 ducks (fast, almost certain fired)

This is the game.
```

---

## Summary

**Caught Hustling Mechanic = Core Tension**

- Simple to understand (3 strikes, you're out)
- Creates escalating stakes (warning → PIP → fired)
- Forces strategic decisions (risk vs reward)
- Interaction with other systems (relationships help)
- Dramatic moments (close calls, inevitable consequences)

**The beauty:** You're not IF you'll get caught, it's WHEN.
And the question becomes: Can you finish your startup before Strike 3?

---

**Next: Integrate this into GDD.md event system and progression**
