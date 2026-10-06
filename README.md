# Pixel Roguelite

Single-player pixel-art roguelite in **Godot 4** + GDScript. Right now this is a vertical-slice foundation: one room, one player, pixel-perfect camera, restart.

## How to run

1. Install [Godot 4.3+](https://godotengine.org/download/windows/) (Standard, not .NET).
2. In Godot: **Import** → open this folder → select `project.godot`.
3. Press **F5**.

Move with **arrow keys** or **WASD** (Godot default `ui_*` actions). Press **Enter** to reload the scene (stand-in for “new run”).

## Layout

| Path | Role |
| --- | --- |
| `project.godot` | Engine settings: 320×180 viewport, integer scale, nearest-neighbor filter |
| `scenes/main.tscn` | One dungeon room + walls |
| `scenes/player.tscn` | Player scene (placeholder 16×16 body) |
| `scripts/player.gd` | Movement |
| `scripts/game.gd` | Run loop stub (reload = new run) |
| `ROADMAP.md` | Phases from prototype to meta-progression |

## First change

Tweak `SPEED` in `scripts/player.gd` or the player color in `scenes/player.tscn`. You will feel the loop immediately.
