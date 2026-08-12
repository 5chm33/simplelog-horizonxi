## SimpleLog v1.1.3-hxi.2 — Native Cast Alert Restoration

This follow-up fixes the separate **center-screen enemy cast alert** while retaining the restored SimpleLog combat log from v1.1.3-hxi.1.

> **Important:** This is a HorizonXI compatibility distribution of [Spike2D's SimpleLog](https://github.com/Spike2D/SimpleLog). It is not an official upstream release. Original credits and licenses are preserved.

### Fixed

- Restores the large native on-screen alert when an enemy starts casting a spell or ability.
- Preserves action messages `3`, `327`, and `716` in SimpleLog’s rebuilt `0x28` action packet.
- Keeps the corrected current-client packet layout and repaired combat-log output from v1.1.3-hxi.1.
- Updates the Casting filter to include the third cast-start message category.

### Installation

1. Close HorizonXI.
2. Download and extract the release zip.
3. Replace `HorizonXI\Game\addons\simplelog\` with the included `simplelog` folder.
4. Start HorizonXI and load SimpleLog:
   ```text
   /addon load simplelog
   ```

Use `/slog` to open the existing configuration menu.
