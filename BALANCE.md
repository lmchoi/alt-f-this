# Balance & Tuning Reference

**Purpose:** All exact numbers, formulas, and tunable values for "Code Monkey"
**Status:** Initial design values (will need playtesting adjustment)
**Last Updated:** 2025-11-03

---

## Core Formulas

### Duck Allocation (Always 8 per day)

**Job Task Progress:**
```gdscript
base_progress = ducks_allocated × 12%
bug_multiplier = 1.0 + (bugs × 0.01)
final_progress = base_progress / bug_multiplier
```

**Examples:**
| Ducks | Bugs | Base | Multiplier | Final Progress |
|-------|------|------|------------|----------------|
| 8     | 0    | 96%  | 1.0        | 96% (1 day)    |
| 5     | 20   | 60%  | 1.2        | 50%            |
| 3     | 50   | 36%  | 1.5        | 24%            |

**Startup Progress:**
```gdscript
base_progress = ducks_allocated × 10%
users_gained = base_progress × 100 × (1 + features_completed)
```

**Examples:**
| Ducks | Features | Base | Users Gained |
|-------|----------|------|--------------|
| 3     | 0        | 30%  | 30           |
| 3     | 2        | 30%  | 90           |
| 5     | 5        | 50%  | 300          |

---

## Caught Hustling Detection

### Base Detection Chances
| Startup Ducks | Base Detection % | Risk Level |
|---------------|------------------|------------|
| 0             | 0%               | Safe       |
| 1-2           | 10%              | Low        |
| 3-5           | 30%              | Medium     |
| 6-7           | 50%              | High       |
| 8             | 70%              | Very High  |

### Detection Modifiers
**Increase Chance (+):**
- Boss watching (after Strike 1): +15%
- Boss angry (poor quality ships): +15%
- Low coworker relationships: +10%
- On PIP: +25%
- High bugs (>40): +10%

**Decrease Chance (-):**
- High coworker relationships: -10%
- Recent excellent ships: -10%
- Good reputation: -5%

**Example Calculation:**
```
3 ducks to startup = 30% base
+ Boss watching: +15%
- Alice covering: -10%
= 35% final detection chance
```

### Strike System
1. **Strike 1 (Warning)**: +15% detection for 5 days
2. **Strike 2 (PIP)**: +25% detection for 30 days, must ship 3 tasks at 70%+
3. **Strike 3 (Fired)**: Game over

---

## Ship Quality & Bugs

### Bugs Added Formula
```gdscript
bugs_added = (100 - progress) / 10
```

**Quality Bands:**
| Progress | Bugs Added | Quality    |
|----------|------------|------------|
| 90-100%  | 0-1        | Excellent  |
| 70-89%   | 1-3        | Good       |
| 50-69%   | 3-5        | Poor       |
| 20-49%   | 5-8        | Terrible   |
| <20%     | 8-10       | Disaster   |

**Boss Reaction Thresholds:**
- Ship at 90%+: Boss +1, reputation boost
- Ship at 70-89%: Neutral
- Ship at 50-69%: Boss -1, warning
- Ship at <50%: Boss -2, possible PIP

---

## Salary & Money

### Weekly Salary (Payday Every 5 Days)
| Job Level | Base Salary | Per Payday (5 days) |
|-----------|-------------|---------------------|
| Junior    | $1,500/week | $1,071              |
| Mid       | $2,500/week | $1,786              |
| Senior    | $4,000/week | $2,857              |

### Promotion Thresholds
- **Junior → Mid**: 8 tasks completed at 70%+ average
- **Mid → Senior**: 15 tasks completed at 80%+ average
- **Senior → Management**: 20 tasks completed at 85%+ average (Golden Handcuffs ending)

### Expenses (Deducted at Payday)
- Rent: $800 per payday
- Food/Living: $200 per payday
- **Net Savings**: Salary - $1,000

**Example (Mid-level):**
- Gross: $1,786
- Expenses: -$1,000
- Net: +$786 per payday

---

## Win Conditions

### Victory Path 1: Money Runway
- **Startup Complete**: 100% (all 8-10 features shipped)
- **Money Saved**: $3,000
- **Days**: 30-40 typical

### Victory Path 2: Revenue
- **Startup Complete**: 100%
- **Daily Revenue**: $50/day from app
- **Days**: 35-45 typical

### Startup Feature Requirements
- **Total Features**: 8-10 to reach 100%
- **Each Feature**: ~10-12% progress
- **User Milestones**: 0 → 100 → 500 → 1,000 → 2,000+ users

---

## Loss Conditions

