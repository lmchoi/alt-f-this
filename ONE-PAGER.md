# Alt+F+This - One-Pager (V2)

**"Office Space meets Universal Paperclips in a corporate terminal"**

---

## The Pitch (30 seconds)

You're a dev trapped in corporate hell, building a startup in secret. Every day, split 8 hours between soul-crushing job tasks and your escape plan. Events interrupt—bosses demanding demos, production outages, coworkers needing help. Ship buggy code to meet deadlines or miss them and get fired. Escape with enough money or users before you burn out or get caught.

**Target:** Developers who've lived this nightmare
**Session:** 20-40 minutes per run
**Replayability:** Multiple endings, different strategies

---

## The Hook

**What makes this different:**
1. **Relatable suffering** - Not fantasy escapism, but "oh god, it's MY Jira board"
2. **Boring UI as satire** - Looks like actual dev tools (Jira, Slack, Git)
3. **Allocation puzzle** - Every day: job or startup? Not enough time for both.
4. **Event-driven chaos** - Random interruptions force hard choices
5. **Multiple endings** - Escape via money, users, or fail via burnout/fired/promoted

---

## Core Loop (45-60 seconds per day)

```
Morning: Allocate 8 ducks
         ↓
         Job (current task): 5 ducks
         Startup: 3 ducks
         ↓
Day starts: Interruptions pop up
         ↓
         "Boss wants meeting" (accept = slows progress, ignore = risky)
         "Coworker needs help" (accept = slows progress, ignore = relationship)
         "Production alert" (accept = slows progress, ignore = bugs)
         ↓
End of day: See results
         ↓
         Job task: 40% → 65% (wanted 75%, but interruptions)
         Startup: +30 users (wanted +50, but interrupted)
         ↓
Ship decision: (if job task ready OR deadline hit)
         ↓
         "Task at 65% - ship buggy or wait?"
         ↓
Next day: Consequences ripple
         ↓
         New task appears (if shipped)
         Bugs added (if shipped poorly)
         Caught hustling? (if allocated to startup)
```

---

## Key Mechanics

### 8 Ducks = 8 Hours
Every day, allocate 8 "ducks" (hours/energy):
- **Job** (current task, assigned, has deadline)
- **Startup** (your choice, builds users/revenue)

**Simple choice:** How many hours on job vs startup today?

### Interruptions = Slow You Down
2-4 random interruptions per day:
- Boss wants meeting
- Coworker needs help
- Production alerts
- Random distractions

**Choice:** Handle it (slows progress) OR Ignore it (risky consequences)

**Key:** Interruptions DON'T steal ducks, they reduce efficiency
- Accept interruption = progress reduced by 20-40%
- Ignore interruption = risk (relationship damage, bugs, caught)

### Caught Hustling
Random chance when you allocate ducks to startup:
- **Low allocation (1-2 ducks):** 10% chance caught
- **Medium allocation (3-5 ducks):** 30% chance caught
- **High allocation (6-8 ducks):** 60% chance caught

**Consequences:**
1. First time: Warning ("Focus on your job")
2. Second time: PIP warning (Performance Improvement Plan)
3. Third time: Fired

### Ship or Wait
When job task ready (or deadline hits):
- **Ship early** = Bugs added, task complete, get next task
- **Wait** = Risk missing deadline, more progress

**Important:** More tasks shipped = closer to promotion (golden handcuffs)

### Salary System
- Fixed weekly salary based on job level (junior/mid/senior)
- NOT based on individual tasks
- Payday every 5 days (like V1)
- Promotion happens after X tasks completed

### Win Conditions
**Escape via:**
1. **App Complete + $X saved** - Enough runway to quit
2. **App Complete + $Y/day revenue** - Self-sustaining, can quit

### Lose Conditions
**Fail via:**
1. **Fired (deadlines)** - Missed too many deadlines → PIP → Fired
2. **Fired (caught hustling)** - Caught 3 times → PIP → Fired
3. **Golden Handcuffs** - Promoted to management (become the villain)
4. **Stuck** - Completed many tasks, still mid-level, app not done (burnout ending)

---

## Progression Arc (Inspired by Universal Paperclips)

### Week 1-2: Learning
- Simple tasks, long deadlines
- 1-2 events per day
- Learn allocation strategy
- Ship 80-90% quality

### Week 3-4: Juggling
- Multiple tasks pile up
- 3-4 events per day
- Forced triage decisions
- Ship 60-70% quality

### Week 5-6: Desperation
- High complexity tasks
- 5+ events per day (chaos mode)
- Ship 40-50% quality to survive
- Racing to escape before collapse

### Week 7+: Endgame
- Either: Startup takes off (escape!)
- Or: Death spiral (bugs/burnout)

---

## UI Aesthetic: "Boring" as Feature

