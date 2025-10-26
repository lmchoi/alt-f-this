class_name UIColors
## Centralized color constants for UI theming
##
## Three distinct themes:
## - Core UI: Gold/Blue for HUD elements
## - Job/Work: Silver/Blue-Grey for corporate grind
## - Escape: Gold/Warm for freedom/banana theme

# ============================================================================
# CORE UI THEME (Gold/Blue) - Universal HUD elements
# ============================================================================

const CORE_GOLD = Color(0.9, 0.75, 0.3, 1)          # Top bar accents, money/ducks
const CORE_GOLD_BRIGHT = Color(1.0, 0.8, 0.4, 1)    # Hover/pressed states
const CORE_BLUE_TINT = Color(0.05, 0.08, 0.12, 1)   # Screen background
const CORE_BG_DARK = Color(0.08, 0.08, 0.1, 1)      # Top bar background

# ============================================================================
# JOB/WORK THEME (Silver/Blue-Grey) - Corporate grind
# ============================================================================

const JOB_PANEL_BG = Color(0.12, 0.12, 0.15, 1)          # Task/job panel backgrounds
const JOB_BORDER = Color(0.6, 0.6, 0.65, 1)              # Task panel border (medium)
const JOB_BORDER_BRIGHT = Color(0.75, 0.75, 0.8, 1)      # Job info/button border (brighter)
const JOB_BORDER_BRIGHTEST = Color(0.85, 0.85, 0.9, 1)   # Hover state

const JOB_SILVER = Color(0.75, 0.75, 0.8, 1)             # Headers, button text
const JOB_SILVER_BRIGHT = Color(0.85, 0.85, 0.9, 1)      # Hover text
const JOB_SILVER_BRIGHTEST = Color(0.9, 0.9, 0.95, 1)    # Pressed text

const JOB_INFO_BLUE = Color(0.6, 0.75, 0.85, 1)          # Info text, progress bar
const JOB_BG_VERY_DARK = Color(0.05, 0.05, 0.08, 1)      # Progress bar bg, very dark areas
const JOB_BG_MEDIUM = Color(0.15, 0.15, 0.18, 1)         # Dialogs, hover states

# ============================================================================
# ESCAPE/SIDE PROJECT THEME (Gold/Warm) - Freedom/banana theme
# ============================================================================

const ESCAPE_GOLD = Color(0.9, 0.7, 0.3, 1)              # Same as CORE_GOLD (side hustle button)
const ESCAPE_GOLD_BRIGHT = Color(1.0, 0.8, 0.4, 1)       # Hover/pressed
const ESCAPE_GOLD_BRIGHTEST = Color(1.0, 0.85, 0.5, 1)   # Brightest state

const ESCAPE_WARM_BROWN = Color(0.15, 0.12, 0.08, 1)     # Side project panel background

# ============================================================================
# STATUS COLORS (Shared across themes)
# ============================================================================

const STATUS_GREEN = Color(0.2, 0.8, 0.2, 1)             # Success, ready to ship
const STATUS_YELLOW = Color(0.8, 0.8, 0.2, 1)            # Warnings, urgency
const STATUS_ORANGE = Color(0.8, 0.4, 0.2, 1)            # Problems, bugs
const STATUS_RED = Color(0.8, 0.2, 0.2, 1)               # Critical, overdue, defeat

const TEXT_SUBDUED = Color(0.7, 0.7, 0.7, 1)             # Less important text

# ============================================================================
# BUTTON BACKGROUNDS (Shared - Pure Neutral Grey)
# ============================================================================

const BTN_BG_DARK = Color(0.06, 0.06, 0.06, 1)           # Normal state
const BTN_BG_HOVER = Color(0.11, 0.11, 0.11, 1)          # Hover state
const BTN_BG_DISABLED = Color(0.06, 0.06, 0.06, 0.5)     # Disabled (50% opacity)

# ============================================================================
# SHADOW/EFFECTS
# ============================================================================

const SHADOW_GREY = Color(0.4, 0.4, 0.45, 0.3)           # Panel shadows
const SHADOW_GOLD = Color(0.6, 0.6, 0.65, 0.3)           # Job panel shadow (lighter)
