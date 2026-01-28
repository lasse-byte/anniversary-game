# Visual Layout: Final Room (Room 6)

## Room Overview
```
┌──────────────────────────────────────────────────────────────────────────────┐
│ Forever & Always 💕 (Year Label - Top Left)                                  │
│                                                                               │
│                       "The Final Chapter ❤️" (Title - Centered)              │
│                                                                               │
│  ☆                                                                        ☆   │
│  ☆                                                                        ☆   │
│ Left      ┌─────────────────────────────────────────────────┐          Right │
│Confetti   │                                                 │       Confetti  │
│  ☆        │    Write your message here!                    │            ☆   │
│  ☆        │                                                 │            ☆   │
│  🎉       │    Drag me around to position me wherever      │           🎉   │
│  ☆        │    you want!                                   │            ☆   │
│  ☆        │                                                 │            ☆   │
│  ☆        │    [DRAGGABLE TEXT BOX - Click & Drag]         │            ☆   │
│           └─────────────────────────────────────────────────┘                │
│                                                                               │
│                            [CENTER DETECTION AREA]                            │
│   👤 ←─────────────────────── player walks here ──────────────────→          │
│                                                                               │
│                              (triggers confetti)                              │
│                                                                               │
├═══════════════════════════════════════════════════════════════════════════════┤
│                                   FLOOR                                       │
└───────────────────────────────────────────────────────────────────────────────┘

Width: 2200px (Smaller than other rooms: 5400-7500px)
Height: 800px
```

## Key Positions

### Text Box
- **Position**: (600, 250)
- **Size**: 1000px × 300px
- **Features**: 
  - Fully editable content
  - Click and drag to move anywhere
  - Semi-transparent warm background
  - Large 32px font

### Confetti Emitters
```
Left Side:                                    Right Side:
Position: (100, 400)                          Position: (2100, 400)
Direction: → ↘                                Direction: ← ↙
  🎊🎉                                              🎉🎊
   ☆☆☆                                            ☆☆☆
    ☆☆☆                                          ☆☆☆
     ☆☆                                          ☆☆
      ☆                                          ☆
```

### Center Detection
```
           [400px wide detection zone]
                     │
                     ▼
           ┌────────────────┐
           │                │
           │   x = 1100     │  ← Room center
           │                │
           └────────────────┘
                     │
            When player enters:
              ✓ Trigger confetti
              ✓ Play once only
```

### Player Spawn
- **Position**: (100, 650)
- **Enters from**: Room 5 (left side)
- **Walk to center**: Triggers celebration!

## Confetti Effect Details

### Visual Flow
```
BEFORE reaching center:
═══════════════════════════════════════════════
Room is calm, peaceful, ready for your message
═══════════════════════════════════════════════

AFTER reaching center:
═══════════════════════════════════════════════
     🎉🎊☆             ☆🎊🎉
  🎊☆   ☆           ☆   ☆🎊
☆   ☆    ☆         ☆    ☆   ☆
 ☆    ☆   ☆       ☆   ☆    ☆
  ☆     ☆          ☆     ☆
   ☆                     ☆

CELEBRATION! 300 particles raining down!
═══════════════════════════════════════════════
```

### Particle Properties
- **Count**: 150 per emitter (300 total)
- **Lifetime**: 3 seconds
- **Colors**: Pink → Yellow → Blue (fading)
- **Size**: 3-8 pixels (varied)
- **Motion**: 
  - Initial velocity: 200-350 units/sec
  - Gravity: 300 units/sec² downward
  - Spinning: -360° to +360°/sec
  - Spread: 30° cone

## Room Progression

### Timeline
```
Room 1 → Room 2 → Room 3 → Room 4 → Room 5 → Room 6 (Final!)
  ↓        ↓        ↓        ↓        ↓         ↓
Year 1   Year 2   Year 3   Year 4   Year 5   Forever
  🚪       🚪       🚪       🚪       🚪       💕 (No door)
```

### Room 6 Unique Features
1. ✓ Smallest room (2200px vs 7500px)
2. ✓ No exit door (journey ends here)
3. ✓ Draggable text box (not fixed like frames)
4. ✓ Dual confetti (both sides of screen)
5. ✓ Center-triggered celebration
6. ✓ Editable message space

## Interaction Flow

```
┌─────────────────────────────────────────────────────────────┐
│                                                             │
│  1. Player enters room from left side                       │
│     └─→ Sees "The Final Chapter ❤️" title                  │
│                                                             │
│  2. Player walks toward center                              │
│     └─→ Crosses center detection area                      │
│         └─→ 🎉 CONFETTI EXPLOSION! 🎉                      │
│                                                             │
│  3. Player can interact with text box                       │
│     ├─→ Click to edit text                                 │
│     │   └─→ Type custom message                            │
│     └─→ Click and drag to reposition                       │
│         └─→ Place anywhere on screen                       │
│                                                             │
│  4. No door = End of journey                                │
│     └─→ Stay and enjoy the moment 💕                       │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## Size Comparison

```
Room 1-4: ████████████████████████████████████████ (5400px)
Room 5:   ████████████████████████████████████████████████ (7500px)
Room 6:   ████████████████ (2200px) ← Much smaller!
```

This smaller size creates intimacy and focuses attention on the message.

## Color Scheme

### Room Background
```
RGB: (0.98, 0.93, 0.95) = Soft Pink
     #FAE8F2 ≈ Very light pink/cream
     
Purpose: Romantic, warm, inviting final atmosphere
```

### Text Box
```
Background: (1.0, 0.95, 0.9, 0.9) = Warm Cream (90% opacity)
Text Color: (0.2, 0.1, 0.15) = Dark Brown
Font Size: 32px (readable and prominent)
```

### Confetti Colors
```
Stage 1: ● Pink (1.0, 0.2, 0.5)
Stage 2: ● Yellow (1.0, 0.8, 0.2)  ← Gradient transition
Stage 3: ○ Blue (0.2, 0.5, 1.0) → Fade out
```

Perfect for the final celebration! 🎉💕
