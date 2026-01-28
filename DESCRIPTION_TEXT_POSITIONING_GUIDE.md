# Description Text Guide

## Recent Fix (2026-01-28): Automatic Positioning Under Frames

**FIXED:** Description text now automatically positions itself directly UNDER picture frames, regardless of frame size!

### What was fixed:
1. **Scaled frames**: When frames have custom textures and are scaled to different sizes, the description text now repositions itself to stay under the frame
2. **Default frames**: Frames without custom textures now properly position their description text 10 pixels below the frame
3. **Manual positioning**: You can now manually drag description text in the editor and it will stay where you put it (see instructions below)

### Key Changes:
- Added `position_description_text_under_frame()` function that dynamically calculates the correct position based on frame size
- Description text position is now updated whenever a frame is scaled by a custom texture
- Added `use_custom_description_position` export variable to preserve manual positioning

## How to Manually Position Description Text (Dragging)

If you want to drag the description text to a custom position and have it stay there:

1. **Open a room scene** (e.g., `room1.tscn`) in the Godot Editor
2. **Select the PictureFrame** you want to customize (e.g., "PictureFrame1")
3. **In the Inspector panel**, find the **"Script Variables"** section
4. **Check the box** for **"Use Custom Description Position"**
5. **Expand the PictureFrame node** in the scene tree (click the arrow next to it)
6. **Select the "DescriptionText" child node**
7. **Drag it** to your desired position in the editor, OR adjust the Layout properties in the Inspector:
   - `offset_top`: Vertical position
   - `offset_left`: Left edge
   - `offset_right`: Right edge
   - `offset_bottom`: Bottom edge
8. **Save the scene** (Ctrl+S or Cmd+S)

**Important:** The custom position will only persist if you have enabled "Use Custom Description Position" in step 4!

## How to Change Description Text Content

### Method 1: Edit in picture_frame.tscn (Default Text)
To change the default description text that appears for all frames:

1. Open **picture_frame.tscn** in the Godot Editor
2. In the Scene tree panel (left side), find and select the **"DescriptionText"** node
3. In the Inspector panel (right side), find the **Text** property under the Label section
4. Change the text to whatever you want (e.g., "A special memory", "Our first date", etc.)
5. Save the scene (Ctrl+S or Cmd+S)

### Method 2: Edit in Individual Room Scenes (Per-Frame Text)
To set different text for each picture frame in a room:

1. Open any room scene (e.g., **room1.tscn**, **room2.tscn**, etc.)
2. In the Scene tree, expand a PictureFrame node (e.g., "PictureFrame1")
3. Select the **"DescriptionText"** child node
4. In the Inspector panel, change the **Text** property
5. Repeat for other frames in the room
6. Save the scene

### Method 3: Using the Export Variable (Programmatic)
If you're instantiating frames via code or want to use the export variable:

1. Open the room scene
2. Select a PictureFrame node
3. In the Inspector, find the **Script Variables** section
4. Set the **Description Text** property to your custom text
5. Save the scene

**Note:** Method 1 and 2 are recommended for most users. The text you set in the editor will now persist in-game!

**Recent Fix (2026-01-28):** Previously, editing the DescriptionText in the scene editor would not persist in-game because the script was overwriting it. This has been fixed! Now your text changes in the editor will properly appear in-game.

## Changes Made

### 1. Description Text Position (UNDER the Frame) - IMPROVED FIX

The description text now **automatically positions itself under frames**, regardless of their size:

**Latest Fix (2026-01-28):**
- **Problem Solved**: Description text was appearing in the middle of scaled frames (frames with custom textures)
- **Root Cause**: When frames were scaled by `scale_frame_to_texture()`, the description text position wasn't updated
- **Solution**: 
  - Added `position_description_text_under_frame()` function that dynamically calculates position based on actual frame size
  - Description text now positions 10 pixels below the frame bottom, centered horizontally
  - Position updates automatically for both default-sized frames (120x160) and scaled frames (up to 220x220)
  
**Previous Fix:**
- **Previous position**: `offset_top = 520` (very far below)
- **Old fix position**: `offset_top = 170` (just below the 160px tall default frame)
- **Current behavior**: Dynamically calculated based on `size.y + 10` pixels

### 2. Slower Fade In Animation
The fade in animation for description text is now **slower**:
- **Previous duration**: 0.5 seconds
- **New duration**: 1.5 seconds
- File: `picture_frame.gd`, function: `fade_in_description_text()`

### 3. Slower Camera Movement
Camera movement to and from the frame is now **slower**:
- **Previous duration**: 0.5 seconds
- **New duration**: 1.5 seconds
- File: `player.gd`, functions: `enter_frame_view()` and `exit_frame_view()`

## How to Adjust Description Text Position Yourself

You can easily move the description text around by following these steps:

### Method 1: Using Godot Editor (Recommended)
1. Open **picture_frame.tscn** in the Godot Editor
2. In the Scene tree panel (left side), find and select the **"DescriptionText"** node
3. In the Inspector panel (right side), find the **Layout** section
4. Adjust these properties:
   - **offset_top**: Controls vertical position (larger number = further down)
   - **offset_bottom**: Controls the bottom edge (usually offset_top + height)
   - **offset_left**: Controls the left edge position (negative = further left)
   - **offset_right**: Controls the right edge position (larger = further right)

### Current Values:
```
offset_left = -100.0
offset_top = 170.0
offset_right = 220.0
offset_bottom = 210.0
```

### Examples:
- **Move text further down**: Increase `offset_top` (e.g., 190, 210, 230)
- **Move text up**: Decrease `offset_top` (e.g., 160, 150, 140)
- **Make text wider**: Decrease `offset_left` and increase `offset_right`
- **Center text differently**: Adjust both left and right values equally

### Method 2: Manual File Edit
You can also edit the `picture_frame.tscn` file directly:

1. Open `picture_frame.tscn` in a text editor
2. Find the `[node name="DescriptionText"` section
3. Modify the offset values
4. Save the file

## How to Adjust Animation Speeds

### Fade In Speed
Edit `picture_frame.gd`, line ~116:
```gdscript
fade_tween.tween_property(description_label, "modulate:a", 1.0, 1.5)
```
Change `1.5` to your desired duration in seconds (e.g., `2.0` for even slower)

### Camera Movement Speed
Edit `player.gd`:

**For zooming into frame** (line ~80):
```gdscript
tween.tween_property(camera, "offset", offset, 1.5)
```

**For zooming out from frame** (line ~90):
```gdscript
tween.tween_property(camera, "offset", Vector2.ZERO, 1.5)
```

Change `1.5` to your desired duration in seconds.

## Technical Details

### Frame Structure
- The PictureFrame ColorRect is 120x160 pixels by default
- The DetectionArea is positioned at y=488 (ground level)
- The description text wraps automatically (autowrap_mode = 2)
- Text has pink color with black outline for visibility

### Position Reference Points
- `offset_top = 0`: Top of the frame
- `offset_top = 160`: Bottom of the frame
- `offset_top = 170`: Current description text position (10px below frame)
- `offset_top = 488`: Ground level (where player walks)

Enjoy customizing your anniversary game! 💕
