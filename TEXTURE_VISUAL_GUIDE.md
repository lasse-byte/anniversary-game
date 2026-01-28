# Texture System Visual Guide

## How It Works

### Before (Solid Colors Only)
```
┌────────────────────────────────────────────────────────┐
│                                                        │
│          SOLID COLOR BACKGROUND                        │
│                                                        │
│                                                        │
│   👤 Player walks here                                │
│                                                        │
├════════════════════════════════════════════════════════┤
│          SOLID COLOR FLOOR                             │
└────────────────────────────────────────────────────────┘
```

### After (With Repeating Textures)
```
┌────────────────────────────────────────────────────────┐
│ ☁️☁️☁️☁️☁️☁️☁️☁️☁️☁️  REPEATING BACKGROUND TEXTURE    │
│ ☁️☁️☁️☁️☁️☁️☁️☁️☁️☁️  (e.g., clouds, sky pattern)     │
│ ☁️☁️☁️☁️☁️☁️☁️☁️☁️☁️                                    │
│ ☁️☁️☁️☁️☁️☁️☁️☁️☁️☁️                                    │
│   👤 Player walks here                                │
│ ☁️☁️☁️☁️☁️☁️☁️☁️☁️☁️                                    │
├════════════════════════════════════════════════════════┤
│ 🟫🟫🟫🟫🟫🟫🟫🟫🟫🟫  REPEATING FLOOR TEXTURE        │
└────────────────────────────────────────────────────────┘
       (e.g., wood, stone, grass pattern)
```

## Architecture

### ColorRect → TextureRect Conversion

**BEFORE (In Scene File)**:
```
[node name="ColorRect" type="ColorRect" parent="."]
offset_right = 5400.0
offset_bottom = 800.0
color = Color(0.9, 0.85, 0.9, 1)
```

**AFTER (Runtime Conversion)**:
```
[node name="TextureRect" type="TextureRect" parent="."]
texture = preload("res://your_texture.png")
stretch_mode = STRETCH_TILE  ← Key: Makes texture repeat!
offset_right = 5400.0
offset_bottom = 800.0
```

## Code Flow

### When Room Loads

```
_ready() called
    ↓
Check if background_texture assigned?
    ↓
YES → Convert ColorRect to TextureRect
    ↓
Set texture property
    ↓
Set stretch_mode = STRETCH_TILE
    ↓
Texture repeats across entire area! ✅
    ↓
NO → Keep ColorRect with solid color
```

### Conversion Process

```gdscript
func convert_to_texture_rect(color_rect: ColorRect, texture: Texture2D):
    1. Get position and size from ColorRect
    2. Create new TextureRect
    3. Assign texture
    4. Set STRETCH_TILE mode  ← Magic happens here!
    5. Copy position/size
    6. Replace in scene tree
    7. Remove old ColorRect
```

## Texture Tiling Examples

### Small Texture (64×64) on Large Area (5400×800)

**Texture**: 64×64 pixels
**Area**: 5400×800 pixels

**Horizontal repeats**: 5400 ÷ 64 = 84.375 times
**Vertical repeats**: 800 ÷ 64 = 12.5 times

```
┌─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┐
│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│  ← 84 times horizontally
├─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┤
│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│
├─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┤
│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│T│
└─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┘
   ↑
12 times vertically
```

Each "T" represents one instance of the 64×64 texture.

### Seamless vs Non-Seamless

**Seamless Texture** (Good ✅):
```
Edge A                   Edge B
┌─────┐                 ┌─────┐
│ ░░▓▓│ ← matches →     │░░▓▓ │
│░░▓▓░│                 │░▓▓░░│
│▓▓░░░│                 │▓░░░▓│
└─────┘                 └─────┘

When tiled:
┌─────┬─────┬─────┬─────┐
│ ░░▓▓│░░▓▓ │ ░░▓▓│░░▓▓ │  ← No seams!
│░░▓▓░│░▓▓░░│░░▓▓░│░▓▓░░│
│▓▓░░░│▓░░░▓│▓▓░░░│▓░░░▓│
└─────┴─────┴─────┴─────┘
```

**Non-Seamless Texture** (Bad ❌):
```
Edge A                   Edge B
┌─────┐                 ┌─────┐
│ ░░▓▓│ ← doesn't match →│▓▓░░ │
│░░▓▓░│                 │░░░▓▓│
│▓▓░░░│                 │░░▓▓░│
└─────┘                 └─────┘

When tiled:
┌─────┬─────┬─────┬─────┐
│ ░░▓▓│▓▓░░ │ ░░▓▓│▓▓░░ │  ← Visible seams!
│░░▓▓░│░░░▓▓│░░▓▓░│░░░▓▓│     ↑↑↑
│▓▓░░░│░░▓▓░│▓▓░░░│░░▓▓░│
└─────┴─────┴─────┴─────┘
```

