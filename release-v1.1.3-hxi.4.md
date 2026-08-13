## SimpleLog v1.1.3-hxi.4 — Styled Cast Alert and Menu Stability

This corrective release replaces the experimental plain white alert from v1.1.3-hxi.3 and repairs the configuration-window crash.

> **Important:** This is a HorizonXI compatibility distribution of [Spike2D's SimpleLog](https://github.com/Spike2D/SimpleLog), not an official upstream release. Original credits and licenses are preserved.

### Fixed

- Replaces the plain white text with a **centered, bold, blue-gradient, outlined, no-box** cast alert rendered through SimpleLog’s bundled GDI renderer.
- Reads the original incoming action packet separately from the legacy log parser, so mob names and actions are resolved from the current Ashita entity/resource data.
- Prevents the incorrect `{Unknown:<id>}` display by briefly retrying lookup while a monster entity is still loading.
- Fixes the configuration menu’s unbalanced ImGui state stacks and updates its child-window call for the current Ashita binding.
- Retains the repaired combat-log behavior from prior compatibility updates.

### Installation

1. Close HorizonXI.
2. Download and extract the release zip.
3. Replace `HorizonXI\Game\addons\simplelog\` with the included `simplelog` folder.
4. Start HorizonXI and load it with:
   ```text
   /addon load simplelog
   ```

Open the menu with `/slog` after loading. The updated window should open without crashing.
