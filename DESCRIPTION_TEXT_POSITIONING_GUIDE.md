# Description Text Positioning Guide

## Changes Made

### 1. Description Text Position (UNDER the Frame)
The description text has been repositioned to appear directly **UNDER** the picture frame:
- **Previous position**: `offset_top = 520` (very far below)
- **New position**: `offset_top = 170` (just below the 160px tall frame)
- This places the text immediately under the frame for better visibility

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
