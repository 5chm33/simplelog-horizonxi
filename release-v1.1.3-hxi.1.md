## SimpleLog v1.1.3-hxi.1 — HorizonXI ToAU Compatibility

This is a HorizonXI compatibility maintenance release of [Spike2D's SimpleLog](https://github.com/Spike2D/SimpleLog) for Ashita v4.

> **Important:** This is not an official upstream SimpleLog release and does not claim authorship. Original credits and licenses are preserved in the repository and release package.

### Fixed

- Restores **mob spell / ability cast-start notifications** by correcting the current `0x28` action packet header parsing.
- Restores normal **combat and message-log output** affected by malformed action records.
- Stops unnecessarily rebuilding and writing observed action packets back to Ashita.
- Adds safe bounds checks for incomplete action data.
- Preserves message visibility while entity information is still loading.

### Installation

1. Close HorizonXI.
2. Download and extract the release zip.
3. Copy the included `simplelog` folder into `HorizonXI\Game\addons\` and replace the old folder.
4. Start HorizonXI and load it with:
   ```text
   /addon load simplelog
   ```
5. Use `/slog` to open SimpleLog's existing configuration menu.

