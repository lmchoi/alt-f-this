# UI Juice Improvements Plan

Quick visual feedback improvements to make progress feel more satisfying.

---

## Answer: Yes, Do Layout Redesign First

**Reasoning:**
- Your compact redesign (commit 5332982) already improves visual hierarchy
- Actions are now spatially connected to what they affect
- Better foundation for adding juice - don't add animations to old layout
- Juice should enhance the final layout, not patch a bad one

**Order:** Layout redesign → Juice improvements → Ship MVP

---

## Juice Improvements (Post-Redesign)

### 1. Animated Progress Bar Fill
**What:** Progress bar smoothly animates when value changes (instead of instant jump)

**Implementation:**
- Use Godot `Tween` to animate `ProgressBar.value` over 0.3-0.5s
- Add easing (ease_out) for satisfying "chunk of work done" feel
- Works for both task progress and side project progress

**Files to modify:**
- `scenes/task_panel_compact.gd` - add tween in `_update_progress()`
- `scenes/side_project_panel_compact.gd` - same

**Effort:** 20 lines of code, 10 mins

---

### 2. "Working..." Status Indicator
**What:** Show visual feedback when WORK button is clicked

**Implementation:**
- Add small Label near progress percentage
- Shows "Working..." with animated dots: `.` → `..` → `...` (loop)
- Appears when action starts, fades after 1-2 seconds
- Alternative: Change button text to "Working..." while disabled

**Files to modify:**
- `scenes/task_panel_compact.tscn` - add Label node
- `scenes/task_panel_compact.gd` - animate dots with Timer

**Effort:** 30 lines of code, 15 mins

---

### 3. Button Press Feedback
**What:** Buttons react when clicked

**Implementation:**
- Scale down slightly on press (0.95), scale back to 1.0
- Optional: Brief flash/highlight effect
- Use Tween for smooth animation (0.1s)

**Files to modify:**
- `scenes/task_panel_compact.gd` - add button press animations
- `scenes/side_project_panel_compact.gd` - same for HUSTLE

**Effort:** 15 lines of code, 10 mins

---

### 4. Progress Bar Shimmer (Optional, Nice-to-Have)
**What:** Subtle shine effect sweeps across filled portion of bar

**Implementation:**
- Add AnimatedTexture or shader to progress bar
- Sweeps left-to-right every 2-3 seconds
- Only shows on filled portion

**Files to modify:**
- `scenes/task_panel_compact.tscn` - add shader or overlay
- Custom shader code

**Effort:** 1 hour (shader work), skip for MVP

---

### 5. Risk Badge Pulse (Optional)
**What:** "VERY RISKY" badge pulses to draw attention

**Implementation:**
- Scale animation (1.0 → 1.05 → 1.0) every 1s
- Only when risk is high
- Use modulate for subtle glow effect

**Files to modify:**
- `scenes/task_panel_compact.gd` - add pulse tween

**Effort:** 20 lines, 10 mins

---

## Recommended Implementation Order

### Ship Blockers (Must Have):
1. **Animated progress bar** - Makes working feel satisfying
2. **Button press feedback** - Confirms actions registered

### Nice to Have (If time):
3. **Working indicator** - Extra clarity
4. **Risk badge pulse** - Draw attention to danger

### Skip for MVP:
5. **Progress bar shimmer** - Polish, not essential

---

## Total Time Estimate

- **Must have:** 30-40 mins
- **Nice to have:** +20-30 mins
- **Total for solid juice:** ~1 hour

---

## Testing Checklist

After adding juice:
- [ ] Progress bar animates smoothly (not instant)
- [ ] Buttons scale on click
- [ ] Animations don't interfere with rapid clicking
- [ ] Still feels responsive (animations don't slow gameplay)
- [ ] Works in timed mode (fast action spam)

---

## Next Steps After Juice

1. **Integrate compact UI** into main game (replace old panels)
2. **Test full game loop** with new layout + juice
3. **Export browser build** for itch.io
4. **Ship MVP** and gather playtester feedback

See [playtesting-resources.md](playtesting-resources.md) for where to find testers.
