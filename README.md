# Roguelite Prototype

A small 3D roguelite greybox built in **Godot 4** to practise game mechanics:
wave-based combat, skill selection and run-time upgrades. No art pass — untextured
primitives and Godot's default UI theme, on purpose. The point was the systems.

**Status: prototype complete.** It proved what it set out to prove and is kept as a
learning artefact.

## What it does

- **Camera-relative movement** on a `CharacterBody3D`: input is mapped onto the
  camera's forward/right vectors, so WASD always moves relative to the view
- **Starting skill choice** at the beginning of a run (Cleave, Fireball, Curse)
- **Waves of enemies** from random spawn points, scaling per wave
  (`configure_for_wave`), with the next wave starting once the arena is clear
- **Levelling**: enemies grant experience, and each level pauses the game for an
  upgrade choice (max health, move speed or cleave damage)
- **Skills**: melee cleave, a fireball projectile, and a curse zone applying a debuff
- **HUD and game-over screen** driven by signals from the player

## Running it

Open the folder as a project in Godot 4.7 or later and press play. There are no
external dependencies and no third-party assets.

## Known rough edges

It is a prototype, and the wave counter increments in steps of five
(`enemy_spawner.gd`) — a leftover from experimenting with the difficulty curve.
