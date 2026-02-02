# Super ADA Bros

An accessible, wheelchair-friendly reimagining of Super Mario Bros designed for players with mobility disabilities. **Mario can't jump** - instead, the game uses ramps and lifts to navigate terrain, making it playable for wheelchair users and others facing jumping challenges.

![Godot](https://img.shields.io/badge/Godot-3.x-blue)
![OpenCV](https://img.shields.io/badge/OpenCV-Head_Tracking-green)
![Accessibility](https://img.shields.io/badge/Accessibility-Focused-purple)

## Demo

### [Demo Video](https://youtu.be/vRdENLGrBqM)

![Demo Image](https://user-images.githubusercontent.com/25857736/211397451-8d427837-1ca8-4a95-b27e-6d29ca603a2c.png)

## Features

- **Wheelchair-Accessible Design** - Ramps and elevation changes replace jump-based mechanics
- **Multiple Input Methods** - Head tracking, mouse, keyboard, or controller
- **Checkpoint System** - Auto-advances after 3 deaths for accessibility
- **Enemy AI** - Goombas that can be defeated by attacking from above

## Tech Stack

| Component | Technology |
|-----------|------------|
| **Game Engine** | Godot 3.x (GDScript) |
| **Physics** | 2D KinematicBody2D |
| **Head Tracking** | OpenCV + [face-tracker](https://github.com/Kevin-Mok/face-tracker) |
| **Rendering** | GLES2 (OpenGL-based) |

## Input Methods

| Method | Controls |
|--------|----------|
| **Head Tracking** | Move head left/right for direction |
| **Mouse** | Screen zones: left third (move left), right third (move right), top quarter (attack) |
| **Keyboard** | Arrow keys or WASD + Space for attack |
| **Controller** | D-pad + buttons |

## Installation

### Play the Demo
Download from the [Releases page](https://github.com/Kevin-Mok/super-ada-bros/releases) - available for Windows, macOS, Linux, and Web.

### Development Setup

1. Install [Godot Engine 3.x](https://godotengine.org/)
2. Clone the repository:
   ```bash
   git clone git@github.com:Kevin-Mok/SuperADABros.git
   ```
3. Open project in Godot (main scene: `1-1-World.tscn`)
4. Press F5 to run

### Head Tracking Setup (Optional)

1. Set up [face-tracker script](https://github.com/Kevin-Mok/face-tracker)
2. Script outputs coordinates to `/tmp/move_mouse_with_head.out`
3. Game auto-detects when head tracking is available

## Project Structure

```
SuperADABros/
├── 1-1-World.tscn          # Main game scene
├── scripts/
│   ├── Mario.gd            # Player controller & physics
│   ├── Goomba.gd           # Enemy AI
│   ├── Global.gd           # State management
│   └── MoveWithHead.gd     # Head tracking input
├── tiles/                  # Level design tilesets
└── img/                    # Character & tile sprites
```

## Why This Project is Interesting

### Accessibility & Social Impact

1. **Inclusive Game Design**
   - Reimagines classic mechanics for mobility-impaired players
   - Inspired by real community feedback (r/disability subreddit)
   - Demonstrates how constraints drive creative solutions

2. **Multi-Input Architecture**
   - Supports 4+ input methods with seamless switching
   - Head tracking integration via external OpenCV script
   - Configurable sensitivity for different abilities

### Technical Highlights

1. **Custom Physics System**
   - Wheelchair movement on ramps with rotation mechanics
   - Custom gravity and velocity management
   - Collision detection for accessible terrain

2. **Game Development Skills**
   - Full implementation from design through gameplay
   - Animation system with sprite states
   - Scene-based architecture with modular tilesets

3. **External Integration**
   - OpenCV head tracking via file I/O
   - Real-time coordinate processing
   - Movement smoothing for accessibility

### Skills Demonstrated

- **Game Development**: Godot, GDScript, 2D physics
- **Computer Vision Integration**: OpenCV, file-based IPC
- **UX/Accessibility**: Inclusive design, multiple input methods
- **Creative Problem Solving**: Adapting classic mechanics for new constraints

## Inspiration

Found [this GIF](https://www.reddit.com/r/disability/comments/7v9ztc/super_ada_compliant_mario/) on r/disability as a top post - decided to make it a real playable game with actual accessibility features.

## Future Plans

- Adjustable settings for user preferences
- More mechanics from the original game
- Additional enemy types and level designs

## Dev Log

Development updates available on [Devpost](https://devpost.com/software/super-ada-bros).

## Author

[Kevin Mok](https://github.com/Kevin-Mok)
