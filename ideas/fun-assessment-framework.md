# Fun Assessment Framework

A systematic method for evaluating game design decisions, focused on management/strategy games with "one more turn" loops.

---

## The 7 Dimensions of Fun

### 1. **Interesting Decisions Per Minute (IDPM)**
*How often does the player face meaningful choices?*

**Scoring:**
- **High (3pts):** Every action requires strategic thought, no autopilot
- **Medium (2pts):** Mix of interesting and routine decisions
- **Low (1pt):** Long stretches of repetitive clicking

**Why it matters:** Papers Please, FTL, Slay the Spire succeed because EVERY turn matters. Mobile games need high IDPM to work in short sessions.

**Red flags:**
- Player can spam same action repeatedly
- "Optimal strategy" emerges that removes choice
- Long grinds between interesting moments

---

### 2. **Consequence Weight**
*Do decisions create lasting emotional impact?*

**Scoring:**
- **High (3pts):** Choices echo for entire playthrough, create regret/pride
- **Medium (2pts):** Consequences matter but fade or can be undone
- **Low (1pt):** Decisions feel inconsequential or reversible

**Why it matters:** This War of Mine, Frostpunk, Papers Please create attachment through permanence. "I still think about that choice" = great design.

**Red flags:**
- "Undo" mechanics that trivialize choices
- Consequences that expire or reset
- Save scumming is optimal strategy
- Decisions that only affect single turn

---

### 3. **Cognitive Load**
*How hard is it to make decisions? (Lower is better for "one more turn" loops)*

**Scoring:**
- **Low (3pts):** Understand options instantly, depth emerges naturally
- **Medium (2pts):** Need to track some state, manageable
- **High (1pt):** Spreadsheet math required, slows flow

**Why it matters:** Vampire Survivors has near-zero cognitive load. Oxygen Not Included has high load. Both fun, but low load = broader appeal + addictive.

**Red flags:**
- Need calculator or spreadsheet to optimize
- Must memorize complex formulas
- Tutorial takes >2 minutes
- Too many resources to track simultaneously

---

### 4. **Emotional Range**
*Does the game create varied feelings beyond just "winning/losing"?*

**Scoring:**
- **Wide (3pts):** Guilt, pride, relief, dread, hope, schadenfreude, etc.
- **Moderate (2pts):** Excitement, frustration, satisfaction
- **Narrow (1pt):** Just challenge/reward loop

**Why it matters:** Stanley Parable, Undertale, Papers Please transcend "game fun" into "memorable experience." Creates stories worth sharing.

**Red flags:**
- All decisions feel same emotionally
- No moral dilemmas or trade-offs
- Wins/losses feel identical
- No attachment to game state

---

### 5. **Pace & Rhythm**
*Does tension build and release naturally?*

**Scoring:**
- **Great (3pts):** Clear escalation, climactic moments, breathing room
- **Okay (2pts):** Somewhat escalates but plateau or spike erratically
- **Flat (1pt):** Same intensity throughout or chaotic pacing

**Why it matters:** Into the Breach perfects this (builds to turn 4 boss each level). Good pacing creates "just one more" addiction.

**Red flags:**
- Early game = late game difficulty
- No escalation or stakes increase
- Difficulty spikes randomly
- Too much downtime or grind
- Players can "turtle" indefinitely

---

### 6. **Mastery Curve**
*Can players improve through skill/knowledge, or is it just RNG?*

**Scoring:**
- **Skill-based (3pts):** Clear learning curve, replays feel different due to player growth
- **Mixed (2pts):** Some skill expression, some luck
- **Luck-based (1pt):** RNG dominates, skill barely matters

**Why it matters:** Slay the Spire speedrunners exist because mastery is deep. Snakes and Ladders has no speedrunners.

**Red flags:**
- Optimal strategy is always same
- RNG decides outcomes regardless of skill
- No learning between runs
- Advanced players have no edge over beginners

---

### 7. **Shareability**
*Does the game generate stories players want to tell?*

**Scoring:**
- **High (3pts):** Unique disasters, moral dilemmas, "can you believe..." moments
- **Medium (2pts):** Some memorable moments but mostly generic
- **Low (1pt):** Experiences blend together, nothing to talk about