## Inspector Configuration

### In Godot Editor

```
Scene Tree:          Inspector (when Room1 selected):
┌──────────────┐    ┌────────────────────────────────┐
│ Room1        │ ←  │ Script Variables               │
│ ├─ ColorRect │    │                                │
│ ├─ Label     │    │ Year Number: 1                 │
│ ├─ Floor     │    │ Room Color: [░░░░░]            │
│ ├─ Player    │    │ Next Room Scene: room2.tscn    │
│ └─ Door      │    │ Background Texture: [empty] ← Click here!
└──────────────┘    │ Floor Texture: [empty]     ← Click here!
                    └────────────────────────────────┘
```

### After Assigning Textures

```
Inspector (when Room1 selected):
┌────────────────────────────────────────┐
│ Script Variables                       │
│                                        │
│ Year Number: 1                         │
│ Room Color: [░░░░░]                    │
│ Next Room Scene: room2.tscn            │
│ Background Texture: [📷 sky.png]   ← Assigned!
│ Floor Texture: [📷 wood.png]       ← Assigned!
└────────────────────────────────────────┘
```

## Room-by-Room Application

### Rooms 1-5 (Normal Rooms)

**Size**: ~5400×800 pixels (varies)
**Has Floor**: Yes

```
Room Structure:
├─ Background (entire 5400×800 area)
│  └─ Can use background_texture
│
└─ Floor (5400×100 area at bottom)
   └─ Can use floor_texture

Both can have textures!
```

### Room 6 (Final Room)

**Size**: 1280×720 pixels (viewport size)
**Has Floor**: No

```
Room Structure:
└─ Background (entire 1280×720 area)
   └─ Can use background_texture

Only background can have texture!
```

## Example Texture Combinations

### Nature Theme
```
Room 1: Sky background (☁️), Grass floor (🌿)
Room 2: Sunset background (🌅), Stone floor (🪨)
Room 3: Night background (🌙⭐), Dirt floor (🟫)
Room 4: Dawn background (🌤️), Sand floor (🟨)
Room 5: Rainbow background (🌈), Flower floor (🌸)
```

### Abstract Theme
```
Room 1: Dots pattern, Stripes floor
Room 2: Waves pattern, Checkerboard floor
Room 3: Geometric pattern, Grid floor
Room 4: Swirls pattern, Diagonal floor
Room 5: Hearts pattern, Stars floor
```

### Seasonal Theme
```
Room 1: Spring (flowers), Green grass
Room 2: Summer (sun rays), Sand
Room 3: Autumn (leaves), Orange tiles
Room 4: Winter (snowflakes), Ice
Room 5: All seasons, Rainbow path
```

## Technical Implementation

### STRETCH_TILE Mode

```gdscript
texture_rect.stretch_mode = TextureRect.STRETCH_TILE
```

This mode tells Godot to:
1. ✅ Repeat texture horizontally
2. ✅ Repeat texture vertically
3. ✅ Fill entire area
4. ✅ No stretching or distortion
5. ✅ Seamless if texture is seamless

### Other Stretch Modes (Not Used)

```
STRETCH_SCALE:  [    T    ]  ← Stretches texture
STRETCH_KEEP:   [T          ] ← Shows once, no repeat
STRETCH_FIT:    [ T T T T  ] ← Fits width, may distort
```

We use STRETCH_TILE for proper repeating!

## Performance

### Memory Usage

**One Texture**:
- 64×64 texture = ~16 KB in memory
- Used in 5400×800 area
- Still only uses ~16 KB (texture is reused)

**Multiple Copies (Bad)**:
- Creating 84×12 separate sprites = ~200 MB!
- TextureRect with STRETCH_TILE avoids this

### Rendering

Godot efficiently tiles the texture:
- Single draw call per TextureRect
- GPU handles repeating
- No performance penalty for large areas

## Common Patterns

### Pattern 1: Sky and Ground
```
Background: clouds.png (light blue sky with clouds)
Floor: grass.png (green grass texture)
```

### Pattern 2: Indoor Scene
```
Background: wallpaper.png (decorative wall pattern)
Floor: wooden_floor.png (wood planks)
```

### Pattern 3: Abstract
```
Background: gradient_pattern.png (colored gradient)
Floor: geometric.png (geometric shapes)
```

## Summary

The texture system provides:

✅ **Easy Assignment**: Drag-and-drop in Inspector
✅ **Automatic Tiling**: STRETCH_TILE mode handles repeating
✅ **Memory Efficient**: Single texture used for entire area
✅ **Flexible**: Use textures or colors per room
✅ **Seamless**: Works with seamless textures perfectly
✅ **Performance**: GPU-accelerated tiling

Perfect for creating varied, visually rich rooms! 🎨
