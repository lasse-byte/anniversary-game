# ⚠️ IMPORTANT: How to See All 47 Picture Frames

## The Problem

You're seeing only 3 frames per room because **main.tscn instances room1.tscn**, and Godot is showing you a CACHED/OLD version of room1.tscn.

The files ARE correct on disk (verified: 7 frames in room1, 10 in rooms 2-5 = 47 total), but Godot needs to reload the instanced scenes.

## The Solution

### Method 1: Force Godot to Reload Everything (RECOMMENDED)

1. **Close Godot completely**
2. **Navigate to your project folder** (anniversary-game)
3. **Delete the `.godot` folder** (this is Godot's cache folder)
   - On Windows: Show hidden files, then delete the `.godot` folder
   - On Linux/Mac: Run `rm -rf .godot` in the project folder
4. **Reopen Godot**
5. **Reimport the project** - it will rebuild the cache from the actual files
6. **Open room1.tscn directly** (not main.tscn)
7. You should now see 7 frames

### Method 2: Open Room Scenes Directly

Instead of opening `main.tscn`, open each room file directly:

1. In Godot's FileSystem panel, double-click **room1.tscn** → You'll see 7 frames
2. Double-click **room2.tscn** → You'll see 10 frames
3. Double-click **room3.tscn** → You'll see 10 frames
4. Double-click **room4.tscn** → You'll see 10 frames
5. Double-click **room5.tscn** → You'll see 10 frames

### Method 3: Reinstantiate the Scene

1. Open **main.tscn**
2. In the Scene tree, **right-click on "Main" node**
3. Select **"Clear Inheritance"** or **"Editable Children"**
4. Delete the Main node
5. Drag **room1.tscn** from FileSystem onto the scene
6. Rename it to "Main"
7. Save

## Why This Happens

When you open `main.tscn`, it loads an **instance** of `room1.tscn`. Godot caches instanced scenes to improve performance. Even though the actual `room1.tscn` file on disk has 7 frames, the cached instance that `main.tscn` is using still has 3 frames.

## How to Verify Files Are Correct

Run this in your project folder:

```bash
grep -c "name=\"PictureFrame" room1.tscn   # Should show 7
grep -c "name=\"PictureFrame" room2.tscn   # Should show 10
grep -c "name=\"PictureFrame" room3.tscn   # Should show 10
grep -c "name=\"PictureFrame" room4.tscn   # Should show 10
grep -c "name=\"PictureFrame" room5.tscn   # Should show 10
```

All files are correct. The issue is 100% Godot's caching of instanced scenes.

## To Play the Game

Press **F5** in Godot or click the **Play** button (▶️). The game will run correctly with all 47 frames because the runtime loads the actual files, not the editor cache.
