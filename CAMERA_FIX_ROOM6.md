# Camera Movement Fix for Room 6

## Problem
The camera was not moving up to focus on the text box in Room 6 when the player approached it, unlike how it moves to focus on picture frames in other rooms.

## Solution
Added a detection area to the draggable text box that triggers camera movement, making it behave like a picture frame.

## Changes Made

### 1. draggable_textbox.gd
Added two new methods to handle player proximity:

```gdscript
# Called by DetectionArea when player enters
func _on_detection_area_body_entered(body):
    if body.name == "Player":
        if body.has_method("add_nearby_frame"):
            body.add_nearby_frame(self)

# Called by DetectionArea when player exits
func _on_detection_area_body_exited(body):
    if body.name == "Player":
        if body.has_method("remove_nearby_frame"):
            body.remove_nearby_frame(self)
```

These methods work identically to the picture frame detection system:
- When player enters the detection area, it calls `player.add_nearby_frame(self)`
- When player exits, it calls `player.remove_nearby_frame(self)`
- The player's `enter_frame_view()` and `exit_frame_view()` methods handle the camera movement

### 2. room6.tscn
Added a detection area as a child of the DraggableTextBox:

**New SubResource**:
```
[sub_resource type="RectangleShape2D" id="RectangleShape2D_textbox"]
size = Vector2(1100, 400)
```

**New Node Structure**:
```
[node name="DetectionArea" type="Area2D" parent="DraggableTextBox"]
position = Vector2(500, 400)
collision_layer = 0
collision_mask = 1
monitorable = false

[node name="CollisionShape2D" type="CollisionShape2D" parent="DraggableTextBox/DetectionArea"]
shape = SubResource("RectangleShape2D_textbox")
```

**Signal Connections**:
```
[connection signal="body_entered" from="DraggableTextBox/DetectionArea" to="DraggableTextBox" method="_on_detection_area_body_entered"]
[connection signal="body_exited" from="DraggableTextBox/DetectionArea" to="DraggableTextBox" method="_on_detection_area_body_exited"]
```

## How It Works

### Detection Area
- **Size**: 1100x400 pixels (covers the text box area)
- **Position**: (500, 400) relative to text box origin
- **Collision Settings**:
  - collision_layer = 0 (not on any layer)
  - collision_mask = 1 (detects layer 1, where player is)
  - monitorable = false (other objects don't detect it)

### Camera Movement Flow
```
Player approaches text box
    ↓
DetectionArea detects player
    ↓
body_entered signal fires
    ↓
_on_detection_area_body_entered() called
    ↓
player.add_nearby_frame(text_box) called
    ↓
Player's _physics_process() detects nearby frame
    ↓
player.enter_frame_view(text_box) called
    ↓
Camera smoothly moves to focus on text box (1.5 seconds)
```

### Camera Return Flow
```
Player walks away from text box
    ↓
Player exits DetectionArea
    ↓
body_exited signal fires
    ↓
_on_detection_area_body_exited() called
    ↓
player.remove_nearby_frame(text_box) called
    ↓
Player's _physics_process() detects no nearby frames
    ↓
player.exit_frame_view() called
    ↓
Camera smoothly returns to player (1.5 seconds)
```

## Comparison with Picture Frames

The implementation mirrors the picture frame system:

**Picture Frame (picture_frame.gd)**:
```gdscript
func _on_detection_area_body_entered(body):
    if body.name == "Player":
        if body.has_method("add_nearby_frame"):
            body.add_nearby_frame(self)
```

**Text Box (draggable_textbox.gd)**:
```gdscript
func _on_detection_area_body_entered(body):
    if body.name == "Player":
        if body.has_method("add_nearby_frame"):
            body.add_nearby_frame(self)
```

Both use the exact same pattern, ensuring consistent behavior.

## Player Camera System

The player script (player.gd) handles camera movement automatically:

```gdscript
func _physics_process(delta):
    # Auto-enter frame view when nearby frames are detected
    if nearby_frames.size() > 0 and not viewing_frame:
        enter_frame_view(nearby_frames[0])
    
    # Auto-exit frame view when no nearby frames
    if nearby_frames.size() == 0 and viewing_frame:
        exit_frame_view()
```

The camera smoothly tweens to the target over 1.5 seconds:

```gdscript
func enter_frame_view(frame: Control):
    var tween = create_tween()
    tween.set_ease(Tween.EASE_OUT)
    tween.set_trans(Tween.TRANS_CUBIC)
    var offset = frame_global_pos - global_position
    tween.tween_property(camera, "offset", offset, 1.5)
```

## Testing

To verify the fix works:

1. **Enter Room 6**: Play through rooms 1-5 and enter room 6
2. **Approach Text Box**: Walk toward the center where the text box is
3. **Camera Moves Up**: The camera should smoothly pan up to show the text box
4. **Walk Away**: Move the player away from the text box
5. **Camera Returns**: The camera should smoothly return to follow the player

Expected behavior:
- ✓ Camera moves when player enters detection area (like picture frames)
- ✓ Camera focuses on text box center
- ✓ Camera returns when player leaves area
- ✓ Smooth 1.5 second transitions
- ✓ Text box remains draggable and editable

## Benefits

1. **Consistent Behavior**: Text box now works like picture frames
2. **Better Visibility**: Camera focuses on the text box when player approaches
3. **User Experience**: Players can clearly see what they're writing
4. **Minimal Changes**: Uses existing player camera system, no new code needed
5. **No Breaking Changes**: Dragging and editing still work perfectly

## Files Modified

- `draggable_textbox.gd` - Added detection handlers (12 lines)
- `room6.tscn` - Added detection area and signals (12 lines)

Total: 24 lines of new code, leveraging existing camera system.
