# Anniversary Game 🎮💕

A cute 2D platformer celebrating 5 years together! Walk through 5 rooms, each representing one year of your relationship.

## Features
- Simple 2D platformer controls (A/D or Arrow keys to move, Space to jump)
- 5 unique rooms, one for each year
- Picture frames with memories on the walls
- Confetti celebrations in each room
- Romantic messages and themes

## How to Run

### For Development (Editing the Game)
1. Download and install [Godot 4.6](https://godotengine.org/download) (use the standard version, NOT the .NET version)
2. Clone or download this repository
3. Open Godot 4.6
4. Click "Import" and select the `project.godot` file in this folder
5. Click "Import & Edit"
6. Press F5 or click the Play button to run the game

### To Customize
- **Add your own pictures**: Replace the emoji hearts in the picture frames with actual images
  - Open any room scene (room1.tscn through room5.tscn)
  - Select a PictureFrame -> Picture node
  - In the Inspector, you can add a Texture2D with your image
- **Change room colors**: Edit the `ColorRect` background in each room scene
- **Modify text**: Change the `YearLabel` text in each room to customize the messages

## Exporting for Different Platforms

### Windows
1. In Godot, go to Project > Export
2. Click "Add..." and select "Windows Desktop"
3. Set export path (e.g., `builds/AnniversaryGame_Windows.exe`)
4. Click "Export Project"
5. Send the `.exe` file to your girlfriend's Windows machine

### Linux
1. In Godot, go to Project > Export
2. Click "Add..." and select "Linux/X11"
3. Set export path (e.g., `builds/AnniversaryGame_Linux.x86_64`)
4. Click "Export Project"
5. Make the file executable: `chmod +x AnniversaryGame_Linux.x86_64`

### Android (Mobile)
1. Download Android export templates in Godot (Editor > Manage Export Templates)
2. Install Android SDK (see [Godot Android export guide](https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_android.html))
3. In Godot, go to Project > Export
4. Click "Add..." and select "Android"
5. Configure signing keys
6. Click "Export Project" and save as `.apk`
7. Transfer the APK to the phone and install

### iOS (Mobile)
1. Requires a Mac with Xcode
2. See [Godot iOS export guide](https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_ios.html)

### Web (Easiest for sharing!)
1. In Godot, go to Project > Export
2. Click "Add..." and select "Web"
3. Set export path (e.g., `builds/web/index.html`)
4. Click "Export Project"
5. Upload the entire `web` folder to any web hosting service
6. She can play it in any browser on any device!

## Quick Start (No Installation Needed)
The easiest way to share this game is to export it for Web and host it online. Both of you can play it in your browsers without installing anything!

## Controls
- **A** or **Left Arrow**: Move left
- **D** or **Right Arrow**: Move right  
- **Space**: Jump
- Walk to the door on the right (→) to go to the next year/room

## Game Structure
```
Room 1: Year 1 - The Beginning
Room 2: Year 2 - Growing Together
Room 3: Year 3 - Adventures
Room 4: Year 4 - Making Memories
Room 5: Year 5 - Forever & Always ❤
```

## Tips
- The game is designed to be simple and sweet
- Each room triggers confetti when you reach the door
- Take your time to "look" at each picture frame
- The final room has a special message!

## Technical Details
- Built with Godot 4.6
- All assets included (no external dependencies)
- Cross-platform compatible (Windows, Linux, Mac, Android, iOS, Web)
- Resolution: 1280x720 (scales automatically)

Enjoy celebrating your anniversary! 💕