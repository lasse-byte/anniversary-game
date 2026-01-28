# Adding Repeating Textures to Backgrounds and Floors

## Overview

All rooms in the anniversary game now support repeating textures for backgrounds and floors. This guide explains how to add and configure textures.

## How It Works

The room scripts (`room.gd` and `room_final.gd`) now support texture assignment through export variables:

- **background_texture**: Texture2D for the room background
- **floor_texture**: Texture2D for the floor (not available in room6/final room)
- **room_color**: Fallback color if no texture is assigned

## Adding Textures to Rooms

### Step 1: Prepare Your Texture

1. Create or obtain a tileable texture image (PNG, JPG, etc.)
2. Place the texture file in your project folder
3. In Godot, select the texture file and configure import settings:
   - **Repeat**: Enable (important for tiling!)
   - **Filter**: Nearest (for pixel art) or Linear (for smooth textures)

### Step 2: Assign Texture in Godot Editor

1. Open a room scene (e.g., `room1.tscn`) in Godot
2. Select the root node (e.g., "Room1")
3. In the Inspector panel, find the **Script Variables** section
4. You'll see these exported variables:
   - `Background Texture`
   - `Floor Texture` (rooms 1-5 only)
   - `Room Color` (fallback)

5. Click on the empty texture slot and select your texture file
6. Save the scene (Ctrl+S or Cmd+S)

### Step 3: Test

1. Run the game (F5)
2. The texture should tile/repeat across the background and floor
3. If textures don't repeat, check the import settings (Step 1)

## Technical Details

### How Textures Are Applied

When a room loads, the `_ready()` function checks for assigned textures:

```gdscript
func _ready():
    # For background
    if background_texture:
        # Converts ColorRect to TextureRect with STRETCH_TILE mode
        convert_to_texture_rect($ColorRect, background_texture)
    else:
        # Uses solid color
        $ColorRect.color = room_color
    
    # For floor (rooms 1-5)
    if floor_texture:
        convert_floor_to_texture_rect($Floor/ColorRect, floor_texture)
```

### Texture Stretch Mode

The textures use `STRETCH_TILE` mode, which repeats the texture to fill the entire area. This is perfect for:
- Seamless patterns
- Tile textures
- Repeating backgrounds
- Floor patterns

### Fallback Behavior

If no texture is assigned:
- Background uses `room_color` (the colored rectangle)
- Floor uses its existing color
- This maintains backward compatibility with existing rooms

## Room-Specific Notes

### Rooms 1-5 (Regular Rooms)

These rooms support both:
- **Background texture**: Full room background (e.g., 5400×800)
- **Floor texture**: Floor section only (e.g., 5400×100)

### Room 6 (Final Room)

The final room only supports:
- **Background texture**: Full screen (1280×720)
- No floor texture (no floor in this room)

## Example Textures

### Good Texture Sizes

For best results, use textures that are:
- **Power of 2**: 32×32, 64×64, 128×128, 256×256, etc.
- **Seamless**: Edges tile properly when repeated
- **Small enough**: Don't need to be as large as the room

Examples:
- 64×64 tile pattern for floor
- 128×128 pattern for background
- 256×256 detailed texture

### Creating Seamless Textures

Use image editing tools with "offset" or "make seamless" features:
- GIMP: Filters → Map → Make Seamless
- Photoshop: Filter → Other → Offset (manual check)
- Krita: Filters → Other → Tile

## Texture Import Settings

Critical settings in Godot for repeating textures:

```
Import Settings:
├─ Repeat: Enabled (MUST be enabled!)
├─ Filter: Nearest (pixel art) or Linear (smooth)
├─ Mipmaps: Optional
└─ Compress: Based on platform needs
```

To change import settings:
1. Select texture file in FileSystem
2. Click "Import" tab (next to Scene tab)
3. Change "Repeat" to "Enabled"
4. Click "Reimport"

## Code Reference

### room.gd Export Variables

```gdscript
@export var year_number: int = 1
@export var room_color: Color = Color.WHITE
@export var next_room_scene: PackedScene = null
@export var background_texture: Texture2D = null  # NEW
@export var floor_texture: Texture2D = null       # NEW
```

### room_final.gd Export Variables

```gdscript
@export var room_color: Color = Color.WHITE
@export var background_texture: Texture2D = null  # NEW
```

## Troubleshooting

### Texture Doesn't Repeat

**Problem**: Texture appears stretched instead of repeated

**Solution**: 
1. Check texture import settings
2. Ensure "Repeat" is enabled
3. Reimport the texture

### Texture Appears Blurry

**Problem**: Texture looks blurry or pixelated

**Solution**:
1. For pixel art: Set "Filter" to "Nearest"
2. For smooth art: Set "Filter" to "Linear"
3. Reimport the texture

### Texture Not Showing

**Problem**: Background still shows solid color

**Solution**:
1. Verify texture is assigned in Inspector
2. Check that texture file exists
3. Look for errors in Output console (F9)
4. Ensure texture import succeeded

### Seams Visible

**Problem**: Lines or seams visible where texture repeats

**Solution**:
1. Use a seamless texture
2. Check texture edges align properly
3. Consider using "Clamp to Edge" if texture has borders

## Example Workflow

### Adding a Brick Pattern to Room 1 Floor

1. **Create/Find Texture**
   - Get a seamless brick texture (e.g., `brick_64x64.png`)
   - Place in project folder

2. **Configure Import**
   ```
   Select brick_64x64.png in FileSystem
   → Import tab
   → Repeat: Enabled
   → Filter: Nearest (for sharp bricks)
   → Reimport
   ```

3. **Assign to Room**
   ```
   Open room1.tscn
   → Select "Room1" node
   → Inspector → Script Variables
   → Floor Texture: (drag brick_64x64.png)
   → Save scene
   ```

4. **Test**
   ```
   Press F5 to run
   → Floor should show repeating brick pattern
   ```

## Advanced Usage

### Combining Textures and Colors

You can use textures in some rooms and colors in others:
- Room 1: Brick texture floor, solid color background
- Room 2: Solid color floor, pattern texture background
- Room 3: Both textures
- Room 4: Both solid colors

### Animated Textures

For animated backgrounds, you could:
1. Use an animated texture (AnimatedTexture)
2. Assign to background_texture
3. The tiling will work with animations too

### Per-Room Customization

Each room can have different textures:
```
Room 1: Wood floor, sky background
Room 2: Stone floor, clouds background  
Room 3: Grass floor, sunset background
Room 4: Tile floor, stars background
Room 5: Carpet floor, hearts background
```

## Performance Considerations

### Texture Size

- Smaller textures (64×64, 128×128) tile more times
- Larger textures (512×512) tile fewer times
- Use smallest texture that looks good

### Memory Usage

- Each unique texture uses memory
- Shared textures across rooms save memory
- Compressed textures reduce file size

### Best Practices

1. **Reuse textures** across rooms when possible
2. **Keep textures small** (power of 2, seamless)
3. **Test on target platform** for performance
4. **Use appropriate compression** for platform

## Summary

The texture system provides:
- ✅ Easy texture assignment via Inspector
- ✅ Automatic texture tiling/repeating
- ✅ Fallback to solid colors
- ✅ Per-room customization
- ✅ Support for both background and floor
- ✅ Backward compatible with existing rooms

Enjoy creating beautiful, textured rooms! 🎨
