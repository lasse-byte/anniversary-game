# Debugging Arrow Visibility

## Current Status

I've made the arrows **always visible** (bright yellow) for debugging purposes. You should now see yellow ↑ arrows below each picture frame when you run the game.

## What to Check

### 1. Open the game in Godot and press F5

You should see:
- Yellow ↑ arrows below each of the 3 picture frames in the room
- The arrows should be at the bottom of each frame

### 2. Check the Output/Console

When you run the game, look at the "Output" panel at the bottom of Godot. You should see debug messages like:

```
Frame: PictureFrame1 - UpArrow found at global pos: (...)
Frame: PictureFrame1 - DetectionArea at global pos: (...)
Frame: PictureFrame1 - Frame global position: (...) size: (...)
```

### 3. Walk the player under a frame

When you walk the player character under a picture frame, you should see in the console:

```
Body entered detection area: Player
Player detected! Showing arrow
```

## If You See the Arrows

Good! The arrows are rendering correctly. The detection system should work now.

## If You Don't See the Arrows

This means there's an issue with how the frames are being instantiated. Please:
1. Take a screenshot of the game running
2. Copy the console output
3. Let me know what you see

## What I Changed

1. Made arrows **always visible** (changed from `visible = false` to `visible = true`)
2. Made arrows **bright yellow** for high visibility
3. Increased arrow font size to 32px (was default small size)
4. Fixed arrow positioning to use `offset` properties correctly
5. Added extensive debug output to track what's happening

## Next Steps

Once you confirm whether you can see the arrows, I can:
- If visible: Make them toggle properly when you stand under frames
- If not visible: Investigate the instantiation/scene structure issue further

## How to Test the Detection

Once arrows are visible, walk your character under a frame. The console should print messages when you enter/exit the detection zone.

Try pressing the Up Arrow key (or W) when under a frame to see if the camera zoom works.
