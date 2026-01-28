# Visual Guide: Description Text Positioning Fix

## Before the Fix

### Default Frame (120x160)
```
┌────────────────┐
│                │
│  Picture       │  Frame: 120x160 pixels
│  Frame         │
│                │
└────────────────┘  ← Frame bottom at y=160
        ↓ 10px
  [Description Text]  ← Text at y=170 ✓ CORRECT
```

### Scaled Frame (220x220) - BROKEN
```
┌────────────────────────┐
│                        │
│                        │
│  Picture               │
│  Frame                 │
│  (Scaled)              │
│       [Description Text]  ← Text at y=170 ✗ WRONG (inside frame!)
│                        │
│                        │
└────────────────────────┘  ← Frame bottom at y=220
```

**Problem**: Text position was hardcoded at y=170, which worked for default frames but appeared inside scaled frames.

---

## After the Fix

### Default Frame (120x160)
```
┌────────────────┐
│                │
│  Picture       │  Frame: 120x160 pixels
│  Frame         │
│                │
└────────────────┘  ← Frame bottom at y=160
        ↓ 10px
  [Description Text]  ← Text at y=170 ✓ CORRECT (size.y + 10)
```

### Scaled Frame (220x220) - FIXED
```
┌────────────────────────┐
│                        │
│                        │
│  Picture               │
│  Frame                 │
│  (Scaled)              │
│                        │
│                        │
│                        │
└────────────────────────┘  ← Frame bottom at y=220
        ↓ 10px
   [Description Text]  ← Text at y=230 ✓ CORRECT (size.y + 10)
```

**Solution**: Text position is now dynamically calculated as `size.y + 10`, so it always appears 10 pixels below the frame regardless of its size.

---

## Text Width Adaptation

### Small Frame (120x160)
```
┌────────────────┐
│  Picture Frame │
└────────────────┘
 [Description Text is wider]  ← Width: 220px (size.x + 100, clamped to 200-320)
```

### Large Frame (220x220)
```
┌────────────────────────┐
│    Picture Frame       │
└────────────────────────┘
   [Description Text adapts]  ← Width: 320px (maximum)
```

**Benefit**: Text width adapts to frame size for better appearance and prevents overlapping with adjacent frames.

---

## Manual Positioning Feature

### Default Behavior (use_custom_description_position = false)
```
Player approaches frame → Automatic positioning applies
Frame is scaled → Text repositions automatically ✓
```

### Custom Positioning Enabled (use_custom_description_position = true)
```
User drags text in editor → Position saved in scene
Frame loads → Custom position preserved ✓
Frame is scaled → Custom position still preserved ✓
```

---

## How It Works

### Code Flow
```
_ready()
  ├─ Has custom texture?
  │  ├─ YES → scale_frame_to_texture()
  │  │         └─ use_custom_description_position?
  │  │            ├─ NO → position_description_text_under_frame()
  │  │            └─ YES → Keep manual position
  │  └─ NO → use_custom_description_position?
  │           ├─ NO → position_description_text_under_frame()
  │           └─ YES → Keep manual position
```

### Position Calculation
```gdscript
// Old (hardcoded)
offset_top = 170  // Fixed value

// New (dynamic)
offset_top = size.y + 10  // Adapts to frame size

// Text width (adaptive)
text_width = clamp(size.x + 100, 200, 320)
offset_left = (size.x - text_width) / 2
offset_right = (size.x + text_width) / 2
```

---

## Key Improvements

1. ✅ **Dynamic Positioning**: Text position adapts to frame size
2. ✅ **Adaptive Width**: Text width scales with frame (200-320px)
3. ✅ **Custom Control**: Users can override with manual positioning
4. ✅ **Backward Compatible**: Existing scenes work without changes
5. ✅ **Well Documented**: Clear instructions in code and guides

---

## Testing Verification

| Frame Type | Frame Size | Text Position | Status |
|------------|-----------|---------------|---------|
| Default | 120x160 | y=170 (160+10) | ✅ PASS |
| Scaled Small | 150x150 | y=160 (150+10) | ✅ PASS |
| Scaled Medium | 200x200 | y=210 (200+10) | ✅ PASS |
| Scaled Large | 220x220 | y=230 (220+10) | ✅ PASS |
| Custom Position | Any | User-defined | ✅ PASS |

All test cases verified and working correctly.
