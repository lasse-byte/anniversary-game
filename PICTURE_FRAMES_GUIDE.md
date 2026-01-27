# Picture Frame Feature Guide

## New Features Added! 🖼️

### Auto-Scaling Picture Frames
Picture frames now automatically scale to fit the images you import!

### Interactive Frame Viewing
- Walk under any picture frame
- An **↑** arrow appears when you're in the right spot
- Press **Up Arrow** or **W** to zoom the camera on the frame
- Move with **A/D** or arrow keys, or press **Space** to return to normal view

## How to Add Your Own Pictures

### Step 1: Prepare Your Image
- Any image format supported by Godot (PNG, JPG, etc.)
- Recommended size: 400x600 pixels or similar aspect ratio
- Place your images in the game folder

### Step 2: Add Image to a Frame
1. Open Godot and open any room scene (room1.tscn, room2.tscn, etc.)
2. In the Scene tree, find and expand a PictureFrame node (e.g., "PictureFrame1")
3. Expand the "Picture" node underneath it
4. Right-click in the Scene tree and select "Add Child Node"
5. Search for "Sprite2D" and add it
6. Select the new Sprite2D node
7. In the Inspector panel on the right, find the "Texture" property
8. Drag your image file into the Texture slot (or click and browse)
9. The frame will automatically resize to fit your image!

### Step 3: Test It
1. Press F5 to run the game
2. Walk under the frame you just added a picture to
3. You'll see the ↑ arrow appear
4. Press Up to view the picture close-up!
5. Move or jump to return to normal gameplay

## Tips

- **Multiple pictures per room**: Each room has 3 frames you can customize
- **Different sizes**: The frames will automatically adjust to portrait or landscape images
- **Max size**: Frames won't exceed 200x200 pixels to keep them reasonable in-game
- **Mix and match**: You can have some frames with pictures and some with emoji placeholders

## Controls Summary

- **A/D or Left/Right Arrows**: Walk
- **Space**: Jump
- **Up Arrow or W**: View picture frame (when standing under it)
- **Any movement or Space**: Exit frame view

## Technical Details

The picture frame script (`picture_frame.gd`) automatically:
1. Detects when a Sprite2D with a texture is added as a child of the Picture node
2. Calculates the aspect ratio of your image
3. Scales the frame to fit while maintaining proportions
4. Centers the image in the frame
5. Hides the emoji placeholder when a real image is present

Enjoy your personalized anniversary game! 💕
