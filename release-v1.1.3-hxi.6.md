## SimpleLog v1.1.3-hxi.6 — TChat-Safe Stability Rollback

This is a stability release addressing an interaction discovered in `v1.1.3-hxi.5`.

> **Important:** This is a HorizonXI compatibility distribution of [Spike2D's SimpleLog](https://github.com/Spike2D/SimpleLog), not an official upstream release. Original credits and licenses are preserved.

### Fixed

- Removes the experimental GDI cast renderer that could clear TChat’s contents when the chat window was maximized or minimized.
- The addon no longer initializes the renderer, creates its sprite resources, hooks GDI drawing into frames, or processes cast packets through that experimental component.
- Retains the repaired incoming action-packet parser and normal SimpleLog combat-log behavior.
- Retains the configuration-window stability corrections.

### Cast alerts

The experimental center-screen enemy cast alert is **intentionally disabled** in this stable build. It will be revisited only with an implementation that does not create a separate rendering conflict with TChat.

### Installation

1. Close HorizonXI completely. This ensures the old renderer event is gone.
2. Download and extract this release zip.
3. Replace `HorizonXI\Game\addons\simplelog\` with the included `simplelog` folder.
4. Start HorizonXI and run:
   ```text
   /addon load simplelog
   ```

After loading, maximize and minimize TChat normally. SimpleLog will no longer own any GDI/sprite drawing resources.
