# Quick Start: Playing the Final Room

## How to Experience Room 6

### 1. Start the Game
Open the project in Godot and press **F5** (or click the Play button).

### 2. Progress Through the Rooms
Play through Rooms 1-5 as normal:
- Walk right through each room
- Approach the picture frames to view memories
- Go through the door at the end of each room

### 3. Enter the Final Room
When you reach the door in Room 5 and walk through it, you'll enter **Room 6** - The Final Chapter!

### 4. Trigger the Confetti 🎉
- Walk to the **center** of the room
- When you reach approximately the middle (around x=1100)
- **BOOM!** Confetti explodes from both sides!
- 300 particles rain down for 3 seconds
- This only happens once (doesn't repeat)

### 5. Interact with the Text Box
You'll see a large text box in the center-upper area of the room.

**To Edit the Text**:
- Click on the text box
- Type your custom message
- It's fully editable - write anything you want!

**To Move the Text Box**:
- Click and hold on the text box
- Drag your mouse to move it
- Release to place it in the new position
- You can position it anywhere on the screen!

### 6. Enjoy the Moment
- There's no door in this room - it's the final destination
- Take your time to craft the perfect message
- Position it exactly where you want it
- This is your personalized ending! 💕

---

## For Developers: Testing Room 6 Directly

If you want to test Room 6 without playing through all rooms:

### Method 1: Set Room 6 as Starting Scene
1. Open Godot
2. Right-click on `room6.tscn` in the FileSystem panel
3. Select "Set as Main Scene"
4. Press F5 to play

### Method 2: Open Room 6 Directly
1. Open `room6.tscn` in Godot
2. Press F6 to play the current scene
3. This runs Room 6 independently

### Method 3: Modify main.tscn
1. Open `main.tscn`
2. Change the instance from `room1.tscn` to `room6.tscn`
3. Press F5 to play

**Remember**: Change it back to `room1.tscn` when you're done testing!

---

## What to Expect

### Visual Experience
```
┌─────────────────────────────────────────────────────┐
│                The Final Chapter ❤️                 │
│                                                     │
│    ┌─────────────────────────────────────┐        │
│    │                                     │        │
│    │  Your editable message here!       │        │
│    │                                     │        │
│    │  Click to edit, drag to move!      │        │
│    │                                     │        │
│    └─────────────────────────────────────┘        │
│                                                     │
│              👤 ← Player walks here                 │
│                                                     │
│                    🎉 CONFETTI! 🎉                 │
└─────────────────────────────────────────────────────┘
```

### Room Features at a Glance
- **Size**: Much smaller and more intimate (2200px wide)
- **Background**: Soft pink romantic color
- **Title**: "The Final Chapter ❤️"
- **Text Box**: Large, draggable, editable
- **Confetti**: Dual emitters, 300 particles, 3 seconds
- **No Exit**: Journey ends here - no door to leave

---

## Tips & Tricks

### For the Best Experience
1. **Walk slowly** to the center to see the confetti trigger
2. **Customize your message** to make it personal
3. **Experiment with text box positioning** - try different locations
4. **Take a screenshot** to capture your personalized final scene

### For Development
1. Check `FINAL_ROOM_GUIDE.md` for detailed customization options
2. See `VISUAL_ROOM6_LAYOUT.md` for visual layout specifications
3. Read `FINAL_ROOM_COMPLETE_SUMMARY.md` for technical details
4. View `ROOM6_SCENE_TREE.txt` for scene structure

---

## Troubleshooting

### Confetti doesn't trigger?
- Make sure you walk close enough to the center (x=1100)
- Check that you haven't triggered it already (it only plays once)
- Look for the CenterArea collision shape in the scene

### Text box won't drag?
- Make sure you click directly on the text box
- Hold the mouse button down while dragging
- Check that `draggable_textbox.gd` is attached to the TextEdit node

### Can't edit the text?
- Click inside the text box to focus it
- You should see a cursor appear
- Type normally - it works like any text editor

### Want to go back to Room 5?
- You can't! Room 6 has no door (by design)
- This is the final room - the journey ends here
- To replay, restart the game from the beginning

---

## Customization Quick Reference

### Change the Default Message
Edit `draggable_textbox.gd`, line ~7:
```gdscript
text = "Your new message here!"
```

### Move the Text Box
Edit `room6.tscn`, find DraggableTextBox node:
```
offset_left = 600.0   # X position
offset_top = 250.0    # Y position
```

### Change Confetti Position
Edit `room6.tscn`, find ConfettiLeft and ConfettiRight:
```
position = Vector2(100, 400)   # Left side
position = Vector2(2100, 400)  # Right side
```

### Adjust Room Size
Edit `room6.tscn`, find ColorRect:
```
offset_right = 2200.0  # Width
offset_bottom = 800.0  # Height
```

---

## Enjoy Your Final Room! 💕🎉

This is the culmination of your anniversary journey.
Make it special, make it personal, make it yours!

**Happy Anniversary!** ❤️