**Why it matters:** Among Us, Dark Souls, Dwarf Fortress create watercooler moments. Drives organic marketing + Twitch content.

**Red flags:**
- All runs feel identical
- No emergent stories
- Generic success/failure states
- Nothing worth screenshotting

---

## Total Score: /21

**Interpretation:**
- **18-21:** Potential hit (Papers Please, FTL, Vampire Survivors tier)
- **14-17:** Solid game, needs polish (could break out with iteration)
- **10-13:** Functional but forgettable (needs major revision)
- **Below 10:** Back to drawing board (core loop broken)

---

## How to Use This Framework

### 1. **Evaluate Current Design**
Score your game across all 7 dimensions. Be honest—this is diagnostic, not marketing.

### 2. **Identify Weak Dimensions**
Any score of 1-2 is a red flag. These drag down the entire experience.

### 3. **Propose Changes**
For each weak dimension, brainstorm specific mechanical changes that would increase the score.

### 4. **Re-evaluate Changes**
Score the proposed design. Did weak dimensions improve? Did strong dimensions stay strong?

### 5. **Compare Holistically**
Higher total score = more fun, BUT:
- Don't sacrifice 3s to gain 1s elsewhere
- Consistency matters (three 2s worse than two 3s and one 1)
- Some dimensions matter more for your genre

---

## Example: Evaluating a Proposed Mechanic

**Proposed:** Add "DEBUG" action that removes 15 bugs

**Impact Assessment:**
1. **IDPM:** +0 (adds option but it's routine maintenance)
2. **Consequence Weight:** -1 (makes bugs reversible, softens mistakes)
3. **Cognitive Load:** +0 (simple action)
4. **Emotional Range:** -0 (removes desperation, adds busywork)
5. **Pace & Rhythm:** -1 (creates plateaus, players can grind DEBUG)
6. **Mastery Curve:** -0 (optimal strat might be "DEBUG every 3 days")
7. **Shareability:** +0 (neutral)

**Net Impact:** -2 points (makes game LESS fun)
**Decision:** Reject. Bugs should be permanent.

---

## Genre-Specific Weights

Different game types prioritize different dimensions:

**Puzzle Games:**
- IDPM (3x weight) - every move must matter
- Cognitive Load (inverted - high is okay)
- Mastery Curve (2x weight)

**Narrative Games:**
- Emotional Range (3x weight)
- Consequence Weight (2x weight)
- Shareability (2x weight)

**Idle/Incremental:**
- Pace & Rhythm (3x weight)
- Cognitive Load (must be LOW)
- Mastery Curve (medium importance)

**Management Sims (like Alt+F+This):**
- IDPM (high priority)
- Consequence Weight (high priority)
- Cognitive Load (must be low for mobile)
- Pace & Rhythm (escalation crucial)

---

## Framework Limitations

**What this doesn't measure:**
- Technical polish (bugs, performance)
- Art quality (aesthetics, juice)
- Theme resonance (is the subject matter interesting?)
- Monetization fit
- Market size/competition

**What this DOES measure:**
- Core loop quality
- Mechanical fun
- Replayability
- Engagement depth

Use this for **design decisions**, not for "will this sell?" questions.

---

## Quick Reference Checklist

Before finalizing any mechanic:

- [ ] Does this increase IDPM or is it autopilot?
- [ ] Are consequences permanent or reversible?
- [ ] Can a new player understand this in <30 seconds?
- [ ] Does this create a NEW emotion or just noise?
- [ ] Does this escalate tension or plateau it?
- [ ] Can skilled players leverage this better than beginners?
- [ ] Will players tell stories about this moment?

If you answered "bad" to 3+ questions, reconsider the mechanic.

---

## Case Study Reference: Alt+F+This

See [game-plan.md](game-plan.md) for full analysis comparing:
- **Original design:** 16/21 (solid but flawed)
- **Latest design:** 21/21 (potential hit)

Key learnings:
- Removing DEBUG (+2 pts) - made bugs permanent
- SHIP IT as daily choice (+1 pt) - increased IDPM
- Simplification (-3 mechanics, +1 pt) - reduced cognitive load
- Payment on completion (+0 pts directly, but improved pacing)

**Total improvement: +5 points** from removing mechanics and adding permanence.

**Lesson:** Sometimes less is more. Subtraction can increase fun.
