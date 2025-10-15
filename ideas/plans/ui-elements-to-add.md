# UI Elements to Add in Godot Editor

Quick reference for adding bugs system UI elements.

---

## Option 1: Add via Scene Tree (Recommended)

### Add BugsLabel

1. Open `scenes/game_ui.tscn`
2. In Scene tree, find the node that contains `DayLabel`, `MoneyLabel`, `SalaryLabel`
3. Right-click that parent node → Add Child Node → Label
4. Name it: `BugsLabel`
5. In Inspector:
   - Text: `🐛 0`
   - Check "Unique Name in Owner" (the % checkbox)
6. Position it in the viewport near other stats
7. Save scene (Ctrl+S)

### Add DebugButton

1. In same scene, find `WorkButton` and `SlackButton`
2. Right-click their parent → Add Child Node → Button
3. Name it: `DebugButton`
4. In Inspector:
   - Text: `Debug`
   - Script: Attach `res://scripts/ui/action_button.gd`
   - Check "Unique Name in Owner" (%)
5. Position it below or next to other buttons
6. Save scene

---

## Option 2: Duplicate Existing Nodes (Faster)

### For BugsLabel:
1. Right-click `DayLabel` or `MoneyLabel` → Duplicate
2. Rename to `BugsLabel`
3. Change text to `🐛 0`
4. Reposition
5. Ensure "Unique Name" is checked

### For DebugButton:
1. Right-click `WorkButton` → Duplicate
2. Rename to `DebugButton`
3. Change text to `Debug`
4. Reposition
5. Ensure "Unique Name" is checked

---

## Option 3: Manual .tscn Edit (Advanced - Use with Caution!)

**Only if you're comfortable with .tscn files:**

Open `scenes/game_ui.tscn` in a text editor and add this node definition in the appropriate parent section.

⚠️ **WARNING**: Make a backup first! This can break your scene.

**For BugsLabel** (add near other Label nodes):
```
[node name="BugsLabel" type="Label" parent="<PARENT_PATH_HERE>"]
unique_name_in_owner = true
text = "🐛 0"
```

**For DebugButton** (add near other Button nodes):
```
[node name="DebugButton" type="Button" parent="<PARENT_PATH_HERE>"]
unique_name_in_owner = true
text = "Debug"
script = ExtResource("<ID_OF_ACTION_BUTTON_SCRIPT>")
```

You'd need to figure out:
- Correct parent path
- Correct ExtResource ID for action_button.gd script
- Layout properties to position it

This is why using the Godot Editor is safer!

---

## Verification

After adding elements, check:

1. **Scene Tree** shows:
   - `BugsLabel` with % icon
   - `DebugButton` with % icon

2. **In game_ui.gd**, these lines should not error:
   ```gdscript
   @onready var bugs_label := $"%BugsLabel"
   @onready var debug_button := $"%DebugButton" as ActionButton
   ```

3. **Run the game** - no errors about missing nodes

---

## If You Get Stuck

Run the game first! Godot will tell you exactly what's missing:

```
Error: Node not found: "%BugsLabel"
```

This tells you which element still needs to be added in the editor.

---

## Time Estimate

- **Option 1 or 2**: 2-3 minutes in Godot Editor
- **Option 3**: 5-10 minutes of careful .tscn editing (risky!)

Recommend Option 2 (duplicate existing nodes) - fastest and safest!
