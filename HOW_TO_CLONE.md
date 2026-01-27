# How to Clone and Use This Game 🎮

## Step-by-Step: Getting the Game on Your Computer

### Step 1: Clone the Repository

**Option A: Using Git (Command Line)**
```bash
# Open terminal/command prompt and run:
git clone https://github.com/lasse-byte/anniversary-game.git

# Navigate into the folder:
cd anniversary-game
```

**Option B: Download as ZIP (No Git Required)**
1. Go to https://github.com/lasse-byte/anniversary-game
2. Click the green **Code** button
3. Click **Download ZIP**
4. Extract the ZIP file to a folder on your computer

### Step 2: Install Godot 4.6
1. Download from: https://godotengine.org/download/archive/4.6-stable/
2. **Important**: Get the **Standard** version (NOT .NET)
3. Install or extract it

### Step 3: Open the Project in Godot
1. Open Godot 4.6
2. Click **Import** button
3. Click **Browse** and navigate to the folder where you cloned/extracted the game
4. Select the `project.godot` file
5. Click **Import & Edit**

### Step 4: Play the Game!
- Press **F5** or click the ▶️ **Play** button
- Use **A/D** or **Arrow Keys** to walk
- Use **Space** to jump
- Walk to the door (→) to go to the next room

## Troubleshooting

**"I don't have Git installed"**
- Use Option B (Download as ZIP) - no Git needed!

**"Can't find project.godot file"**
- Make sure you're in the `anniversary-game` folder after extracting/cloning
- The file is at the root of the project

**"Godot says version mismatch"**
- Make sure you downloaded Godot 4.6 specifically (not 3.x or 4.3/4.4/4.5)

**"Where is the folder after cloning?"**
- It's in the directory where you ran the `git clone` command
- Usually in your home directory or wherever your terminal was open

## Quick Commands Summary

```bash
# Clone the repository
git clone https://github.com/lasse-byte/anniversary-game.git

# Enter the folder
cd anniversary-game

# You're ready! Now open Godot and import project.godot
```

## Visual Guide

```
1. Clone/Download
   ↓
2. You now have: anniversary-game/project.godot
   ↓
3. Open Godot 4.6
   ↓
4. Click "Import" → Browse to anniversary-game folder
   ↓
5. Select project.godot
   ↓
6. Click "Import & Edit"
   ↓
7. Press F5 to play! 🎉
```

## What You'll See

When you first open the project in Godot:
- The project will load and show the editor
- You'll see all the game files in the FileSystem panel
- The Scene tree will show the game structure
- Press F5 and the game window will open with Room 1

Enjoy! 💕
