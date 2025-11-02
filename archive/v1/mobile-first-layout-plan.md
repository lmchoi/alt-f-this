# Mobile-First Layout Plan (v2)

Redesign UI for mobile-first vertical layout, optimized for timed mode + interruptions.

---

## Design Philosophy

**Mobile-First:**
- Portrait orientation primary (720x1280 reference)
- One-handed playable (thumb reach zones)
- Big tap targets (44pt minimum)
- Vertical stacking (no side-by-side panels)

**Desktop Secondary:**
- Same layout, just scales up
- Works in narrow window (like mobile)
- Optional: wider layout for desktop (future)

---

## Visual Hierarchy (Top → Bottom)

```
┌─────────────────────────────────────────┐
│ 1. TOP BAR (stats + timer)              │  Always visible
├─────────────────────────────────────────┤
│ 2. INTERRUPTIONS (if any)               │  Blocks view when present
├─────────────────────────────────────────┤
│ 3. TASK PANEL (progress + actions)      │  Primary focus (60% screen)
├─────────────────────────────────────────┤
│ 4. STATUS PANELS (escape + job)         │  Secondary info (20% screen)
└─────────────────────────────────────────┘
```

---

## Component Breakdown (v2)

### 1. Top Bar (Keep Existing)
**Current:** `scenes/top_bar.tscn`
**Changes:** None needed (already works well)
- Money, ducks, timer, day
- Font size already large (32px)

---

### 2. Interruption Card v2
**New file:** `scenes/interruption_card_v2.tscn`

**Layout:**
```
┌─────────────────────────────────────────┐
│  🔔 CEO wants status update             │
│                                         │
│  "Where are we on this?"                │
│                                         │
│  [        TAP TO RESPOND        ]       │
│           ↑ Full width button           │
└─────────────────────────────────────────┘
```

**Features:**
- Full width (minus margins)
- Pulsing animation when new
- Count badge if multiple: "🔔 (2)"
- Min height: 120px (easy to tap)

**Changes from v1:**
- Remove "[Click to view]" small text
- Make entire card tappable (not just button)
- Larger text (24px title, 20px message)
- More padding (16px all sides)

---

### 3. Task Panel v2
**New file:** `scenes/task_panel_v2.tscn`

**Layout:**
```
┌─────────────────────────────────────────┐
│ Update Slack Status                     │
│ Due: 2d  |  🍝  |  🔧 15 bugs           │
│                                         │
│        ████████████░░░░░░░              │
│                                         │
│                 41%                     │
│             HALF-BAKED                  │
│                                         │
│ 🔴━━━┃🟠━━━━━┃🟡━━━━┃🟢━━━             │
│    20%    50%   90%                     │
│                                         │
│ ┌─────────────────┐ ┌─────────────────┐│
│ │                 │ │                 ││
│ │    WORK ⚙️      │ │   SHIP IT 🚢    ││
│ │                 │ │                 ││
│ └─────────────────┘ └─────────────────┘│
│  ↑ Min height: 60px each                │
└─────────────────────────────────────────┘
```

**Key Specs:**
- **Progress %:** 48px font (massive, center-aligned)
- **Quality text:** 24px ("HALF-BAKED", "VERY RISKY", etc.)
- **Progress bar:** 100px tall (chonky)
- **Buttons:** 60px tall, full width each (side-by-side)
- **Quality gradient:** Visible segments with markers
- **Task title:** 28px (readable but not dominant)
- **Metadata:** 20px (due date, complexity, bugs)

**Changes from v1:**
- Remove description entirely (never show)
- Progress % becomes hero element
- Quality zones with visual segment markers
- Buttons 2x larger
- More vertical padding between elements

---

### 4. Status Panels v2 (Escape + Job)
**New files:**
- `scenes/escape_panel_v2.tscn`
- `scenes/job_panel_v2.tscn`

**Layout (Side by Side):**
```
┌───────────────────┐  ┌───────────────────┐
│ 🚀 ESCAPE         │  │ 👨‍💻 Junior Dev    │
│                   │  │                   │
│ ▓▓░░░░░░░░        │  │ Payday: 4d        │
│ 0% ($0/$5K)       │  │ Salary: $300      │
│                   │  │ Bugs: 🔧 15       │
│ [    HUSTLE    ]  │  │                   │
└───────────────────┘  └───────────────────┘
    ↑ Each panel ~50% width, compressed
```

**Alternative (If too cramped, stack vertically):**
```
┌─────────────────────────────────────────┐
│ 🚀 ESCAPE: 0% ($0/$5K)  [  HUSTLE  ]    │
└─────────────────────────────────────────┘
┌─────────────────────────────────────────┐
│ 👨‍💻 Junior Dev | Pay: 4d ($300) | 🔧 15 │
└─────────────────────────────────────────┘
```

**Key Specs:**
- **Height:** 100-120px each (compressed vs current 200px)
- **Font size:** 20px (smaller than task panel)
- **HUSTLE button:** 50px tall (smaller than WORK/SHIP IT)
- **Progress bar:** 40px tall (half size of task progress)

