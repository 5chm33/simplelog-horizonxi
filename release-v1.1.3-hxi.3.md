## SimpleLog v1.1.3-hxi.3 — Direct Enemy Cast Overlay

This release implements the missing middle-of-screen enemy cast text **directly inside SimpleLog**.

> **Important:** This is a HorizonXI compatibility distribution of [Spike2D's SimpleLog](https://github.com/Spike2D/SimpleLog), not an official upstream release. Original credits and licenses are preserved.

### Fixed

- Adds a **no-box center-screen overlay** when a monster begins casting a spell or starting an ability.
- Displays the action in the familiar format:
  ```text
  Mob Name > Spell or Ability
  ```
- Uses Ashita’s fonts API, rather than the HorizonXI client’s changed native action-message display.
- Keeps the repaired SimpleLog combat log and current `0x28` packet handling intact.
- Clears each alert automatically after 3.5 seconds.

### Installation

1. Close HorizonXI.
2. Download and extract the release zip.
3. Replace `HorizonXI\Game\addons\simplelog\` with the included `simplelog` folder.
4. Start HorizonXI and load it with:
   ```text
   /addon load simplelog
   ```

Use `/slog` for SimpleLog’s existing configuration menu.