### Fired (Deadlines)
- **Trigger**: Miss 2 deadlines → PIP → Miss 1 more → Fired
- **Typical**: Days 20-35 if always allocating 6+ to startup

### Fired (Caught Hustling)
- **Trigger**: Caught 3 times (Strike 1 → 2 → 3)
- **Typical**: Days 15-30 if allocating 6-8 ducks aggressively

### Golden Handcuffs
- **Trigger**: Ship 20+ tasks at 85%+ average quality
- **Result**: Promoted to management, startup dies
- **Typical**: Days 45+ if always prioritizing job

### Stuck (Burnout)
- **Trigger**: Days 50+, app <50% complete, still mid-level
- **Result**: "You forgot to escape"

---

## Special Event Frequency

### Event Chance by Phase
| Game Phase       | Days    | Event Chance/Day | Expected Events |
|------------------|---------|------------------|-----------------|
| Week 1-2         | 1-14    | 15%              | 2-3             |
| Week 3-4         | 15-28   | 25%              | 3-4             |
| Week 5+          | 29+     | 35%              | 3-5             |
| **Total**        | 30-40   | ~25% average     | **8-12**        |

### Event Type Frequency
**High (1-3 times per game):**
- Caught Hustling: Triggered by detection roll
- Performance Review: Every 15 days (days 15, 30)
- Team Happy Hour: ~1-2 times (Friday random)

**Medium (1-2 times per game):**
- Production Outage: When bugs >40 or poor quality ships
- Boss Demands Demo: When task 40-80% complete
- Coworker Crisis: Random, mid-game
- Startup User Feedback: When users >200

**Low (0-1 times per game):**
- Recruiter Contact: Mid-late game, good work history
- Competitor Launches: When startup has momentum
- Health Warning: Worked 10+ days straight

---

## Progression Tuning

### Task Complexity & Deadlines
| Week     | Complexity | Deadline (Days) | Notes                    |
|----------|------------|-----------------|--------------------------|
| Week 1   | 1.0-1.5    | 5-7             | Tutorial tasks           |
| Week 2   | 1.5-2.0    | 4-6             | Normal difficulty        |
| Week 3-4 | 2.0-3.0    | 3-5             | Pressure ramps           |
| Week 5+  | 3.0-4.0    | 2-4             | Endgame crunch           |

### Startup Feature Unlock Conditions
| Feature # | Users Needed | Unlock Condition        |
|-----------|--------------|-------------------------|
| 1-3       | 0            | Always available        |
| 4-5       | 200          | User feedback event     |
| 6-7       | 500          | Growth momentum         |
| 8-10      | 1,000        | Final feature tree      |

---

## Playtesting Targets

### What to Tune After Testing

**Locked (Core Design, Don't Change):**
- 8 ducks per day
- 3-strike caught system
- Detection curve shape (low/med/high/veryhigh)
- Bug multiplier structure
- Rare events (not daily interruptions)

**Tune During Playtesting:**
- [ ] Job progress rate (currently 12% per duck)
- [ ] Startup progress rate (currently 10% per duck)
- [ ] Detection base percentages (10%, 30%, 50%, 70%)
- [ ] Detection modifiers (±10-15%)
- [ ] Event frequency (currently ~25% of days)
- [ ] Bug accumulation rate
- [ ] Win condition thresholds ($3K, 100%, $50/day)
- [ ] Salary amounts and promotion requirements

### Playtesting Questions
1. Can players escape in 30-40 days consistently?
2. Does caught hustling feel inevitable but fair?
3. Do events feel special (not annoying)?
4. Is bug accumulation punishing enough?
5. Are promotion thresholds balanced (not too easy/hard to get golden handcuffs)?
6. Do both win paths (money vs revenue) feel viable?

### Balance Change Log
**Version 1.0 (2025-11-03):** Initial design values
- (Add changes here during playtesting)

---

## Quick Reference: Critical Numbers

**Duck Rates:**
- Job: 12% per duck
- Startup: 10% per duck
- Bug multiplier: 1% per bug

**Detection:**
- 1-2 ducks: 10%
- 3-5 ducks: 30%
- 6-7 ducks: 50%
- 8 ducks: 70%

**Bugs:**
- Formula: (100 - progress) / 10
- High bugs threshold: 40+

**Money:**
- Win target: $3,000
- Revenue target: $50/day
- Net income: ~$800/payday (mid-level)

**Events:**
- Total per game: 8-12
- Average frequency: ~25% of days

**Strikes:**
- 1st: Warning (+15% detection, 5 days)
- 2nd: PIP (+25% detection, 30 days)
- 3rd: Fired (game over)