**Changes from v1:**
- Much smaller overall
- Less visual weight (de-emphasized)
- Inline text where possible (no multi-line waste)
- Optional: collapse job panel to single info bar

---

### 5. Main Game UI v2
**New file:** `scenes/game_ui_v2.tscn`

**Layout Structure:**
```
VBoxContainer (full screen)
├─ TopBar
├─ ScrollContainer (if needed for small screens)
│  └─ VBoxContainer
│     ├─ InterruptionStack (VBoxContainer)
│     │  └─ [InterruptionCardV2 instances]
│     ├─ MarginContainer (16px)
│     │  └─ TaskPanelV2
│     ├─ MarginContainer (8px)
│     │  └─ HBoxContainer
│     │     ├─ EscapePanelV2
│     │     └─ JobPanelV2
└─ (Dialogs as overlays)
```

**Spacing:**
- Top bar: No margin (edge-to-edge)
- Interruptions: No margin (edge-to-edge, urgent)
- Task panel: 16px side margins
- Status panels: 8px margins (less prominent)
- Between sections: 12px gap

---

## Screen Size Targets

### Mobile Portrait (Primary)
- **Width:** 360-428px (iPhone SE to iPhone Pro Max)
- **Height:** 640-926px
- **Safe area:** Account for notch/home indicator
- **Font scaling:** Use dynamic type (adjust for readability)

### Desktop (Secondary)
- **Min width:** 400px (mobile-like)
- **Max width:** 600px (center on screen, add margins)
- **Height:** 800px+ (scrollable if needed)

---

## Component Implementation Order

### Phase 1: Core Components
1. **TaskPanelV2** - Most important, test button sizes
2. **InterruptionCardV2** - Test prominence
3. **GameUI_V2** - Wire up v2 components

### Phase 2: Secondary Components
4. **EscapePanelV2** - Compressed layout
5. **JobPanelV2** - Compressed layout

### Phase 3: Integration
6. Test in actual game (wire signals)
7. Test on actual mobile device (export Android APK)
8. Adjust sizes based on real thumb reach

---

## Mobile-Specific Considerations

### Touch Targets
- **Minimum:** 44pt (58px on 1x displays)
- **Comfortable:** 60px+ for primary actions
- **Spacing:** 8px minimum between tappable elements

### Typography
- **Large text:** 48px (progress %)
- **Body text:** 20-24px (readable at arm's length)
- **Small text:** 18px minimum (metadata)

### Thumb Reach Zones
```
┌─────────────────────────┐
│ 🚫 Hard to reach        │  Top 1/4 (safe for read-only)
├─────────────────────────┤
│ ✅ Easy to reach        │  Middle 2/4 (primary actions)
├─────────────────────────┤
│ ✅ Easy to reach        │  Bottom 1/4 (important actions)
└─────────────────────────┘
```

**Action placement:**
- WORK/SHIP IT buttons: Middle-bottom (thumb sweet spot)
- Interruptions: Top-middle (forces attention, still reachable)
- HUSTLE: Bottom (less frequent, still reachable)

### Performance
- **Target:** 60fps on mid-range Android (2020+)
- **Max nodes:** Keep scene tree shallow
- **Animations:** Use Tween (not AnimationPlayer for simple stuff)
- **Textures:** Use StyleBox for UI (not PNG sprites)

---

## Testing Checklist

After implementing v2:

### Visual Tests
- [ ] Progress % readable from 2 feet away
- [ ] Buttons easy to tap without looking
- [ ] Quality gradient clearly shows risk zones
- [ ] Interruptions impossible to miss

### Functional Tests
- [ ] All buttons respond immediately (<100ms)
- [ ] No accidental mis-taps
- [ ] Scrolling smooth if content overflows
- [ ] Timer visible while scrolling (if needed)

### Device Tests
- [ ] iPhone SE (smallest screen)
- [ ] iPhone Pro Max (largest screen)
- [ ] Android mid-range (test performance)
- [ ] Landscape orientation (should work, but not primary)

---

## Migration Strategy

**Don't delete v1 files!** Keep them for comparison.

**File naming:**
- `task_panel.tscn` → Keep as-is (v1)
- `task_panel_v2.tscn` → New mobile-first version
- `game_ui.tscn` → Keep as-is (v1)
- `game_ui_v2.tscn` → New mobile-first layout

**Once v2 is validated:**
- Rename v1 files to `*_v1_backup.tscn`
- Rename v2 files to remove `_v2` suffix
- Update project.godot to use new main scene

---

## Next Steps

1. Start with **TaskPanelV2** (biggest impact)
2. Test button sizes in isolation scene
3. Wire up to GameManager signals (copy from v1)
4. Add to game_ui_v2 and test in actual gameplay
5. Export Android APK and test on real phone
6. Iterate on sizes based on real thumb testing

See [juice-improvements-plan.md](juice-improvements-plan.md) for animation polish after layout is solid.
