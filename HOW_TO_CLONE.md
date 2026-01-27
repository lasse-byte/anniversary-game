# How to Clone and Use This Game 🎮

## ⚠️ IMPORTANT: Download from the Correct Branch!

**If you only see a README file after downloading**, you're downloading from the wrong place!

The game files are in the **Pull Request branch**, not the main repository page.

### ✅ Correct Way to Download:

**Option A: Download from Pull Request (RECOMMENDED)**
1. Go to the Pull Request: https://github.com/lasse-byte/anniversary-game/pull/1
2. Scroll down and click on **"copilot/create-2d-platformer-game"** branch link
3. OR go directly to: https://github.com/lasse-byte/anniversary-game/tree/copilot/create-2d-platformer-game
4. Click the green **Code** button
5. Click **Download ZIP**
6. Extract the ZIP file - you should now see ALL the game files!

**Option B: Using Git (Clone Specific Branch)**
```bash
# Clone the repository and checkout the branch with the game
git clone https://github.com/lasse-byte/anniversary-game.git
cd anniversary-game
git checkout copilot/create-2d-platformer-game
```

## Step-by-Step: Getting the Game on Your Computer

### Step 1: Download the Game Files

**If you see ONLY a README file, you're in the wrong place!** 
👉 Use Option A above to download from the correct branch.

**You should see these files after extracting:**
- project.godot ⭐ (main file)
- player.gd and player.tscn
- room1.tscn through room5.tscn
- confetti.tscn
- Multiple .md documentation files
- And more!

### Step 2: Install Godot 4.6
1. Download from: https://godotengine.org/download/archive/4.6-stable/
2. **Important**: Get the **Standard** version (NOT .NET)
3. Install or extract it

### Step 3: Open the Project in Godot
1. Open Godot 4.6
2. Click **Import** button
3. Click **Browse** and navigate to the folder where you extracted the game
4. Select the `project.godot` file
5. Click **Import & Edit**

### Step 4: Play the Game!
- Press **F5** or click the ▶️ **Play** button
- Use **A/D** or **Arrow Keys** to walk
- Use **Space** to jump
- Walk to the door (→) to go to the next room

## Troubleshooting

**"I only see a README file after unzipping!"** ⚠️
- You downloaded from the main repository page instead of the PR branch
- Follow Option A above to download from: https://github.com/lasse-byte/anniversary-game/tree/copilot/create-2d-platformer-game

**"I don't have Git installed"**
- Use Option A (Download ZIP from PR branch) - no Git needed!

**"Can't find project.godot file"**
- Make sure you downloaded from the correct branch (see warning above)
- Check that you extracted the entire ZIP file
- The file should be at the root of the extracted folder

**"Godot says version mismatch"**
- Make sure you downloaded Godot 4.6 specifically (not 3.x or 4.3/4.4/4.5)

## Quick Commands Summary (For Git Users)

```bash
# Clone the repository and switch to the game branch
git clone https://github.com/lasse-byte/anniversary-game.git
cd anniversary-game
git checkout copilot/create-2d-platformer-game

# You're ready! Now open Godot and import project.godot
```

## Visual Guide

```
1. Download from PR branch (copilot/create-2d-platformer-game)
   ⚠️  NOT from main repository page!
   ↓
2. Extract ZIP - You should see 20+ files including project.godot
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
- You'll see all the game files in the FileSystem panel (20+ files)
- The Scene tree will show the game structure
- Press F5 and the game window will open with Room 1

If you only see 1-2 files, you downloaded from the wrong branch!

Enjoy! 💕