**Corporate Terminal Hybrid:**
- **Task cards** = Jira parody (`[CRITICAL] PROJ-1337: Make Logo Bigger`)
- **Events** = Slack notifications (`🔔 @boss: "Quick sync?"`)
- **Ship UI** = Git commit dialog (`git push --force`)
- **Metrics** = Corporate dashboard (KPIs, bar charts)
- **Startup** = Indie hacker metrics (users, MRR)

**Why this works:**
- Instantly relatable to devs (recognize their own tools)
- UI itself is satire (corporate hell, visualized)
- "Boring" = authentic suffering, not fantasy

---

## Writing Style

**Dry, deadpan, specific tech references:**
- ✅ "Add blockchain to login button"
- ✅ "CEO's 'simple' Excel macro that crashes Excel"
- ✅ "Make logo bigger (again)"
- ❌ "Your boss is mean!"
- ❌ "Do the work project"

**Satirical but grounded:**
- Absurd corporate demands (but recognizable)
- Dark humor (not cruel or silly)
- Relatable frustration (devs nod along)

---

## Success Metrics

**You'll know it works when:**
- Devs say "this is literally my job"
- Players agonize over allocation decisions
- "One more day" addiction kicks in
- Players share their worst endings
- Streamers create content (decisions + commentary)
- Replay to try different strategies

**Target feeling:**
- Papers Please's inspection tension (ship or wait?)
- Universal Paperclips' emergent dread (becoming the villain)
- Office Space's cathartic satire (laughing at shared pain)

---

## Scope (Solo Dev, 4-6 weeks)

### Phase 1: Prototype (Week 1)
- Allocation UI (8 ducks across tasks)
- Day simulation (basic math)
- Ship decisions
- 2 endings (escape, fired)

### Phase 2: Events (Week 2)
- Event system (JSON-driven)
- 15-20 events with choices
- Consequences (ducks, bugs, relationships)

### Phase 3: Startup (Week 3)
- Feature tree (5-7 choices)
- Users/revenue tracking
- Startup-specific events

### Phase 4: Juice & Polish (Week 4)
- Animations (progress bars, particles)
- Sound effects (Slack notification dread)
- Visual feedback (bugs crawl, users spike)

### Phase 5: Content & Balance (Week 5-6)
- 30-50 events total
- 20-30 job tasks
- 8-10 endings
- Balance tuning (playtesting)

---

## Competitive Advantage

**vs Papers Please:**
- More relatable theme (office work vs border control)
- Dual objectives (job + startup, not just inspection)
- Replayable strategies (not just story branches)

**vs Universal Paperclips:**
- Active decisions (not idle/passive)
- Emotional weight (relatable vs abstract AI)
- Multiple endings (branching vs single path)

**vs Office Space:**
- Mechanical depth (strategy game vs movie)
- Player agency (you choose descent)
- Replayable (multiple runs)

**Unique positioning:**
- Only game that captures modern dev burnout
- "Boring" UI is the satire (Jira hell, gamified)
- Allocation puzzle + narrative choices

---

## Risks & Mitigation

### Risk: Event repetition gets boring
**Mitigation:**
- 30-50 events (high variety)
- Escalating event types (week 1 ≠ week 5)
- Hidden mechanics (coworker relationships unlock new events)

### Risk: Allocation becomes solved (optimal strategy)
**Mitigation:**
- Random events prevent perfect planning
- Different tasks have different duck costs
- Interruptions force adaptation

### Risk: Too stressful (burnout simulator)
**Mitigation:**
- Dark humor lightens tone
- Victory is achievable (not hopeless)
- Multiple strategies work (not one true path)

### Risk: Not fun enough (just management sim)
**Mitigation:**
- Events add narrative texture
- Ship decisions create tension
- Juice makes actions feel good

---

## Post-Launch (If Successful)

### Act 2: You Become the Boss
- Escaped via startup
- Now you're the founder
- Hire employees (former coworkers appear)
- Face consequences of Act 1 choices
- Ending: Unicorn, acquihire, bankruptcy, revolt

### Content Updates
- More events, tasks, endings
- Seasonal content (performance review season, crunch time)
- Community-submitted tasks

### Platforms
- Start: Itch.io (free/PWYW)
- If traction: Steam ($5-10)
- Maybe: Mobile (touch controls work for allocation)

---

## TL;DR

**What:** Allocation puzzle + narrative choices about escaping corporate hell
**Why:** Relatable to devs, replayable, satirical
**How:** Event-driven days, ship decisions, dual objectives
**When:** 4-6 weeks to playable, polished version
**Who:** Developers who've lived this nightmare

**The pitch in one sentence:**
> "It's a game about escaping corporate hell where you constantly have to choose between day job and escape plan, and the fun comes from juggling meeting deadlines vs shipping bad code."

---

**Next:** See [GDD.md](GDD.md) for full design details, systems, and formulas.
