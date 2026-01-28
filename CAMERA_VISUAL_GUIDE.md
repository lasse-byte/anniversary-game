# Room 6 Camera Movement - Visual Guide

## Text Box with Detection Area

```
┌─────────────────────────────────────────────────────────────┐
│  Room 6: The Final Chapter ❤️                               │
│                                                             │
│                                                             │
│         ┌───────────────────────────────────┐              │
│         │ ╔═════════════════════════════╗   │              │
│         │ ║                             ║   │              │
│         │ ║   Write your message here!  ║   │ ← Text Box  │
│         │ ║                             ║   │   (1000x300) │
│         │ ║   Drag me around!           ║   │              │
│         │ ║                             ║   │              │
│         │ ╚═════════════════════════════╝   │              │
│         │                                   │              │
│         │    [Detection Area: 1100x400]    │              │
│         └───────────────────────────────────┘              │
│                      ↑                                      │
│              Camera focuses here                           │
│              when player enters                            │
│                                                             │
│   👤 ←── Player walks here                                 │
│                                                             │
├─────────────────────────────────────────────────────────────┤
│                        FLOOR                                │
└─────────────────────────────────────────────────────────────┘
```

## Detection Area Positioning

### Text Box Coordinates
- Position: (600, 250)
- Size: 1000×300 pixels
- Text box is a `TextEdit` node

### Detection Area Coordinates
- Parent: DraggableTextBox
- Local Position: (500, 400)
- Global Position: (600, 250) + (500, 400) = (1100, 650)
- Size: 1100×400 pixels

### Coverage
```
Text Box Center: (1100, 400)
Detection Center: (1100, 650)

┌────────────────────┐
│   Text Box (1000)  │  ← Position: (600, 250)
│       300px high   │
└────────────────────┘
        │
        ▼
┌──────────────────────┐
│  Detection (1100)    │  ← Position: (1100, 650) global
│      400px high      │     Covers floor area below text
└──────────────────────┘
```

## Camera Movement Sequence

### Before Player Enters
```
┌─────────────────────────────────────┐
│         Text Box                    │
│      ┌──────────┐                   │
│      │ Message  │                   │
│      └──────────┘                   │
│                                     │
│                                     │
│  Camera focused on:                 │
│  👤 Player (normal view)            │
│                                     │
│══════════════════════════════════════│
│            FLOOR                    │
└─────────────────────────────────────┘
```

### Player Enters Detection Area
```
┌─────────────────────────────────────┐
│         Text Box                    │
│      ┌──────────┐                   │
│      │ Message  │ ← Camera starts   │
│      └──────────┘    moving here    │
│           ↑                         │
│           │ [Detection Area Active] │
│           │                         │
│          👤 Player enters            │
│                                     │
│══════════════════════════════════════│
│            FLOOR                    │
└─────────────────────────────────────┘

Signal Flow:
1. Player enters DetectionArea
2. body_entered signal fires
3. text_box.add_nearby_frame(self) called
4. player.enter_frame_view(text_box) starts
5. Camera tweens to text box over 1.5 seconds
```

### Camera Focused on Text Box
```
┌─────────────────────────────────────┐
│         Text Box (FOCUSED)          │
│      ┌─────────────────┐            │
│      │ Write your      │            │
│      │ message here!   │ ← Camera   │
│      │                 │   centered │
│      │ Drag me around! │   here     │
│      └─────────────────┘            │
│                                     │
│          👤 Player (below)          │
│                                     │
│══════════════════════════════════════│
│            FLOOR                    │
└─────────────────────────────────────┘

Player View:
- Text box is clearly visible
- Easy to read message
- Player can edit text
- Player can drag text box
```

### Player Exits Detection Area
```
┌─────────────────────────────────────┐
│         Text Box                    │
│      ┌──────────┐                   │
│      │ Message  │ ← Camera starts   │
│      └──────────┘    moving back    │
│                                     │
│           [Detection Area Inactive] │
│                                     │
│  👤 ←── Player walks away           │
│                                     │
│══════════════════════════════════════│
│            FLOOR                    │
└─────────────────────────────────────┘

Signal Flow:
1. Player exits DetectionArea
2. body_exited signal fires
3. text_box.remove_nearby_frame(self) called
4. player.exit_frame_view() starts
5. Camera returns to player over 1.5 seconds
```

### After Player Leaves
```
┌─────────────────────────────────────┐
│         Text Box                    │
│      ┌──────────┐                   │
│      │ Message  │                   │
│      └──────────┘                   │
│                                     │
│                                     │
│  Camera focused on:                 │
│  👤 Player (normal view)            │
│      (Player walks left)            │
│                                     │
│══════════════════════════════════════│
│            FLOOR                    │
└─────────────────────────────────────┘
```

## Detection Area Size Explanation

### Why 1100×400?
```
Text Box: 1000×300 pixels
Detection: 1100×400 pixels

Horizontal: 1100 vs 1000
- 50px extra on each side
- Ensures player is detected even if slightly offset

Vertical: 400 vs 300
- 100px extra height
- Extends below text box to floor level
- Player walks at y=650 (floor level)
- Text box at y=250, detection at y=650
- Perfect for floor-level detection
```

### Position Calculation
```
Text Box Origin: (600, 250)
Text Box Size: 1000×300

Detection Center should be:
- Horizontally: Center of text box
  x = 600 + 1000/2 = 1100
  Local x = 1000/2 = 500

- Vertically: Floor level  
  Player at y=650
  Detection local y = 400 (relative to text box at 250)
  Global y = 250 + 400 = 650 ✓

Result: position = Vector2(500, 400)
```

## Comparison: Picture Frames vs Text Box

### Picture Frame Detection
```
┌──────┐
│ 🖼️   │ ← Frame at y=200
└──────┘
   │
   ↓ (488px down)
  [🔍] ← Detection at y=688 (floor level)
```

### Text Box Detection  
```
┌────────────┐
│ 📝 Text Box│ ← Box at y=250
└────────────┘
   │
   ↓ (400px down)
  [🔍] ← Detection at y=650 (floor level)
```

Both systems work identically:
- Detection area near floor where player walks
- Player enters → camera moves to object
- Player exits → camera returns to player
- Smooth 1.5 second transitions

## Technical Implementation

### Node Hierarchy
```
Room6 (Node2D)
└── DraggableTextBox (TextEdit)
    └── DetectionArea (Area2D)
        └── CollisionShape2D (RectangleShape2D)
```

### Signal Connections
```
DetectionArea.body_entered 
    → DraggableTextBox._on_detection_area_body_entered()
        → Player.add_nearby_frame(textbox)
            → Player.enter_frame_view(textbox)

DetectionArea.body_exited
    → DraggableTextBox._on_detection_area_body_exited()
        → Player.remove_nearby_frame(textbox)
            → Player.exit_frame_view()
```

### Camera Offset Calculation
```gdscript
# In player.gd enter_frame_view():
var frame_global_pos = frame.global_position  # (600, 250)
frame_global_pos += frame.size / 2  # (1100, 400)
var offset = frame_global_pos - player.global_position
camera.offset = offset  # Camera moves to show text box
```

## Result

✅ **Camera moves up when player approaches text box**
✅ **Camera focuses on text box for easy reading**
✅ **Camera returns when player walks away**
✅ **Smooth 1.5 second transitions (same as frames)**
✅ **Text box remains fully interactive**
✅ **Dragging and editing still work perfectly**

Perfect implementation matching the picture frame behavior! 🎉
