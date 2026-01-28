# Final Room Guide - Room 6

## Overview
Room 6 is the final room in the anniversary game. It's a smaller, intimate space designed for a personal message with celebratory confetti effects.

## Key Features

### 1. Smaller Room Size
- **Dimensions**: 2200px wide x 800px tall (compared to 5400-7500px for other rooms)
- **Purpose**: Creates a more intimate, focused space for the final message
- **Color**: Soft pink tint (0.98, 0.93, 0.95) for a romantic feel

### 2. Draggable Text Box
- **Size**: 1000px x 300px
- **Initial Position**: Center-upper area (600, 250)
- **Font Size**: 32px for good readability
- **Features**:
  - Click and drag to reposition anywhere on screen
  - Fully editable - type your own message
  - Semi-transparent background (90% opacity)
  - Warm color scheme (cream background, dark text)

### 3. Dual Confetti System
- **Trigger**: When player reaches the center of the room
- **Left Confetti Emitter**: Position (100, 400) - shoots right and down
- **Right Confetti Emitter**: Position (2100, 400) - shoots left and down
- **Particle Count**: 150 particles per emitter (300 total)
- **Duration**: 3 seconds
- **Effect**: One-shot celebration when center is reached

### 4. No Exit Door
- **Design Choice**: This is the final room - no door to the next area
- **Purpose**: The journey ends here with your message

## How to Use

### For Players
1. Enter room 6 from room 5
2. Walk to the center of the room to trigger confetti 🎉
3. Click on the text box to edit your message
4. Drag the text box to position it wherever you like
5. Enjoy your personalized final message!

### For Developers

#### Editing the Text Box
The text box is defined in `room6.tscn` and uses `draggable_textbox.gd`:

```gdscript
# In draggable_textbox.gd
func _ready():
    text = "Your custom message here!"
```

#### Adjusting Confetti Position
Edit the particle emitter positions in `room6.tscn`:
```
[node name="ConfettiLeft" type="GPUParticles2D" parent="."]
position = Vector2(100, 400)  # Left side position

[node name="ConfettiRight" type="GPUParticles2D" parent="."]
position = Vector2(2100, 400)  # Right side position
```

#### Changing Center Detection Area
The center area is at x=1100 (middle of the 2200px room):
```
[node name="CenterArea" type="Area2D" parent="."]
position = Vector2(1100, 650)
```

#### Room Linking
Room 5 links to Room 6 via:
```
next_room_scene = ExtResource("5_room6")
```

## Files

### New Files Created
1. **room6.tscn** - The final room scene
2. **room_final.gd** - Room script with center detection logic
3. **draggable_textbox.gd** - Draggable text box script

### Modified Files
1. **room5.tscn** - Added link to room6

## Technical Details

### Dragging Mechanism
The text box uses mouse input events to detect clicks and drags:
- `InputEventMouseButton`: Detects when mouse is clicked on the text box
- `InputEventMouseMotion`: Updates position while dragging
- `drag_offset`: Maintains relative position between mouse and text box corner

### Confetti Physics
Each confetti emitter uses `ParticleProcessMaterial` with:
- Directional emission (left shoots right, right shoots left)
- Gravity effect (300 units downward)
- Angular velocity for spinning effect
- Color gradient (pink → yellow → transparent)
- Size variation (3-8 scale)
- 3-second lifetime

### Center Detection
Uses an `Area2D` node with collision detection:
- Positioned at room center (x=1100)
- 400px wide detection zone
- Triggers confetti once when player enters

## Customization Ideas

### Text Box Styling
Edit theme overrides in `room6.tscn`:
```
theme_override_colors/background_color = Color(1, 0.95, 0.9, 0.9)
theme_override_colors/font_color = Color(0.2, 0.1, 0.15, 1)
theme_override_font_sizes/font_size = 32
```

### Confetti Colors
Modify the gradient in particle materials:
```gdscript
colors = PackedColorArray(1, 0.2, 0.5, 1, 1, 0.8, 0.2, 1, 0.2, 0.5, 1, 0)
# Format: R, G, B, A for each color stop
```

### Room Size
Adjust dimensions in `room6.tscn`:
```
# ColorRect dimensions
offset_right = 2200.0  # Width
offset_bottom = 800.0  # Height

# Floor collision
size = Vector2(2200, 100)  # Width x Height
```

## Enjoy Your Final Room! 💕

This is where your journey culminates with a personal message. Make it special!
