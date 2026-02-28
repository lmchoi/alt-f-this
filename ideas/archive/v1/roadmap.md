# Roadmap & Future Ideas

Design decisions, deferred features, and ideas to revisit later.

---

## Design Decisions Made

### Keep It Simple (For Now)
- **Dual-track progression (Corporate Level + Nerd Cred)**: Deferred - adds complexity, scored only slightly lower than single-track
- **Skill-based work speed**: Deferred - HUSTLE builds escape progress, not skills. Keeps death spiral intact.
- **Bug reduction/DEBUG action**: NEVER - bugs are permanent, core tension of the game
- **Multiple firing triggers**: Simplified to 3-day overdue only. PIP, stack ranking, outages deferred.

### Payment System: Salary + Payday
- **Salary-based (not task-dependent)**: "A 9-5 pays the same, just enough for survival" regardless of difficulty
- **Payday every 5 days**: Creates strategic cycles - finish early = time to hustle
- **Post-completion choice**: Clear [ACCEPT NEW TASK] or [HUSTLE] screen after SHIP IT

### HUSTLE: Escape Progress System
- Builds toward alternative victory paths (side project/network/reputation)
- **Escape progress**: 0-100%, ~10 hustles to complete
- Risk: Can get fired if hustling when overdue
- Benefit: +1 duck (autonomy feels good), -1 duck if overdue (neglecting work)

---

## Future Ideas (Revisit Later)

### Firing Mechanics (Beyond 3-Day Overdue)
- **PIP system**: Performance Improvement Plan, multi-stage warning
- **Production outages**: Ship low quality → random outage chance → fired after 3 outages
- **Stack ranking**: Periodic review, bottom 10% fired
- **CEO whim**: Random firing from high-level anger

### Task System Enhancements
- **Task categories risk**:
  - Optics: Ship <70% = CEO anger, 30% chance CEO loves mediocrity
  - Tech Debt: Ship <70% = bugs × 1.5, ship >85% = reduce bug impact 10%
  - Critical: Ship <70% = high outage risk within 2 days, ship >80% = reputation boost
- **Difficulty scaling**: TaskManager.get_random_task(day, min, max) based on week

### Progression Systems
- **Corporate level**: Climb ladder, higher salary, more pressure
- **Nerd cred/skill**: Side project quality, network strength
- **Reputation**: Affects escape path viability

### Event System
- **Random events**: Currently 30-50% chance on WORK/HUSTLE, needs content
- **Event consequences**: Manager demands, CEO interventions, team dynamics
- **Event rewards**: Rare duck recovery, bug mitigation (without fixing)

### Victory Paths (Act 2)
- **Pure grind**: $5K saved, quit and live off savings briefly
- **Balanced**: $3K + 75% escape = funded runway + some traction
- **Startup viable**: $2K + 100% escape = startup has revenue/funding

### Polish & Juice
- **Visual feedback**: Better animations for state changes
- **Sound design**: Corporate ambience, notification sounds
- **Particle effects**: Duck loss, bug accumulation
- **Screen shake**: Game over, critical moments

---

## Won't Do (Design Constraints)

- ❌ **Bug reduction**: Bugs are permanent, no DEBUG action ever
- ❌ **Pause/save system**: Single-session roguelike (for now)
- ❌ **Multiple simultaneous tasks**: Keep it simple, one task at a time
- ❌ **Skill-based work speed**: Death spiral must stay intact
