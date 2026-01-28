# Quick Start: Adding Repeating Textures

## 3-Step Process

### 1. Prepare Texture
- Create/get a seamless texture (PNG/JPG)
- Place in project folder
- In Godot: Select texture → Import tab → Enable "Repeat" → Reimport

### 2. Assign in Inspector
- Open room scene (e.g., `room1.tscn`)
- Select root node (e.g., "Room1")
- Inspector → Script Variables
- Set `Background Texture` and/or `Floor Texture`
- Save scene

### 3. Test
- Press F5 to run
- Texture should repeat across background/floor

## Example Sizes
- Floor: 64×64 or 128×128
- Background: 128×128 or 256×256

## Important Settings
- **Repeat**: MUST be Enabled
- **Filter**: Nearest (pixel art) or Linear (smooth)

## Troubleshooting
- Texture stretched? → Check "Repeat" is enabled
- Texture blurry? → Adjust "Filter" setting
- Seams visible? → Use seamless texture

See TEXTURE_GUIDE.md for complete documentation.
