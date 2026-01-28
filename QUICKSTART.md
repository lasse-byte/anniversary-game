# Quick Start Guide 🚀

## What You Need To Do Right Now

### 1. Install Godot 4.6
- Download from: https://godotengine.org/download/archive/4.6-stable/
- **Important**: Get the **Standard** version (NOT .NET)
- Available for both Windows and Linux

### 2. Open the Project
1. Open Godot 4.6
2. Click "Import"
3. Navigate to this folder and select `project.godot`
4. Click "Import & Edit"

### 3. Test It
- Press **F5** or click the ▶️ Play button
- Use **A/D** or **Arrow Keys** to walk
- Use **Space** to jump
- Walk to the door (→) to go to the next room

## Customization (Optional)

### Add Your Own Pictures
1. In Godot, double-click any room scene (room1.tscn, room2.tscn, etc.)
2. In the Scene tree (left side), expand "PictureFrame1" → "Picture"
3. Click on the "Picture" node
4. In Inspector (right side), find "Texture" under CanvasItem → Texture
5. Drag your image file into the texture slot
6. Repeat for other frames

### Change Messages
1. Open any room scene
2. Expand "UI" → click "YearLabel" 
3. In Inspector, find "Text" and edit it
4. For Room 5, also edit "FinalMessage"

## Export for Her Windows Machine

1. In Godot, click **Project** → **Export**
2. Click **Add...** → Select **Windows Desktop**
3. In "Export Path", click the folder icon and choose where to save (e.g., `Desktop/AnniversaryGame.exe`)
4. Click **Export Project**
5. Send her the `.exe` file (and the `.pck` file if separate)

## Export for Your Linux Machine

1. In Godot, click **Project** → **Export**
2. Click **Add...** → Select **Linux/X11**  
3. Choose export path (e.g., `Desktop/AnniversaryGame.x86_64`)
4. Click **Export Project**
5. In terminal: `chmod +x AnniversaryGame.x86_64`
6. Run: `./AnniversaryGame.x86_64`

## Export for Mobile (Android)

**Easiest Option - Web Export Instead:**
1. Click **Project** → **Export** → **Add...** → **Web**
2. Export to a folder
3. Upload to itch.io, GitHub Pages, or any web host
4. Both of you can play on any device with a browser!

**For Native Android App:**
1. First time: Go to **Editor** → **Manage Export Templates** → Download
2. You'll need Android SDK - follow: https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_android.html
3. Then: **Project** → **Export** → **Add...** → **Android**
4. Export as APK and install on phone

## Troubleshooting

**"Can't find player sprite"**: This is normal - the game uses a colored rectangle as placeholder

**"Export templates not found"**: Click Editor → Manage Export Templates → Download

**Game runs but looks weird**: Make sure you're using Godot 4.6 (not 3.x or 4.3/4.4)

## What's Included

✅ 5 rooms with different colors and themes
✅ Player movement (walk + jump)
✅ Confetti effects in each room
✅ Picture frames (currently showing emoji, replace with your photos)
✅ Romantic messages
✅ Smooth room transitions
✅ Camera follows player
✅ Simple animations

## Pro Tips

- **Web export** is the easiest for sharing - works on all platforms
- You can run the game directly in Godot to test changes
- The export presets are already configured for you
- Both Windows and Linux exports work cross-platform

Enjoy! 💕
