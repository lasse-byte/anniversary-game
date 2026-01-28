# How to Fix "Only 3 Frames Showing" Issue

The game files are correct (47 frames total: 7 in room1, 10 in rooms 2-5), but Godot is showing cached/old versions of the scenes.

## Solution: Force Godot to Reload

### Option 1: Quick Reload (Try This First)
1. In Godot, go to **Project → Reload Current Project**
2. Wait for it to reload
3. Open any room scene (e.g., room1.tscn, room2.tscn)
4. You should now see all frames

### Option 2: Clear Cache (If Option 1 Doesn't Work)
1. **Close Godot completely**
2. In your project folder, delete the `.godot` folder (it's a hidden folder)
   - On Windows: Show hidden files, then delete `.godot` folder
   - On Linux/Mac: Run `rm -rf .godot` in the project directory
3. **Reopen Godot**
4. Import the project again
5. All frames should now appear correctly

### Option 3: Manual Verification
If you want to verify the frames are actually there:
1. Open any room file in a text editor
2. Search for "PictureFrame"
3. Count the occurrences of `[node name="PictureFrame`
   - room1.tscn should have 7
   - room2-5.tscn should each have 10

## What Happened?

Godot caches scene files for performance. When we added the new frames, Godot didn't automatically reload the scenes in the editor. The files on disk are correct, but the editor is showing the cached version.

After reloading, you should see:
- Room 1: 7 picture frames spread across 5400 pixels
- Rooms 2-5: 10 picture frames each spread across 7500 pixels each
- Total: 47 picture frames
- Spacing: 700 pixels between frames (only one visible when viewing)
