# TODO

## Layout Refactor Sprint

**Goal:** Reorder UI to emphasize escape goal, prepare for task piling

**Phase 4: Document future work**
- Task queue panel (for real-time task piling)
- Empty space already exists for bugs to crawl

---

## Backlog

1. Implement random 'caught hustling' event (30% chance on HUSTLE)
2. Add event dialog for caught/lie/ignore choices
3. Random event when beg for mercy
4. Need indicator for time bombs?
5. ~~Implement task category mechanics (Critical/Optics/Tech Debt)~~ ✅ DONE

---

## Future (See [future-ideas.md](future-ideas.md))

After core HUSTLE loop is validated:
- Real-time pivot (60s timer, bugs crawling, message interrupts)
- Named NPCs with relationships
- Act 2 (become the boss)
- 8/10 → 10/10 features


--

## Questions
- how should duck be used?
  - Answer: Ducks = patience/sanity/fucks-to-give (see game-design.md line 40)
  - Lost on: poor quality ships, caught hustling, outages, boss events
  - Gained on: rare excellent quality ships (90%+)

## Bugs/Improvements - Priority Order

### Critical (Breaks Core Loop)
2. **beg for mercy doesn't do anything** - Needs implementation or removal

### Medium Priority (Better Game Feel)
9. **instead of getting fired on 3 days overdue** - Strike system: force new task, track strikes, fire on 3 strikes (needs indicator)
10. **fired dialog should not be rage quit** - Should be "You've been let go" / "Performance issues"
11. **rage quit when out of ducks** - 0 ducks = burnout = rage quit ending (proper flavor)
12. **promotion (increase job_level) after X tasks** - Every 5-10 tasks? Affects difficulty scaling

### Low Priority (Polish)
13. **production outage dialog is too wide** - Layout fix
14. **hustle progress bar instead** - Visual feedback for side project (already exists in panel?)


--

game over dialog takes priority - should only show that
